use utf8;
package Reports::Schema::Result::ArTransaction;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::ArTransaction

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<ar_transaction>

=cut

__PACKAGE__->table("ar_transaction");

=head1 ACCESSORS

=head2 batch_nr

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 batch_line_nr

  data_type: 'numeric'
  is_nullable: 0
  size: [9,0]

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 debtor_code

  data_type: 'char'
  is_nullable: 0
  size: 10

=head2 customer_code

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 payment_type

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 account

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 trans_date

  data_type: 'datetime'
  is_nullable: 0

=head2 seq

  data_type: 'numeric'
  is_nullable: 1
  size: [9,0]

=head2 branch_code

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 trans_type

  data_type: 'char'
  is_nullable: 0
  size: 3

=head2 bank

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 ref_1

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 ref_2

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 ref_3

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 ref_4

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 ref_5

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 description

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 trans_amt

  data_type: 'double precision'
  is_nullable: 0

=head2 discount_amt

  data_type: 'double precision'
  is_nullable: 1

=head2 held_flag

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 completed_date

  data_type: 'datetime'
  is_nullable: 1

=head2 purged_alloc

  data_type: 'double precision'
  is_nullable: 1

=head2 spare_date_1

  data_type: 'datetime'
  is_nullable: 1

=head2 spare_date_2

  data_type: 'datetime'
  is_nullable: 1

=head2 spare_1

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_2

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 spare_flag_1

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 spare_flag_2

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 ext_desc

  data_type: 'char'
  is_nullable: 1
  size: 20

=head2 display_trans_amt

  data_type: 'double precision'
  is_nullable: 1

=head2 display_discount_amt

  data_type: 'double precision'
  is_nullable: 1

=head2 due_date

  data_type: 'datetime'
  is_nullable: 1

=head2 posted_flag

  data_type: 'char'
  is_nullable: 0
  size: 1

=head2 so_shipment_nr

  data_type: 'numeric'
  is_nullable: 1
  size: [11,0]

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

=cut

__PACKAGE__->add_columns(
  "batch_nr",
  { data_type => "char", is_nullable => 0, size => 10 },
  "batch_line_nr",
  { data_type => "numeric", is_nullable => 0, size => [9, 0] },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "debtor_code",
  { data_type => "char", is_nullable => 0, size => 10 },
  "customer_code",
  { data_type => "char", is_nullable => 1, size => 10 },
  "payment_type",
  { data_type => "char", is_nullable => 1, size => 1 },
  "account",
  { data_type => "char", is_nullable => 1, size => 20 },
  "trans_date",
  { data_type => "datetime", is_nullable => 0 },
  "seq",
  { data_type => "numeric", is_nullable => 1, size => [9, 0] },
  "branch_code",
  { data_type => "char", is_nullable => 1, size => 6 },
  "trans_type",
  { data_type => "char", is_nullable => 0, size => 3 },
  "bank",
  { data_type => "char", is_nullable => 1, size => 6 },
  "ref_1",
  { data_type => "char", is_nullable => 1, size => 20 },
  "ref_2",
  { data_type => "char", is_nullable => 1, size => 20 },
  "ref_3",
  { data_type => "char", is_nullable => 1, size => 20 },
  "ref_4",
  { data_type => "char", is_nullable => 1, size => 20 },
  "ref_5",
  { data_type => "char", is_nullable => 1, size => 20 },
  "description",
  { data_type => "char", is_nullable => 1, size => 40 },
  "trans_amt",
  { data_type => "double precision", is_nullable => 0 },
  "discount_amt",
  { data_type => "double precision", is_nullable => 1 },
  "held_flag",
  { data_type => "char", is_nullable => 1, size => 1 },
  "completed_date",
  { data_type => "datetime", is_nullable => 1 },
  "purged_alloc",
  { data_type => "double precision", is_nullable => 1 },
  "spare_date_1",
  { data_type => "datetime", is_nullable => 1 },
  "spare_date_2",
  { data_type => "datetime", is_nullable => 1 },
  "spare_1",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_2",
  { data_type => "char", is_nullable => 1, size => 20 },
  "spare_flag_1",
  { data_type => "char", is_nullable => 1, size => 1 },
  "spare_flag_2",
  { data_type => "char", is_nullable => 1, size => 1 },
  "ext_desc",
  { data_type => "char", is_nullable => 1, size => 20 },
  "display_trans_amt",
  { data_type => "double precision", is_nullable => 1 },
  "display_discount_amt",
  { data_type => "double precision", is_nullable => 1 },
  "due_date",
  { data_type => "datetime", is_nullable => 1 },
  "posted_flag",
  { data_type => "char", is_nullable => 0, size => 1 },
  "so_shipment_nr",
  { data_type => "numeric", is_nullable => 1, size => [11, 0] },
  "gl_ar_control",
  { data_type => "char", is_nullable => 1, size => 20 },
  "gl_discount_allowed",
  { data_type => "char", is_nullable => 1, size => 20 },
  "gl_sales",
  { data_type => "char", is_nullable => 1, size => 20 },
);

=head1 PRIMARY KEY

=over 4

=item * L</batch_nr>

=item * L</batch_line_nr>

=back

=cut

__PACKAGE__->set_primary_key("batch_nr", "batch_line_nr");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2016-03-08 12:20:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:VoNAlIyusIHIQeotv9CN+A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
