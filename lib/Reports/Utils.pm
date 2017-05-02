package Reports::Utils;
use strict;
use warnings;
use URI;
use 5.22.0;
use Data::Dumper;
use List::Util 'all';

use Exporter('import');

my $logger;

sub set_logger {
  $logger = shift;
}

our @EXPORT_OK = qw(ltrim rtrim trim url_first_part compare_url_segments);


sub ltrim { my $s = shift; $s =~ s/^\s+//;       return $s };
sub rtrim { my $s = shift; $s =~ s/\s+$//;       return $s };
sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

sub url_first_part {
  my @args = @_;
  my $u = URI->new(@args);
  return ($u->path_segments)[1];
};

# sub _compare_array {
#   my ($arr1, $arr2, $n) = @_;
#   foreach (0 .. $n-1) {
#     say "comparing: ", $arr1->[$_], ' ', $arr2->[$_] ;
#     return 0 unless ( 
#       ( defined($arr1->[$_]) || defined($arr2->[$_]) )
# 	 && 
# 	 ($arr1->[$_] eq $arr2->[$_] ) 
#       );
#   return 1;
#   }
# }

sub compare_url_segments {
  # compare the segments of 2 urls up to a given level
  # ie, compare /some/path with /some/path/foo.
  # will match if level = 2 as the first 2 segments match
  # pass in 2 urls + a number
  #$logger->("in compare_url_segments");
  my @args = @_;
  my $url1 = $args[0];
  my $url2 = $args[1];
  my $depth = $args[2]+1;
  my $u1 = URI->new($url1);
  my $u2 = URI->new($url2);
  my @segments1 = $u1->path_segments;
  my @segments2 = $u2->path_segments;

  my $match = @segments1 >= $depth && @segments2 >= $depth && all { $segments1[$_] eq $segments2[$_] } 0..$depth-1;
  return $match;
};


1;
