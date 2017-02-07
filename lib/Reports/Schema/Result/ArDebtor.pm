use utf8;
package Reports::Schema::Result::ArDebtor;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::ArDebtor

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

=head1 TABLE: C<ar_debtor>

=cut

__PACKAGE__->table("ar_debtor");

=head1 ACCESSORS

=head2 debtor_code

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 debtor_search_key

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 company_code

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 debtor_type

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 bank_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 bank_branch

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 bsb_number

  data_type: 'char'
  is_nullable: 1
  size: 15

=head2 account_number

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 account_name

  data_type: 'char'
  is_nullable: 1
  size: 32

=head2 credit_card_no

  data_type: 'numeric'
  is_nullable: 1
  size: [22,0]

=head2 credit_card_exp

  data_type: 'datetime'
  is_nullable: 1

=head2 credit_card_name

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 credit_card_auth

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 payment_type

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 term_code

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 ignore_credit_check

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 credit_days

  data_type: 'numeric'
  is_nullable: 1
  size: [5,0]

=head2 credit_days_amt

  data_type: 'numeric'
  is_nullable: 1
  size: [13,0]

=head2 curr_orders_amt

  data_type: 'double precision'
  is_nullable: 1

=head2 credit_limit_amt

  data_type: 'numeric'
  is_nullable: 1
  size: [13,0]

=head2 tot_due_amt

  data_type: 'double precision'
  is_nullable: 1

=head2 statement_copies

  data_type: 'numeric'
  is_nullable: 1
  size: [3,0]

=head2 statement_type

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

=head2 date_created

  data_type: 'datetime'
  is_nullable: 1

=head2 gl_ar_control

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 gl_discount_allowed

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 gl_sales

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 branch_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 fin_chg_rate

  data_type: 'double precision'
  is_nullable: 1

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
  size: 7067

=cut

__PACKAGE__->add_columns(
  "debtor_code",
  { data_type => "char", is_nullable => 0, size => 10 },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "debtor_search_key",
  { data_type => "char", is_nullable => 1, size => 80 },
  "company_code",
  { data_type => "char", is_nullable => 0, size => 10 },
  "debtor_type",
  { data_type => "char", is_nullable => 0, size => 1 },
  "bank_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "bank_branch",
  { data_type => "char", is_nullable => 1, size => 20 },
  "bsb_number",
  { data_type => "char", is_nullable => 1, size => 15 },
  "account_number",
  { data_type => "char", is_nullable => 1, size => 20 },
  "account_name",
  { data_type => "char", is_nullable => 1, size => 32 },
  "credit_card_no",
  { data_type => "numeric", is_nullable => 1, size => [22, 0] },
  "credit_card_exp",
  { data_type => "datetime", is_nullable => 1 },
  "credit_card_name",
  { data_type => "char", is_nullable => 1, size => 40 },
  "credit_card_auth",
  { data_type => "char", is_nullable => 1, size => 1 },
  "payment_type",
  { data_type => "char", is_nullable => 1, size => 1 },
  "term_code",
  { data_type => "char", is_nullable => 0, size => 1 },
  "ignore_credit_check",
  { data_type => "char", is_nullable => 0, size => 1 },
  "credit_days",
  { data_type => "numeric", is_nullable => 1, size => [5, 0] },
  "credit_days_amt",
  { data_type => "numeric", is_nullable => 1, size => [13, 0] },
  "curr_orders_amt",
  { data_type => "double precision", is_nullable => 1 },
  "credit_limit_amt",
  { data_type => "numeric", is_nullable => 1, size => [13, 0] },
  "tot_due_amt",
  { data_type => "double precision", is_nullable => 1 },
  "statement_copies",
  { data_type => "numeric", is_nullable => 1, size => [3, 0] },
  "statement_type",
  { data_type => "char", is_nullable => 0, size => 1 },
  "stop_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "active_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "date_created",
  { data_type => "datetime", is_nullable => 1 },
  "gl_ar_control",
  { data_type => "char", is_nullable => 1, size => 20 },
  "gl_discount_allowed",
  { data_type => "char", is_nullable => 1, size => 20 },
  "gl_sales",
  { data_type => "char", is_nullable => 1, size => 20 },
  "branch_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "fin_chg_rate",
  { data_type => "double precision", is_nullable => 1 },
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
  { data_type => "varchar", is_nullable => 1, size => 7067 },
);

=head1 PRIMARY KEY

=over 4

=item * L</debtor_code>

=back

=cut

__PACKAGE__->set_primary_key("debtor_code");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-09 12:00:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:s/XfAz/aS3sKxrASpMmsGw

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

1;
