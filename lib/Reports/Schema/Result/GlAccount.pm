use utf8;
package Reports::Schema::Result::GlAccount;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::GlAccount

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

=head1 TABLE: C<gl_account>

=cut

__PACKAGE__->table("gl_account");

=head1 ACCESSORS

=head2 account

  data_type: 'char'
  is_nullable: 0
  size: 20

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 component_1

  data_type: 'varchar'
  is_nullable: 1
  size: 12

=head2 component_2

  data_type: 'varchar'
  is_nullable: 1
  size: 12

=head2 component_3

  data_type: 'varchar'
  is_nullable: 1
  size: 12

=head2 component_4

  data_type: 'varchar'
  is_nullable: 1
  size: 12

=head2 component_5

  data_type: 'varchar'
  is_nullable: 1
  size: 12

=head2 component_6

  data_type: 'varchar'
  is_nullable: 1
  size: 12

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 uppercase_name

  data_type: 'varchar'
  is_nullable: 1
  size: 80

=head2 normal_sign

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 clear_to

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 active_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 date_created

  data_type: 'datetime'
  is_nullable: 1

=head2 account_type

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 sub_type

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 gst_code

  data_type: 'char'
  is_nullable: 1
  size: 3

=head2 flag_1

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 flag_2

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 flag_3

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 flag_4

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 spare_code_01

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 spare_code_02

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 spare_code_03

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 spare_code_04

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 spare_code_05

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 spare_code_06

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 spare_code_07

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 spare_code_08

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 spare_code_09

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 spare_code_10

  data_type: 'varchar'
  is_nullable: 1
  size: 40

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

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 sst_spare_code_02

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 sst_spare_code_03

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 sst_spare_code_04

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=head2 sst_spare_code_05

  data_type: 'varchar'
  is_nullable: 1
  size: 40

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

=cut

__PACKAGE__->add_columns(
  "account",
  { data_type => "char", is_nullable => 0, size => 20 },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "component_1",
  { data_type => "varchar", is_nullable => 1, size => 12 },
  "component_2",
  { data_type => "varchar", is_nullable => 1, size => 12 },
  "component_3",
  { data_type => "varchar", is_nullable => 1, size => 12 },
  "component_4",
  { data_type => "varchar", is_nullable => 1, size => 12 },
  "component_5",
  { data_type => "varchar", is_nullable => 1, size => 12 },
  "component_6",
  { data_type => "varchar", is_nullable => 1, size => 12 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "uppercase_name",
  { data_type => "varchar", is_nullable => 1, size => 80 },
  "normal_sign",
  { data_type => "char", is_nullable => 0, size => 1 },
  "clear_to",
  { data_type => "char", is_nullable => 1, size => 20 },
  "active_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "date_created",
  { data_type => "datetime", is_nullable => 1 },
  "account_type",
  { data_type => "char", is_nullable => 0, size => 1 },
  "sub_type",
  { data_type => "char", is_nullable => 1, size => 1 },
  "gst_code",
  { data_type => "char", is_nullable => 1, size => 3 },
  "flag_1",
  { data_type => "char", is_nullable => 1, size => 1 },
  "flag_2",
  { data_type => "char", is_nullable => 1, size => 1 },
  "flag_3",
  { data_type => "char", is_nullable => 1, size => 1 },
  "flag_4",
  { data_type => "char", is_nullable => 1, size => 1 },
  "spare_code_01",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "spare_code_02",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "spare_code_03",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "spare_code_04",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "spare_code_05",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "spare_code_06",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "spare_code_07",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "spare_code_08",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "spare_code_09",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "spare_code_10",
  { data_type => "varchar", is_nullable => 1, size => 40 },
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
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "sst_spare_code_02",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "sst_spare_code_03",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "sst_spare_code_04",
  { data_type => "varchar", is_nullable => 1, size => 40 },
  "sst_spare_code_05",
  { data_type => "varchar", is_nullable => 1, size => 40 },
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
);

=head1 PRIMARY KEY

=over 4

=item * L</account>

=back

=cut

__PACKAGE__->set_primary_key("account");


# Created by DBIx::Class::Schema::Loader v0.07049 @ 2019-12-19 14:22:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9N2/NczJqKqj12CPy+SwzQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
