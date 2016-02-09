#!/usr/bin/env perl
use 5.010;
use strict;
use warnings;

use DateTime;
use DateTime::Format::Strptime;

my $date = "25/12/2015";
my $parser = DateTime::Format::Strptime->new(
    pattern     => '%d/%m/%Y',
    time_zone   => 'local',
);
$date = $parser->parse_datetime($date);

my $today = DateTime->today();

my $dur = $date->delta_days($today);
say "Weeks:          ", $dur->weeks;
say "Months          ", $dur->months;
say "Days:           ", $dur->days;
say "Absolute Days:  ", $dur->in_units('days');
say "Absolute Hours: ", $date->delta_ms($today)->in_units('hours');
