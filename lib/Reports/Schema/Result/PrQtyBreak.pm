use utf8;
package Reports::Schema::Result::PrQtyBreak;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::PrQtyBreak

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

=head1 TABLE: C<pr_qty_break>

=cut

__PACKAGE__->table("pr_qty_break");

=head1 ACCESSORS

=head2 product_code

  data_type: 'char'
  is_nullable: 0
  size: 16

=head2 break_qty

  data_type: 'numeric'
  is_nullable: 0
  size: [8,0]

=head2 start_date

  data_type: 'datetime'
  is_nullable: 0

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 discount_perc

  data_type: 'double precision'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "product_code",
  { data_type => "char", is_nullable => 0, size => 16 },
  "break_qty",
  { data_type => "numeric", is_nullable => 0, size => [8, 0] },
  "start_date",
  { data_type => "datetime", is_nullable => 0 },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "discount_perc",
  { data_type => "double precision", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</product_code>

=item * L</break_qty>

=item * L</start_date>

=back

=cut

__PACKAGE__->set_primary_key("product_code", "break_qty", "start_date");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-09 12:00:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:k8g5a2LO9jdp9nph+qqnWw

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

1;
