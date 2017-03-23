use utf8;
package Reports::Schema::Result::ApSupplierSelectView;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::ApSupplierSelectView

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

=head1 TABLE: C<ap_supplier_select_view>

=cut

__PACKAGE__->table("ap_supplier_select_view");

=head1 ACCESSORS

=head2 supplier_code

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 supplier_search_key

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 company_code

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 name

  data_type: 'char'
  is_nullable: 0
  size: 40

=head2 uppercase_name

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 address_1

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 address_2

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 address_3

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 postcode

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 industry_code

  data_type: 'char'
  is_nullable: 0
  size: 6

=head2 territory_code

  data_type: 'char'
  is_nullable: 0
  size: 6

=head2 abn

  data_type: 'char'
  is_nullable: 1
  size: 12

=head2 branch_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 creditor_code

  data_type: 'char'
  is_nullable: 1
  size: 10

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

=head2 lead_time_days

  data_type: 'numeric'
  is_nullable: 1
  size: [4,0]

=head2 date_created

  data_type: 'datetime'
  is_nullable: 1

=head2 currency_code

  data_type: 'char'
  is_nullable: 0
  size: 6

=head2 po_format

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 invoice_format

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 check_cost_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 check_price_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

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

=head2 ship_via_code

  data_type: 'char'
  is_nullable: 1
  size: 6

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

=cut

__PACKAGE__->add_columns(
  "supplier_code",
  { data_type => "char", is_nullable => 0, size => 10 },
  "supplier_search_key",
  { data_type => "char", is_nullable => 1, size => 80 },
  "company_code",
  { data_type => "char", is_nullable => 0, size => 10 },
  "name",
  { data_type => "char", is_nullable => 0, size => 40 },
  "uppercase_name",
  { data_type => "char", is_nullable => 1, size => 40 },
  "address_1",
  { data_type => "char", is_nullable => 1, size => 40 },
  "address_2",
  { data_type => "char", is_nullable => 1, size => 40 },
  "address_3",
  { data_type => "char", is_nullable => 1, size => 40 },
  "postcode",
  { data_type => "char", is_nullable => 1, size => 10 },
  "industry_code",
  { data_type => "char", is_nullable => 0, size => 6 },
  "territory_code",
  { data_type => "char", is_nullable => 0, size => 6 },
  "abn",
  { data_type => "char", is_nullable => 1, size => 12 },
  "branch_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "creditor_code",
  { data_type => "char", is_nullable => 1, size => 10 },
  "discount_group_code",
  { data_type => "char", is_nullable => 1, size => 1 },
  "national_supplier",
  { data_type => "char", is_nullable => 0, size => 10 },
  "national_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "stop_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "active_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "branch_supplier",
  { data_type => "char", is_nullable => 0, size => 1 },
  "lead_time_days",
  { data_type => "numeric", is_nullable => 1, size => [4, 0] },
  "date_created",
  { data_type => "datetime", is_nullable => 1 },
  "currency_code",
  { data_type => "char", is_nullable => 0, size => 6 },
  "po_format",
  { data_type => "char", is_nullable => 1, size => 1 },
  "invoice_format",
  { data_type => "char", is_nullable => 0, size => 1 },
  "check_cost_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "check_price_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "ra_required",
  { data_type => "char", is_nullable => 0, size => 1 },
  "eps_customer_code",
  { data_type => "char", is_nullable => 1, size => 20 },
  "gst_code",
  { data_type => "char", is_nullable => 1, size => 3 },
  "ship_via_code",
  { data_type => "char", is_nullable => 1, size => 6 },
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
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-23 16:07:34
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6bsEn5VxG/q8krTK3iCJRw

__PACKAGE__->set_primary_key("supplier_code");

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
