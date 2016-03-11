use utf8;
package Reports::Schema::Result::Phone;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::Phone

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

=head1 TABLE: C<phone>

=cut

__PACKAGE__->table("phone");

=head1 ACCESSORS

=head2 company_code

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 phone_line

  data_type: 'numeric'
  is_nullable: 0
  size: [9,0]

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 seq

  data_type: 'numeric'
  is_nullable: 1
  size: [9,0]

=head2 phone_no

  data_type: 'char'
  is_nullable: 0
  size: 50

=head2 phone_type

  data_type: 'char'
  is_nullable: 0
  size: 6

=head2 notes

  data_type: 'varchar'
  is_nullable: 1
  size: 7908

=cut

__PACKAGE__->add_columns(
  "company_code",
  { data_type => "char", is_nullable => 0, size => 10 },
  "phone_line",
  { data_type => "numeric", is_nullable => 0, size => [9, 0] },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "seq",
  { data_type => "numeric", is_nullable => 1, size => [9, 0] },
  "phone_no",
  { data_type => "char", is_nullable => 0, size => 50 },
  "phone_type",
  { data_type => "char", is_nullable => 0, size => 6 },
  "notes",
  { data_type => "varchar", is_nullable => 1, size => 7908 },
);

=head1 PRIMARY KEY

=over 4

=item * L</company_code>

=item * L</phone_line>

=back

=cut

__PACKAGE__->set_primary_key("company_code", "phone_line");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-03-09 16:31:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:G9oT0SmgorswAL1pEQAKsA

__PACKAGE__->belongs_to(
  "company" =>
    'Reports::Schema::Result::Company',
  'company_code',
);


1;
