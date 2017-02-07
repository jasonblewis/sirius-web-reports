use utf8;
package Reports::Schema::Result::Company;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::Company

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

=head1 TABLE: C<company>

=cut

__PACKAGE__->table("company");

=head1 ACCESSORS

=head2 company_code

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 company_search_key

  data_type: 'char'
  is_nullable: 1
  size: 80

=head2 parent_company

  data_type: 'char'
  is_nullable: 1
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

=head2 active_flag

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 date_created

  data_type: 'datetime'
  is_nullable: 1

=head2 abn

  data_type: 'char'
  is_nullable: 1
  size: 12

=head2 notes

  data_type: 'varchar'
  is_nullable: 1
  size: 7632

=cut

__PACKAGE__->add_columns(
  "company_code",
  { data_type => "char", is_nullable => 0, size => 10 },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "company_search_key",
  { data_type => "char", is_nullable => 1, size => 80 },
  "parent_company",
  { data_type => "char", is_nullable => 1, size => 10 },
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
  "active_flag",
  { data_type => "char", is_nullable => 1, size => 1 },
  "date_created",
  { data_type => "datetime", is_nullable => 1 },
  "abn",
  { data_type => "char", is_nullable => 1, size => 12 },
  "notes",
  { data_type => "varchar", is_nullable => 1, size => 7632 },
);

=head1 PRIMARY KEY

=over 4

=item * L</company_code>

=back

=cut

__PACKAGE__->set_primary_key("company_code");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-09 12:00:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qBtx/GE3HBoZK7EQEpodPQ

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

__PACKAGE__->has_many(
    ap_suppliers =>
        'Reports::Schema::Result::ApSupplier',
    'company_code',
);

__PACKAGE__->has_many(
    ar_customers =>
        'Reports::Schema::Result::ArCustomer',
    'company_code',
);

__PACKAGE__->has_many(
    ar_debtors =>
        'Reports::Schema::Result::ArDebtor',
    'company_code',
);

__PACKAGE__->has_many(
    phones =>
        'Reports::Schema::Result::Phone',
    'company_code',
);

1;
