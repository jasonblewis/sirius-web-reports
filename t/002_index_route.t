use strict;
use warnings;

use Test::More tests => 7;

use Test::WWW::Mechanize::PSGI;

use_ok 'Reports';

my @routes = ('/',
              'accounts-receivable',
              'accounts-payable',
              'business-metrics',
              '/sales');

my $app = Reports->to_app;

isa_ok( $app, 'CODE' );

my $mech = Test::WWW::Mechanize::PSGI->new(
  app => $app,
  max_redirect => 0
);


$mech->get('/');
ok $mech->status eq '302', "/" or diag $mech->status;
my $loc = $mech->response->header('Location');
is $loc, 'http://localhost/login?return_url=%2F', '/ redirects to /login' or diag "Location header: $loc";

$mech->get($loc);
ok $mech->status eq '401', "login page" or diag $mech->status;


$mech->submit_form(
    form_number => 1,
    fields      => { username => 'test',
                     password => 'test' },
) or diag "died on submit";

diag "mech success: $mech->success";

$loc = $mech->response->header('Location');
diag "loc: $loc";
$mech->get_ok($loc);

my $base = $mech->base;
diag "base: $base";
subtest 'all routes work' => sub {
  plan tests => scalar @routes;
  for my $route (@routes) {
    $mech->get_ok($base->new_abs($route,$base));
  };
};
