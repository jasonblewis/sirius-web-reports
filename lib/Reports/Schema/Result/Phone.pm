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


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-09 12:00:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:phbuA1ycMPPtqFNlxPu2Jw

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
