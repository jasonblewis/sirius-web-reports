use utf8;
package Reports::Schema::Result::GstTaxTable;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::GstTaxTable

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

=head1 TABLE: C<gst_tax_table>

=cut

__PACKAGE__->table("gst_tax_table");

=head1 ACCESSORS

=head2 gst_code

  data_type: 'char'
  is_nullable: 0
  size: 3

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 description

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 tax_rate

  data_type: 'double precision'
  is_nullable: 1

=head2 gst_collect_acc

  data_type: 'char'
  is_nullable: 0
  size: 20

=head2 gst_in_cred_acc

  data_type: 'char'
  is_nullable: 0
  size: 20

=cut

__PACKAGE__->add_columns(
  "gst_code",
  { data_type => "char", is_nullable => 0, size => 3 },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "description",
  { data_type => "char", is_nullable => 1, size => 20 },
  "tax_rate",
  { data_type => "double precision", is_nullable => 1 },
  "gst_collect_acc",
  { data_type => "char", is_nullable => 0, size => 20 },
  "gst_in_cred_acc",
  { data_type => "char", is_nullable => 0, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</gst_code>

=back

=cut

__PACKAGE__->set_primary_key("gst_code");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-09 12:00:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HJQaswovOwPVx9+bKO4oig

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

1;
