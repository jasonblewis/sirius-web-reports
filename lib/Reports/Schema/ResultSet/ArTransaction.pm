use utf8;
package Reports::Schema::ResultSet::ArTransaction;

use base 'Reports::Schema::ResultSet';

sub invoices {
   my $self = shift;
   $self->search({
      $self->current_source_alias . '.trans_type' => { '=' => 'INV' }
   })
}
sub adjustments {
   my $self = shift;
   $self->search({
      $self->current_source_alias . '.trans_type' => { '=' => 'ADJ' }
   })
}
sub credits {
   my $self = shift;
   $self->search({
      $self->current_source_alias . '.trans_type' => { '=' => 'CRE' }
   })
}

sub cash_receipts {
   my $self = shift;
   $self->search({
      $self->current_source_alias . '.trans_type' => { '=' => 'CSH' }
   })
}

sub reverse_cash_receipts {
   my $self = shift;
   $self->search({
      $self->current_source_alias . '.trans_type' => { '=' => 'REV' }
   })
}

sub outstanding {
   my $self = shift;
   $self->search({
      $self->current_source_alias . '.completed_date' => { '=' => undef }
   })
}

sub not_outstanding {
   my $self = shift;
   $self->search({
      $self->current_source_alias . '.completed_date' => { '!=' => undef }
   })
}


1;
