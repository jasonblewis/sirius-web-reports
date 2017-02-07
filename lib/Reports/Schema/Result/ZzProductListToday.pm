use utf8;
package Reports::Schema::Result::ZzProductListToday;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::ZzProductListToday

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

=head1 TABLE: C<zz_product_list_today>

=cut

__PACKAGE__->table("zz_product_list_today");

=head1 ACCESSORS

=head2 product_code

  data_type: 'char'
  is_nullable: 0
  size: 16

=head2 description

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 unitprice

  data_type: 'double precision'
  is_nullable: 1

=head2 cartonprice

  data_type: 'double precision'
  is_nullable: 1

=head2 cartonsize

  data_type: 'numeric'
  is_nullable: 1
  size: [8,0]

=head2 retail_price

  data_type: 'double precision'
  is_nullable: 1

=head2 gst_code

  data_type: 'char'
  is_nullable: 1
  size: 3

=head2 unit

  data_type: 'char'
  is_nullable: 1
  size: 4

=head2 weight

  data_type: 'double precision'
  is_nullable: 1

=head2 barcode

  data_type: 'char'
  is_nullable: 1
  size: 32

=head2 donotlist

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 cartononly

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 dist_price

  data_type: 'double precision'
  is_nullable: 1

=head2 spare_flag_03

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 spare_flag_04

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 spare_flag_05

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 spare_flag_06

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 spare_flag_07

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 spare_flag_08

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 spare_flag_09

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 spare_flag_10

  data_type: 'char'
  is_nullable: 1
  size: 1

=cut

__PACKAGE__->add_columns(
  "product_code",
  { data_type => "char", is_nullable => 0, size => 16 },
  "description",
  { data_type => "char", is_nullable => 1, size => 40 },
  "unitprice",
  { data_type => "double precision", is_nullable => 1 },
  "cartonprice",
  { data_type => "double precision", is_nullable => 1 },
  "cartonsize",
  { data_type => "numeric", is_nullable => 1, size => [8, 0] },
  "retail_price",
  { data_type => "double precision", is_nullable => 1 },
  "gst_code",
  { data_type => "char", is_nullable => 1, size => 3 },
  "unit",
  { data_type => "char", is_nullable => 1, size => 4 },
  "weight",
  { data_type => "double precision", is_nullable => 1 },
  "barcode",
  { data_type => "char", is_nullable => 1, size => 32 },
  "donotlist",
  { data_type => "char", is_nullable => 1, size => 1 },
  "cartononly",
  { data_type => "char", is_nullable => 1, size => 1 },
  "dist_price",
  { data_type => "double precision", is_nullable => 1 },
  "spare_flag_03",
  { data_type => "char", is_nullable => 1, size => 1 },
  "spare_flag_04",
  { data_type => "char", is_nullable => 1, size => 1 },
  "spare_flag_05",
  { data_type => "char", is_nullable => 1, size => 1 },
  "spare_flag_06",
  { data_type => "char", is_nullable => 1, size => 1 },
  "spare_flag_07",
  { data_type => "char", is_nullable => 1, size => 1 },
  "spare_flag_08",
  { data_type => "char", is_nullable => 1, size => 1 },
  "spare_flag_09",
  { data_type => "char", is_nullable => 1, size => 1 },
  "spare_flag_10",
  { data_type => "char", is_nullable => 1, size => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-09 12:00:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dEi3CFNjUeIOhWmW0z3q4A

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

__PACKAGE__->set_primary_key("product_code");


__PACKAGE__->belongs_to(
  'product' =>
    'Reports::Schema::Result::InProduct',
  'product_code',
);

sub cartonprice_2dp {
  my ($self, $col_data) = @_;
  return sprintf("%.2f",$self->cartonprice);
};

sub unitpice_2dp {
  my ($self, $col_data) = @_;
  return sprintf("%.2f",$self->unitprice);
};

sub unitprice_2dp_na {
  my ($self, $col_data) = @_;

  if (length($self->cartononly)) {
    return "N/A";
  } else {
    return sprintf("%.2f",$self->unitprice);
  }
}

1;
