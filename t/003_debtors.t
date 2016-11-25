use strict;
use warnings;

use 5.22.0;

use Test::More tests => 7;

use Test::WWW::Mechanize::PSGI;
use Data::Dumper qw(Dumper);

use FindBin;
use lib "$FindBin::Bin/../lib";

use Reports;
use Reports::API;

use Plack::Builder;

my %api_routes = (
  '/api/accounts-receivable/customers'                                => {},
  '/api/accounts-receivable/customers/AKAGRO'                         => {},

		);

my $app = Reports->to_app;
my $api_app = Reports::API->to_app;

isa_ok( $app, 'CODE' );
isa_ok( $api_app, 'CODE' );

my $mech = Test::WWW::Mechanize::PSGI->new(
  app => builder {
    mount '/' =>  $app;
    mount '/api' => $api_app;
  },
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


# test api routes
my $base = $mech->base;

subtest 'all api routes work' => sub {
  plan tests => scalar keys %api_routes;
  for my $api_route (keys %api_routes) {
    local $TODO = $api_routes{$api_route}{TODO}; # tests are marked as TODO when $TODO is true
    $mech->get_ok($base->new_abs($api_route,$base));
  };
  

};



