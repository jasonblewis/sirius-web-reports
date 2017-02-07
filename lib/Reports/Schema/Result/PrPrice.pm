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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-09 12:00:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:czJcvLcWn2pIHbIa4Mey4Q

# Copyright 2017 Jason Lewis

# This file is part of Sirius Web Reports.

#     Sirius Web Reports is free software: you can redistribute it and/or modify
#     it under the terms of the GNU Affero Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.

#     Sirius Web Reports is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU Affero Public License for more details.

#     You should have received a copy of the GNU Affero Public License
#     along with Sirius Web Reports.  If not, see <http://www.gnu.org/licenses/>.

__PACKAGE__->belongs_to(
  product =>
    'Reports::Schema::Result::InProduct',
  'product_code',
);

1;
