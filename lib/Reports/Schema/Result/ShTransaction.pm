use utf8;
package Reports::Schema::Result::ShTransaction;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::ShTransaction

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

=head1 TABLE: C<sh_transaction>

=cut

__PACKAGE__->table("sh_transaction");

=head1 ACCESSORS

=head2 trans

  data_type: 'numeric'
  is_nullable: 0
  size: [11,0]

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 branch_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 warehouse_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 sales_rep_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 customer_code

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 ship_to_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 department

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 group_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 sub_group

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 industry_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 price_code

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 territory_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 product_code

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 supplier_code

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 invoice_nr

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 invoice_date

  data_type: 'datetime'
  is_nullable: 0

=head2 spare_1

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 spare_2

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 spare_3

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 sales_qty

  data_type: 'double precision'
  is_nullable: 1

=head2 sales_amt

  data_type: 'double precision'
  is_nullable: 1

=head2 cost_amt

  data_type: 'double precision'
  is_nullable: 1

=head2 profit_amt

  data_type: 'double precision'
  is_nullable: 1

=head2 gp_perc

  data_type: 'double precision'
  is_nullable: 1

=head2 weight

  data_type: 'double precision'
  is_nullable: 1

=head2 rebate_amt

  data_type: 'double precision'
  is_nullable: 1

=head2 sbupdate

  data_type: 'char'
  is_nullable: 1
  size: 1

=cut

__PACKAGE__->add_columns(
  "trans",
  { data_type => "numeric", is_nullable => 0, size => [11, 0] },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "branch_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "warehouse_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "sales_rep_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "customer_code",
  { data_type => "char", is_nullable => 1, size => 10 },
  "ship_to_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "department",
  { data_type => "char", is_nullable => 1, size => 6 },
  "group_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "sub_group",
  { data_type => "char", is_nullable => 1, size => 6 },
  "industry_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "price_code",
  { data_type => "char", is_nullable => 1, size => 1 },
  "territory_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "product_code",
  { data_type => "char", is_nullable => 1, size => 16 },
  "supplier_code",
  { data_type => "char", is_nullable => 1, size => 10 },
  "invoice_nr",
  { data_type => "char", is_nullable => 1, size => 10 },
  "invoice_date",
  { data_type => "datetime", is_nullable => 0 },
  "spare_1",
  { data_type => "char", is_nullable => 1, size => 16 },
  "spare_2",
  { data_type => "char", is_nullable => 1, size => 16 },
  "spare_3",
  { data_type => "char", is_nullable => 1, size => 16 },
  "sales_qty",
  { data_type => "double precision", is_nullable => 1 },
  "sales_amt",
  { data_type => "double precision", is_nullable => 1 },
  "cost_amt",
  { data_type => "double precision", is_nullable => 1 },
  "profit_amt",
  { data_type => "double precision", is_nullable => 1 },
  "gp_perc",
  { data_type => "double precision", is_nullable => 1 },
  "weight",
  { data_type => "double precision", is_nullable => 1 },
  "rebate_amt",
  { data_type => "double precision", is_nullable => 1 },
  "sbupdate",
  { data_type => "char", is_nullable => 1, size => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</trans>

=back

=cut

__PACKAGE__->set_primary_key("trans");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-03-14 15:03:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lQq95DOOqCSAIoQUx2N7Bg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
