use utf8;
package Reports::Schema::Result::InProduct;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::InProduct

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

=head1 TABLE: C<in_product>

=cut

__PACKAGE__->table("in_product");

=head1 ACCESSORS

=head2 product_code

  data_type: 'char'
  is_nullable: 0
  size: 16

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 description

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 uppercase_desc

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 also_known_as

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 alias

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 primary_supplier

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 ship_from_warehouse

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 deposit

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 unit

  data_type: 'char'
  is_nullable: 1
  size: 4

=head2 weight

  data_type: 'double precision'
  is_nullable: 1

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

=head2 standard_cost

  data_type: 'double precision'
  is_nullable: 1

=head2 non_diminishing

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 batch_numbered

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 serial_numbered

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 prod_disc_group

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 qty_break_group

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 qty_break_flag

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 price_per

  data_type: 'numeric'
  is_nullable: 0
  size: [7,0]

=head2 tax_rate

  data_type: 'double precision'
  is_nullable: 1

=head2 gst_code

  data_type: 'char'
  is_nullable: 1
  size: 3

=head2 allocation_method

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 manual_allocation

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 costing_method

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 include_in_sales_report

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 active_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 gl_sales

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 gl_cogs

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 gl_inventory

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 gl_tax

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 gl_purchases

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 points_code

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 check_order_qty

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 capture_demand

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 date_created

  data_type: 'datetime'
  is_nullable: 0

=head2 demand_start_date

  data_type: 'datetime'
  is_nullable: 1

=head2 price_labels_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 external_service_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 markup_group

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 qty_per_carton

  data_type: 'numeric'
  is_nullable: 1
  size: [6,0]

=head2 units_per_carton

  data_type: 'numeric'
  is_nullable: 1
  size: [6,0]

=head2 bottle_size

  data_type: 'numeric'
  is_nullable: 1
  size: [6,0]

=head2 wet_rate

  data_type: 'double precision'
  is_nullable: 1

=head2 so_entry_warning

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 warehouse_warning

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 invoice_warning

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 spare_code_01

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_code_02

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_code_03

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_code_04

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_code_05

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_code_06

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_code_07

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_code_08

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_code_09

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_code_10

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_flag_01

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 spare_flag_02

  data_type: 'char'
  is_nullable: 1
  size: 1

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

=head2 spare_value_01

  data_type: 'double precision'
  is_nullable: 1

=head2 spare_value_02

  data_type: 'double precision'
  is_nullable: 1

=head2 spare_value_03

  data_type: 'double precision'
  is_nullable: 1

=head2 spare_value_04

  data_type: 'double precision'
  is_nullable: 1

=head2 spare_value_05

  data_type: 'double precision'
  is_nullable: 1

=head2 spare_value_06

  data_type: 'double precision'
  is_nullable: 1

=head2 spare_value_07

  data_type: 'double precision'
  is_nullable: 1

=head2 spare_value_08

  data_type: 'double precision'
  is_nullable: 1

=head2 spare_value_09

  data_type: 'double precision'
  is_nullable: 1

=head2 spare_value_10

  data_type: 'double precision'
  is_nullable: 1

=head2 sst_spare_code_01

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 sst_spare_code_02

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 sst_spare_code_03

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 sst_spare_code_04

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 sst_spare_code_05

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 sst_spare_flag_01

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 sst_spare_flag_02

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 sst_spare_flag_03

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 sst_spare_flag_04

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 sst_spare_flag_05

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 sst_spare_value_01

  data_type: 'double precision'
  is_nullable: 1

=head2 sst_spare_value_02

  data_type: 'double precision'
  is_nullable: 1

=head2 sst_spare_value_03

  data_type: 'double precision'
  is_nullable: 1

=head2 sst_spare_value_04

  data_type: 'double precision'
  is_nullable: 1

=head2 sst_spare_value_05

  data_type: 'double precision'
  is_nullable: 1

=head2 notes

  data_type: 'varchar'
  is_nullable: 1
  size: 6791

=cut

