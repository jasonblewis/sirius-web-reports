use utf8;
package Reports::Schema::Result::Period;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Reports::Schema::Result::Period

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

=head1 TABLE: C<period>

=cut

__PACKAGE__->table("period");

=head1 ACCESSORS

=head2 period_type

  data_type: 'char'
  is_nullable: 0
  size: 2

=head2 year

  data_type: 'numeric'
  is_nullable: 0
  size: [5,0]

=head2 period

  data_type: 'numeric'
  is_nullable: 0
  size: [4,0]

=head2 u_version

  data_type: 'char'
  is_nullable: 1
  size: 1

=head2 period_start

  data_type: 'datetime'
  is_nullable: 0

=head2 period_end

  data_type: 'datetime'
  is_nullable: 0

=head2 description

  data_type: 'char'
  is_nullable: 1
  size: 10

=cut

__PACKAGE__->add_columns(
  "period_type",
  { data_type => "char", is_nullable => 0, size => 2 },
  "year",
  { data_type => "numeric", is_nullable => 0, size => [5, 0] },
  "period",
  { data_type => "numeric", is_nullable => 0, size => [4, 0] },
  "u_version",
  { data_type => "char", is_nullable => 1, size => 1 },
  "period_start",
  { data_type => "datetime", is_nullable => 0 },
  "period_end",
  { data_type => "datetime", is_nullable => 0 },
  "description",
  { data_type => "char", is_nullable => 1, size => 10 },
);

=head1 PRIMARY KEY

=over 4

=item * L</period_type>

=item * L</year>

=item * L</period>

=back

=cut

__PACKAGE__->set_primary_key("period_type", "year", "period");


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-24 12:04:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EEhUppLU0KEoWw9YQ3DUlg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
