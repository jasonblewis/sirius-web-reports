use strict;
use warnings;

use 5.12.0;

use Test::More;

use Test::WWW::Mechanize::PSGI;
use Data::Dumper qw(Dumper);

use FindBin;
use lib "$FindBin::Bin/../lib";

use Reports;
use Reports::API;

use Plack::Builder;

my %api_routes = (
  '/api/sales/outstanding-sales-orders'                         => {},
);

my $api_app = Reports::API->to_app;

isa_ok( $api_app, 'CODE' );

my $mech = Test::WWW::Mechanize::PSGI->new(
  app => builder {
    mount '/api' => $api_app;
  },
  max_redirect => 0
);


$mech->get('/');
ok $mech->status eq '302', "/" or diag $mech->status;
my $loc = $mech->response->header('Location');
is $loc, 'http://localhost/login?return_url=%2F', '/ redirects to /login' or diag "Location header: $loc";

$mech->get($loc);
ok $mech->status eq '200', "login page" or diag $mech->status;


$mech->submit_form(
    form_number => 1,
    fields      => { username => 'test',
                     password => 'test' },
) or diag "died on submit";

$loc = $mech->response->header('Location');
diag "loc: $loc";
$mech->get_ok($loc);

# test all routes accessible
my $base = $mech->base;
diag "base: $base";
# subtest 'all routes work' => sub {
#   for my $route (keys %routes) {
#     local $TODO = $routes{$route}{TODO}; # tests are marked as TODO when $TODO is true
#     $mech->get_ok($base->new_abs($route,$base));
#   };
# };


# test all api routes
subtest 'all api routes work' => sub {
  for my $api_route (keys %api_routes) {
    local $TODO = $api_routes{$api_route}{TODO}; # tests are marked as TODO when $TODO is true
    $mech->get_ok($base->new_abs($api_route,$base));
  };
  

};
# can't work out how to use post_ok here so use post
#  the issue is I couldn't work out how to pass the content and content-type in post_ok
$mech->post(
  $base->new_abs("/api/accounts-receivable/customers",$base),
  (
    Content => '{"target_url":"/abc/def"}',
    'Content-Type' => 'application/json',

  ));
  
ok($mech->success, "able to post to /api/accounts-receivable/customers");
$mech->content_contains( qq(/abc/def?customer_code) );

#say $mech->content;

$mech->get_ok($base->new_abs('/sales/order-form-w-pricecode?customer_code=ALBOND',$base));
$mech->content_contains('/api/sales/order-form-w-pricecode/ALBOND');

done_testing;
