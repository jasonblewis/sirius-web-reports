#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;
use URI;
use lib './lib';
use Reports::Utils qw(ltrim rtrim trim url_first_part compare_url_segments);

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


say ReportUtils::url_first_part('/some/path');
if (ReportUtils::compare_url_segments('/some/path','/some/path/foo',2)) {
  say "same"; }
else {
  say "different";
}


if (ReportUtils::compare_url_segments('/general-ledger','/general-ledger/credit-card/reconciliation/20110',1)) {
  say "same"; }
else {
  say "different";
}

  
  
# output:
# target_url: /purchasing/multi-warehouse-sales-history
# full_target_url: /purchasing/ABC123
# uri:http://example.com/some/path
# uri:http://example.com/some/path/lets/dig/deeper
