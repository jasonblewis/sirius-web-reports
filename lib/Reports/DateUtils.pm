package Reports::DateUtils;
use utf8;
use strict;
use warnings;
use 5.22.0;
use DateTime;
use Scalar::Util::Numeric qw(isint);
use Carp;

use Exporter('import');

our @EXPORT_OK = qw(month_name_from_age month_number_from_age);


# given an age in months, return the abbreviated month name
# if now = march. month_name_from_age(1) will return "Feb"
# valid for all integers?
sub month_name_from_age {
  my ($age_in_months) = @_;
  croak "must pass integer to month_name_from_age"  if !(isint $age_in_months);
  my $datetime_aged = DateTime->now->subtract( months => $age_in_months);
  return $datetime_aged->strftime('%b');
};


# given an age in months, get the month number from the age
# if now = march. month_number_from_age(0) will return 3
# if now = january. month_number_from_age(1) will return 12

sub month_number_from_age {
  my ($age_in_months) = @_;
  croak "must pass integer to month_number_from_age"  if !(isint $age_in_months);
  my $datetime_aged = DateTime->now->subtract( months => $age_in_months);
  
  return $datetime_aged->month();
}

1;
