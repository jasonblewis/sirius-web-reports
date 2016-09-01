use strict;
use warnings;
use 5.22.0;
use URI;


  my $target_url = '/purchasing/multi-warehouse-sales-history';
  say "target_url: ", $target_url;
  
# wrong way
if ($target_url) {
  my $full_target_url = URI->new_abs('ABC123',$target_url);
  
  say "full_target_url: ", $full_target_url->as_string;
};

# right way, thanks to kd
my $uri = URI->new('http://example.com/some/path');

say 'uri:', $uri->as_string;

$uri->path_segments($uri->path_segments, qw/lets dig deeper/);

say 'uri:', $uri->as_string;
  
  
# output:
# target_url: /purchasing/multi-warehouse-sales-history
# full_target_url: /purchasing/ABC123
# uri:http://example.com/some/path
# uri:http://example.com/some/path/lets/dig/deeper
