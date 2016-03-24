use utf8;
package Reports::Schema::Result::ZzMostRecentPurchase;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::ZzMostRecentPurchase

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");
__PACKAGE__->table_class("DBIx::Class::ResultSource::View");

=head1 TABLE: C<zz_most_recent_purchase>

=cut

__PACKAGE__->table("zz_most_recent_purchase");

=head1 ACCESSORS

=head2 customer_code

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 product_code

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 invoice_date

  data_type: 'datetime'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "customer_code",
  { data_type => "char", is_nullable => 1, size => 10 },
  "product_code",
  { data_type => "char", is_nullable => 1, size => 16 },
  "invoice_date",
  { data_type => "datetime", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-03-17 16:33:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:h/X5BdoYmyBgsNeH9fFeLw

__PACKAGE__->belongs_to(
  "ar_customer" =>
    'Reports::Schema::Result::ArCustomer',
  'customer_code',
);

__PACKAGE__->belongs_to(
  "sh_transaction" =>
    'Reports::Schema::Result::ShTransaction',
  {'foreign.customer_code' => 'self.customer_code',
   'foreign.product_code' => 'self.product_code',
   'foreign.invoice_date' => 'self.invoice_date',
 }
);

1;