__PACKAGE__->add_columns(
  "product_code",
  { data_type => "char", is_nullable => 0, size => 16 },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "description",
  { data_type => "char", is_nullable => 1, size => 40 },
  "uppercase_desc",
  { data_type => "char", is_nullable => 1, size => 40 },
  "also_known_as",
  { data_type => "char", is_nullable => 1, size => 16 },
  "alias",
  { data_type => "char", is_nullable => 1, size => 40 },
  "primary_supplier",
  { data_type => "char", is_nullable => 1, size => 10 },
  "ship_from_warehouse",
  { data_type => "char", is_nullable => 1, size => 6 },
  "deposit",
  { data_type => "char", is_nullable => 1, size => 16 },
  "unit",
  { data_type => "char", is_nullable => 1, size => 4 },
  "weight",
  { data_type => "double precision", is_nullable => 1 },
  "department",
  { data_type => "char", is_nullable => 1, size => 6 },
  "group_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "sub_group",
  { data_type => "char", is_nullable => 1, size => 6 },
  "standard_cost",
  { data_type => "double precision", is_nullable => 1 },
  "non_diminishing",
  { data_type => "char", is_nullable => 0, size => 1 },
  "batch_numbered",
  { data_type => "char", is_nullable => 0, size => 1 },
  "serial_numbered",
  { data_type => "char", is_nullable => 0, size => 1 },
  "prod_disc_group",
  { data_type => "char", is_nullable => 1, size => 10 },
  "qty_break_group",
  { data_type => "char", is_nullable => 1, size => 6 },
  "qty_break_flag",
  { data_type => "char", is_nullable => 1, size => 1 },
  "price_per",
  { data_type => "numeric", is_nullable => 0, size => [7, 0] },
  "tax_rate",
  { data_type => "double precision", is_nullable => 1 },
  "gst_code",
  { data_type => "char", is_nullable => 1, size => 3 },
  "allocation_method",
  { data_type => "char", is_nullable => 0, size => 1 },
  "manual_allocation",
  { data_type => "char", is_nullable => 0, size => 1 },
  "costing_method",
  { data_type => "char", is_nullable => 0, size => 1 },
  "include_in_sales_report",
  { data_type => "char", is_nullable => 0, size => 1 },
  "active_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "gl_sales",
  { data_type => "char", is_nullable => 1, size => 20 },
  "gl_cogs",
  { data_type => "char", is_nullable => 1, size => 20 },
  "gl_inventory",
  { data_type => "char", is_nullable => 1, size => 20 },
  "gl_tax",
  { data_type => "char", is_nullable => 1, size => 20 },
  "gl_purchases",
  { data_type => "char", is_nullable => 1, size => 20 },
  "points_code",
  { data_type => "char", is_nullable => 0, size => 1 },
  "check_order_qty",
  { data_type => "char", is_nullable => 0, size => 1 },
  "capture_demand",
  { data_type => "char", is_nullable => 0, size => 1 },
  "date_created",
  { data_type => "datetime", is_nullable => 0 },
  "demand_start_date",
  { data_type => "datetime", is_nullable => 1 },
  "price_labels_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "external_service_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "markup_group",
  { data_type => "char", is_nullable => 1, size => 10 },
  "qty_per_carton",
  { data_type => "numeric", is_nullable => 1, size => [6, 0] },
  "units_per_carton",
  { data_type => "numeric", is_nullable => 1, size => [6, 0] },
  "bottle_size",
  { data_type => "numeric", is_nullable => 1, size => [6, 0] },
  "wet_rate",
  { data_type => "double precision", is_nullable => 1 },
  "so_entry_warning",
  { data_type => "char", is_nullable => 1, size => 80 },
  "warehouse_warning",
  { data_type => "char", is_nullable => 1, size => 80 },
  "invoice_warning",
  { data_type => "char", is_nullable => 1, size => 80 },
  "spare_code_01",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_code_02",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_code_03",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_code_04",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_code_05",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_code_06",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_code_07",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_code_08",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_code_09",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_code_10",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_flag_01",
  { data_type => "char", is_nullable => 1, size => 1 },
  "spare_flag_02",
  { data_type => "char", is_nullable => 1, size => 1 },
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
  "spare_value_01",
  { data_type => "double precision", is_nullable => 1 },
  "spare_value_02",
  { data_type => "double precision", is_nullable => 1 },
  "spare_value_03",
  { data_type => "double precision", is_nullable => 1 },
  "spare_value_04",
  { data_type => "double precision", is_nullable => 1 },
  "spare_value_05",
  { data_type => "double precision", is_nullable => 1 },
  "spare_value_06",
  { data_type => "double precision", is_nullable => 1 },
  "spare_value_07",
  { data_type => "double precision", is_nullable => 1 },
  "spare_value_08",
  { data_type => "double precision", is_nullable => 1 },
  "spare_value_09",
  { data_type => "double precision", is_nullable => 1 },
  "spare_value_10",
  { data_type => "double precision", is_nullable => 1 },
  "sst_spare_code_01",
  { data_type => "char", is_nullable => 1, size => 20 },
  "sst_spare_code_02",
  { data_type => "char", is_nullable => 1, size => 20 },
  "sst_spare_code_03",
  { data_type => "char", is_nullable => 1, size => 20 },
  "sst_spare_code_04",
  { data_type => "char", is_nullable => 1, size => 20 },
  "sst_spare_code_05",
  { data_type => "char", is_nullable => 1, size => 20 },
  "sst_spare_flag_01",
  { data_type => "char", is_nullable => 1, size => 1 },
  "sst_spare_flag_02",
  { data_type => "char", is_nullable => 1, size => 1 },
  "sst_spare_flag_03",
  { data_type => "char", is_nullable => 1, size => 1 },
  "sst_spare_flag_04",
  { data_type => "char", is_nullable => 1, size => 1 },
  "sst_spare_flag_05",
  { data_type => "char", is_nullable => 1, size => 1 },
  "sst_spare_value_01",
  { data_type => "double precision", is_nullable => 1 },
  "sst_spare_value_02",
  { data_type => "double precision", is_nullable => 1 },
  "sst_spare_value_03",
  { data_type => "double precision", is_nullable => 1 },
  "sst_spare_value_04",
  { data_type => "double precision", is_nullable => 1 },
  "sst_spare_value_05",
  { data_type => "double precision", is_nullable => 1 },
  "notes",
  { data_type => "varchar", is_nullable => 1, size => 6791 },
);

=head1 PRIMARY KEY

=over 4

=item * L</product_code>

=back

=cut

__PACKAGE__->set_primary_key("product_code");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-09 12:00:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BxjO9q17iPa53R6Xgc6K5A

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

#__PACKAGE__->belongs_to('ap_supplier' => 'Reports::Schema::Result::ApSupplier','primary_supplier');

__PACKAGE__->has_many(
  sh_transactions =>
    'Reports::Schema::Result::ShTransaction',
  'product_code'
);

__PACKAGE__->has_many(
  prices =>
    'Reports::Schema::Result::PrPrice',
  'product_code'
);

__PACKAGE__->has_many(
  product_list_today =>
    'Reports::Schema::Result::ZzProductListToday',
  'product_code'
);

__PACKAGE__->belongs_to(
  gst_tax_table =>
    'Reports::Schema::Result::GstTaxTable',
  'gst_code'
);

__PACKAGE__->belongs_to(
  department =>
    'Reports::Schema::Result::InDepartment',
  'department'
);


1;
