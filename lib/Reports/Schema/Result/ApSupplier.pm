use utf8;
package Reports::Schema::Result::ApSupplier;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::ApSupplier

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

=head1 TABLE: C<ap_supplier>

=cut

__PACKAGE__->table("ap_supplier");

=head1 ACCESSORS

=head2 supplier_code

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 supplier_search_key

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 company_code

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 branch_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 creditor_code

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 currency_code

  data_type: 'char'
  is_nullable: 0
  size: 6

=head2 discount_group_code

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 national_supplier

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 national_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 po_format

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 invoice_format

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 reorder_type

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 stop_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 active_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 branch_supplier

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 date_created

  data_type: 'datetime'
  is_nullable: 1

=head2 planner_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 check_cost_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 check_price_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 ship_via_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 ra_required

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 eps_customer_code

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 gst_code

  data_type: 'char'
  is_nullable: 1
  size: 3

=head2 lead_time_days

  data_type: 'numeric'
  is_nullable: 1
  size: [4,0]

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
  size: 7295

=cut

__PACKAGE__->add_columns(
  "supplier_code",
  { data_type => "char", is_nullable => 0, size => 10 },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "supplier_search_key",
  { data_type => "char", is_nullable => 1, size => 80 },
  "company_code",
  { data_type => "char", is_nullable => 0, size => 10 },
  "branch_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "creditor_code",
  { data_type => "char", is_nullable => 1, size => 10 },
  "currency_code",
  { data_type => "char", is_nullable => 0, size => 6 },
  "discount_group_code",
  { data_type => "char", is_nullable => 1, size => 1 },
  "national_supplier",
  { data_type => "char", is_nullable => 0, size => 10 },
  "national_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "po_format",
  { data_type => "char", is_nullable => 1, size => 1 },
  "invoice_format",
  { data_type => "char", is_nullable => 0, size => 1 },
  "reorder_type",
  { data_type => "char", is_nullable => 1, size => 1 },
  "stop_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "active_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "branch_supplier",
  { data_type => "char", is_nullable => 0, size => 1 },
  "date_created",
  { data_type => "datetime", is_nullable => 1 },
  "planner_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "check_cost_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "check_price_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "ship_via_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "ra_required",
  { data_type => "char", is_nullable => 0, size => 1 },
  "eps_customer_code",
  { data_type => "char", is_nullable => 1, size => 20 },
  "gst_code",
  { data_type => "char", is_nullable => 1, size => 3 },
  "lead_time_days",
  { data_type => "numeric", is_nullable => 1, size => [4, 0] },
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
  { data_type => "varchar", is_nullable => 1, size => 7295 },
);

=head1 PRIMARY KEY

=over 4

=item * L</supplier_code>

=back

=cut

__PACKAGE__->set_primary_key("supplier_code");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-09 12:00:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/ni0bNQq/4rjxPKN28VgTQ

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


#__PACKAGE__->has_many('supplier_code' => 'Reports::Schema::DboInProduct','primary_supplier');

__PACKAGE__->belongs_to(
    company =>
        'Reports::Schema::Result::Company',
    'company_code',
);


1;
