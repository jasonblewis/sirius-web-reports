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

=head2 update_contact($xero_app, $contact_id, $json)

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

=head2 get_invoices_by_contact_id($contact_id)

Returns all invoices for given C<$contact_id>.

=cut

sub get_invoices_by_contact_id {
    my ($self, $contact_id) = @_;

    return $self->_xero_api_call(
        subject => 'Invoices',
        method => 'GET',
        params => "ContactIDs=$contact_id",
    );
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
