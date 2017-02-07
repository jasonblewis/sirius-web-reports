use utf8;
package Reports::Schema::Result::ArCustomer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::ArCustomer

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

=head1 TABLE: C<ar_customer>

=cut

__PACKAGE__->table("ar_customer");

=head1 ACCESSORS

=head2 customer_code

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 customer_search_key

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

=head2 debtor_code

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 ship_from_warehouse

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 sales_class1_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 sales_class2_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 sales_class3_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 sales_rep_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 include_in_sales_report

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 price_code

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 cust_disc_group

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 gets_promo_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 pricing_customer

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 ordernr_rqd

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 account_or_cash

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 sale_or_credit

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 gst_code

  data_type: 'char'
  is_nullable: 1
  size: 3

=head2 invoice_copies

  data_type: 'numeric'
  is_nullable: 1
  size: [3,0]

=head2 ship_doc_pack

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 ship_doc_inv

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 stop_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 active_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 backorders_allowed

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 check_order_qty

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 min_price_code

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 date_created

  data_type: 'datetime'
  is_nullable: 1

=head2 eps_supplier_code

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 ship_via_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 cust_prod_list

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 line_nr_rqd

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 run_code

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 run_sequence

  data_type: 'numeric'
  is_nullable: 1
  size: [5,0]

=head2 freight_code

  data_type: 'char'
  is_nullable: 1
  size: 12

=head2 consolidate_orders_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 wet_exempt_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

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
  size: 7213

=cut

__PACKAGE__->add_columns(
  "customer_code",
  { data_type => "char", is_nullable => 0, size => 10 },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "customer_search_key",
  { data_type => "char", is_nullable => 1, size => 80 },
  "company_code",
  { data_type => "char", is_nullable => 0, size => 10 },
  "branch_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "debtor_code",
  { data_type => "char", is_nullable => 1, size => 10 },
  "ship_from_warehouse",
  { data_type => "char", is_nullable => 1, size => 6 },
  "sales_class1_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "sales_class2_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "sales_class3_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "sales_rep_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "include_in_sales_report",
  { data_type => "char", is_nullable => 0, size => 1 },
  "price_code",
  { data_type => "char", is_nullable => 1, size => 1 },
  "cust_disc_group",
  { data_type => "char", is_nullable => 1, size => 10 },
  "gets_promo_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "pricing_customer",
  { data_type => "char", is_nullable => 1, size => 10 },
  "ordernr_rqd",
  { data_type => "char", is_nullable => 0, size => 1 },
  "account_or_cash",
  { data_type => "char", is_nullable => 0, size => 1 },
  "sale_or_credit",
  { data_type => "char", is_nullable => 0, size => 1 },
  "gst_code",
  { data_type => "char", is_nullable => 1, size => 3 },
  "invoice_copies",
  { data_type => "numeric", is_nullable => 1, size => [3, 0] },
  "ship_doc_pack",
  { data_type => "char", is_nullable => 0, size => 1 },
  "ship_doc_inv",
  { data_type => "char", is_nullable => 0, size => 1 },
  "stop_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "active_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "backorders_allowed",
  { data_type => "char", is_nullable => 0, size => 1 },
  "check_order_qty",
  { data_type => "char", is_nullable => 0, size => 1 },
  "min_price_code",
  { data_type => "char", is_nullable => 1, size => 1 },
  "date_created",
  { data_type => "datetime", is_nullable => 1 },
  "eps_supplier_code",
  { data_type => "char", is_nullable => 1, size => 20 },
  "ship_via_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "cust_prod_list",
  { data_type => "char", is_nullable => 1, size => 10 },
  "line_nr_rqd",
  { data_type => "char", is_nullable => 0, size => 1 },
  "run_code",
  { data_type => "char", is_nullable => 1, size => 10 },
  "run_sequence",
  { data_type => "numeric", is_nullable => 1, size => [5, 0] },
  "freight_code",
  { data_type => "char", is_nullable => 1, size => 12 },
  "consolidate_orders_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "wet_exempt_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
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
  { data_type => "varchar", is_nullable => 1, size => 7213 },
);

=head1 PRIMARY KEY

=over 4

=item * L</customer_code>

=back

=cut

__PACKAGE__->set_primary_key("customer_code");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-09 12:00:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GLTpVGbYIOak1hZWnMESzQ

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
  "company" =>
    'Reports::Schema::Result::Company',
  'company_code',
);

__PACKAGE__->belongs_to(
  "ar_debtor" =>
    'Reports::Schema::Result::ArDebtor',
  'debtor_code',
);

__PACKAGE__->has_many(
  'most_recent_purchases' =>
    'Reports::Schema::Result::ZzMostRecentPurchase',
  'customer_code',
);

__PACKAGE__->has_many(
  "sh_transactions" =>
    'Reports::Schema::Result::ShTransaction',
  'customer_code',
);



1;
