use utf8;
package Reports::Schema::Result::InDepartment;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::InDepartment

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

=head1 TABLE: C<in_department>

=cut

__PACKAGE__->table("in_department");

=head1 ACCESSORS

=head2 department

  data_type: 'char'
  is_nullable: 0
  size: 6

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 description

  data_type: 'char'
  is_nullable: 1
  size: 40

=cut

__PACKAGE__->add_columns(
  "department",
  { data_type => "char", is_nullable => 0, size => 6 },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "description",
  { data_type => "char", is_nullable => 1, size => 40 },
);

=head1 PRIMARY KEY

=over 4

=item * L</department>

=back

=cut

__PACKAGE__->set_primary_key("department");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-03-14 15:52:08
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:iaQmNH87YVTIVNMbQrLV/A

__PACKAGE__->has_many(
  'products' =>
    'Reports::Schema::Result::InProduct',
  'department',
);


1;
