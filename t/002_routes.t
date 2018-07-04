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

my %routes = (
  '/'                    => {},
  '/accounts-receivable' => {},
  '/accounts-receivable/outstanding-invoices' => {},
  '/accounts-receivable/statement-email-addresses' => {},
  '/accounts-payable'    => {},
  '/accounts-payable/creditor-terms'    => {},
  '/accounts-payable/detailed-trial-balance'    => {},
  '/business-metrics'    => {TODO => 'not implemented yet' },
  '/business-reports'    => {TODO => 'not implemented yet'},
  '/cashflow'            => {TODO   => 'not implemented yet'},
  '/cc-reconciliation-reports' => {TODO => 'not implemented yet'},
  '/database-maintenance' => {TODO => 'not implemented yet'},
  '/general-ledger'       => {TODO => 'not implemented yet'},
  '/gl-checking'          => {TODO => 'not implemented yet'},
  '/gl-reconciliation reports' => {TODO => 'not implemented yet'},
  '/history'              => {TODO => 'not implemented yet'},
  '/old-reports'          => {TODO => 'not implemented yet'},
  '/price-lists and catalogues' => {TODO => 'not implemented yet'},
  '/purchasing/combined-warehouse-sales-history' => {},
  '/purchasing/combined-warehouse-sales-history?primary_supplier=PUKHER' =>  {},

  '/sales/new-stores-quarterly-sales' => {},
  '/sales/territory-24-month-summary' => {},
  '/sales/territory-24-month-detail' => {},
  '/sales/customer-24-month-detail' => {},
  '/sales/customer-24-month-detail?customer_code=777SUP' => {},
  
  '/sales/order-form-w-pricecode' => {},
  '/sales/order-form-w-pricecode?customer_code=ALLANE' => {},
  '/sales-history'           => {TODO => 'not implemented yet'},
  '/sales-reports-for-reps'  => {TODO => 'not implemented yet'},

  '/sirius8test'             => {TODO => 'not implemented yet'},
  '/stockist-reports'        => {TODO => 'not implemented yet'},
  '/stocktake'               => {TODO => 'not implemented yet'},
);

my %api_routes = (
  '/api/accounts-receivable/outstanding-invoices'                     => {},
  '/api/accounts-receivable/statement-email-addresses'                => {},
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
subtest 'all routes work' => sub {
  for my $route (keys %routes) {
    local $TODO = $routes{$route}{TODO}; # tests are marked as TODO when $TODO is true
    $mech->get_ok($base->new_abs($route,$base));
  };
};


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
