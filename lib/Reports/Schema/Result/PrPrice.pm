use utf8;
package Reports::Schema::Result::PrPrice;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::PrPrice

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

=head1 TABLE: C<pr_price>

=cut

__PACKAGE__->table("pr_price");

=head1 ACCESSORS

=head2 product_code

  data_type: 'char'
  is_nullable: 0
  size: 16

=head2 price_code

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 start_date

  data_type: 'datetime'
  is_nullable: 0

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 price

  data_type: 'double precision'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "product_code",
  { data_type => "char", is_nullable => 0, size => 16 },
  "price_code",
  { data_type => "char", is_nullable => 0, size => 1 },
  "start_date",
  { data_type => "datetime", is_nullable => 0 },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "price",
  { data_type => "double precision", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</product_code>

=item * L</price_code>

=item * L</start_date>

=back

=cut

__PACKAGE__->set_primary_key("product_code", "price_code", "start_date");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-03-23 15:46:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6mv5d64Z6x7SwB6RWl2uNQ


__PACKAGE__->belongs_to(
  product =>
    'Reports::Schema::Result::InProduct',
  'product_code',
);

1;
