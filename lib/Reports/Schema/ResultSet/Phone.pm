use utf8;
package Reports::Schema::ResultSet::Phone;

use base 'Reports::Schema::ResultSet';

sub buyer_fax_numbers {
   my $self = shift;
   $self->search({
      $self->current_source_alias . '.phone_type' => { '=' => 'BUYFAX' }
   })
}

sub buyer_phone_numbers {
   my $self = shift;
   $self->search({
      $self->current_source_alias . '.phone_type' => { '=' => 'BUYER' }
   })
}

sub supplier_emails {
   my $self = shift;
   $self->search({
      $self->current_source_alias . '.phone_type' => { '=' => 'PO' }
   })
}

1;
