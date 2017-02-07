use utf8;
package Reports::Schema::Result::ZzMostRecentPurchase;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::ZzMostRecentPurchase

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

=head1 TABLE: C<zz_most_recent_purchase>

=cut

__PACKAGE__->table("zz_most_recent_purchase");

=head1 ACCESSORS

=head2 customer_code

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 product_code

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 invoice_date

  data_type: 'datetime'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "customer_code",
  { data_type => "char", is_nullable => 1, size => 10 },
  "product_code",
  { data_type => "char", is_nullable => 1, size => 16 },
  "invoice_date",
  { data_type => "datetime", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-05-09 12:00:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:7IOWACIKunwDq2kXymP9qg

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
  "ar_customer" =>
    'Reports::Schema::Result::ArCustomer',
  'customer_code',
);

__PACKAGE__->belongs_to(
  "sh_transaction" =>
    'Reports::Schema::Result::ShTransaction',
  {'foreign.customer_code' => 'self.customer_code',
   'foreign.product_code' => 'self.product_code',
   'foreign.invoice_date' => 'self.invoice_date',
 }
);

1;
