use utf8;
package Reports::Schema::ResultSet::Period;

use base 'Reports::Schema::ResultSet';
use DateTime;
use Data::Dumper;

sub period_from_month_age {
  my ($self, $period_type,$age_in_months)= @_;
  my $schema = $self->result_source->schema;
  my $dtf = $self->result_source->storage->datetime_parser;

  my $datetime_now = DateTime->now;
  my $datetime_aged = $datetime_now->clone->subtract( months => $age_in_months);
  my ($row, @too_many) = $self->search({
    $self->current_source_alias . '.period_type' => { '=' => $period_type },
    $self->current_source_alias . '.period' => { -not_in  => [0,999] },
    $self->current_source_alias . '.period_start' => { '<=' => $dtf->format_datetime($datetime_aged)},
    $self->current_source_alias . '.period_end'   => { '>=' => $dtf->format_datetime($datetime_aged)},

  })->all;
  die "Too many rows returned from period query!" if @too_many;
  return $row;
}

sub period_from_calendar_date {
  my ($self, $date) = @_;
  my $schema = $self->result_source->schema;
  my $dtf = $self->result_source->storage->datetime_parser;

  unless ($date) {
    $date = DateTime->now;
  }; 
  my $period = $self->search(
    {period_type => 'FM',
     period_start => { '<=' => $dtf->format_datetime($date)},
     period_end   => { '>=' => $dtf->format_datetime($date)},
     period => {-not_in => [0,999]},
   },
  )->single;
  return $period;
}

1;
