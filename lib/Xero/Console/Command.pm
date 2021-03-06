package Xero::Console::Command;

use Moo;
use Types::Standard qw/InstanceOf/;

use Data::Dumper;

use JSON::MaybeXS;
use WebService::Xero::Agent::PrivateApplication;
use namespace::clean;

# required parameters for private application
has consumer_key => (
    is => 'ro',
    required => 1,
);

has consumer_secret => (
    is => 'ro',
    required => 1,
);

has private_key => (
    is => 'ro',
    required => 1,
);

# xero private application object
has xero_app => (
    is => 'lazy',
    isa => InstanceOf['WebService::Xero::Agent::PrivateApplication'],
);

sub _build_xero_app {
    my $self = shift;

    my $app = WebService::Xero::Agent::PrivateApplication->new(
        CONSUMER_KEY    => $self->consumer_key,
        CONSUMER_SECRET => $self->consumer_secret,
        PRIVATE_KEY     => $self->private_key,
    );

    return $app;
}

=head1 Contacts

L<https://developer.xero.com/documentation/api/contacts>

=head2 get_contacts

Returns list of contacts.

=cut

sub get_contacts {
    my ($self) = @_;

    my $contact_list = $self->_xero_api_call(
        subject => 'Contacts',
        method => 'GET',
    );

    return $contact_list;
}

=head2 create_contact($data)

Create contact from C<$data>.

=cut

sub create_contact {
    my ($self, $data) = @_;

    my $contact = $self->_xero_api_call(
        subject => 'Contacts',
        method => 'POST',
        json => $data,
    );

    return $contact;
}

=head2 update_contact($contact_id, $json)

Update contact with id $contact_id. Data provided within $json.

=cut

sub update_contact {
    my ($self, $contact_id, $json) = @_;

    my $contact = $self->_xero_api_call(
        subject => 'Contacts',
        object_id => $contact_id,
        method => 'POST',
        json => $json,
    );
}

=head1 Invoices

L<https://developer.xero.com/documentation/api/invoices>.

=head2 get_invoices($record_filter)

Returns list of invoices.

Filters the list by C<$record_filter> parameter, which can be either
an invoice number or invoice id.

=cut

sub get_invoices {
    my ($self, $record_filter) = @_;

    return $self->_xero_api_call(
        subject => 'Invoices',
        method => 'GET',
        object_id => $record_filter,
    );
}

=head2 get_invoices_by_contact_id($contact_id)

Returns all invoices for given C<$contact_id>.

This method uses paging to get all available records.

=cut

sub get_invoices_by_contact_id {
    my ($self, $contact_id) = @_;

    return $self->_get_invoices(
        'ContactIDs' => $contact_id,
    );
}

# internal method for getting invoices

sub _get_invoices {
    my ($self, %invoice_args) = @_;
    my %params;
    my @invoice_list;

    # static arguments for API call
    my %call_args = (
        subject => 'Invoices',
        method => 'GET',
    );

    if ($invoice_args{'ContactIDs'}) {
        my $cids = delete $invoice_args{'ContactIDs'};

        $params{ContactIDs} = $cids;
    }

    my $page = 1;
    my $records = 100;

    while ($records == 100) {
        $params{page} = $page++;

        my $query_string = join ('&', map { "$_=$params{$_}" } (keys %params));

        my $result = $self->_xero_api_call(
            %call_args,
            params => $query_string,
        );

        my $invoices = $result->{Invoices};

        $records = scalar(@$invoices);

        push @invoice_list, @$invoices;
    }

    return \@invoice_list;
}

=head1 Items

L<https://developer.xero.com/documentation/api/items>

=head2 get_item($sku)

Get item for inventory code C<$sku>.

=cut

sub get_item {
    my ($self, $sku) = @_;

    my $result = $self->_xero_api_call(
        subject => 'Items',
        method => 'GET',
        object_id => $sku
    );

    if (! defined $result) {
        # Item doesn't exist
        return;
    }

    my @items = @{ $result->{Items} };

    if (@items) {
        return $items[0];
    }
}

=head2 create_item($data)

Create an item from C<$data>.

=cut

sub create_item {
    my ($self, $data) = @_;

    my $result = $self->_xero_api_call( subject => 'Items',
                                        method => 'POST',
                                        json => $data );
}

=head1 Accounts

L<https://developer.xero.com/documentation/api/accounts>

=head2 get_accounts

Returns list of accounts.

=cut

sub get_accounts {
    my ($self) = @_;

    my $account_list = $self->_xero_api_call(
        subject => 'Accounts',
        method => 'GET',
    );

    return $account_list;
}

=head2 create_account($data)

Create an account from C<$data>.

=cut

sub create_account {
    my ($self, $data) = @_;

    my $account = $self->_xero_api_call(
        subject => 'Accounts',
        method => 'PUT',
        json => $data,
    );

    return $account;
}

=head1 Currencies

L<https://developer.xero.com/documentation/api/currencies>

=head2 get_currencies

Returns list of currencies.

=cut

sub get_currencies {
    my ($self) = @_;

    my $currency_list = $self->_xero_api_call(
        subject => 'Currencies',
        method => 'GET',
    );

    return $currency_list;
}

=head2 add_currency($data)

Adds an currency from C<$data>.

=cut

sub add_currency {
    my ($self, $json) = @_;

    my $currency_result = $self->_xero_api_call(
        subject => 'Currencies',
        method => 'PUT',
        json => $json,
    );

    return $currency_result;
}

=head1 Tax Rates

L<https://developer.xero.com/documentation/api/tax-rates>


=cut

=head2 get_tax_rates

Returns list of currencies.

=cut

sub get_tax_rates {
    my ($self) = @_;

    my $tax_rate_list = $self->_xero_api_call(
        subject => 'TaxRates',
        method => 'GET',
    );

    return $tax_rate_list;
}

sub _xero_api_call {
    my ($self, %args) = @_;
    my ($result, $json, $uri, $params);

    $uri = 'https://api.xero.com/api.xro/' . '2.0' . '/' . $args{subject};

    if ($args{object_id}) {
        $uri .= '/'. $args{object_id};
    }

    if ($args{method} eq 'POST') {
        $json = $args{json};
    }
    elsif ($params = $args{params}) {
        if ($params =~ /=/) {
            $uri .= '?' . $params;
        }
        else {
            $uri .= '/' . $params;
        }
    }

#    print "Calling URI $uri with method $args{method}.\n";

    $result = $self->xero_app->do_xero_api_call(
        $uri, $args{method}, $args{json},
    );

#    print "Result: ", Dumper($result);
    return $result;
}

1;
