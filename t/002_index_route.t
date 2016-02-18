use strict;
use warnings;

use Test::More tests => 7;

use Test::WWW::Mechanize::PSGI;
use Data::Dumper qw(Dumper);

use_ok 'Reports';

my %routes = ('/'                    => {},
              '/accounts-receivable' => {},
              '/accounts-receivable/outstanding-invoices' => {},
              '/accounts-receivable/statement-email-addresses' => {},
              '/accounts-payable'    => {},
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
              '/sales'                => {},
              '/sales/new-stores-quarterly-sales' => {},
              '/sales/territory-24-month-summary' => {},
              '/sales/territory-24-month-detail' => {},
              '/sales-history'           => {TODO => 'not implemented yet'},
              '/sales-reports-for-reps'  => {TODO => 'not implemented yet'},
              '/sirius8test'             => {TODO => 'not implemented yet'},
              '/stockist-reports'        => {TODO => 'not implemented yet'},
              '/stocktake'               => {TODO => 'not implemented yet'},
              );

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
  plan tests => scalar keys %routes;
  for my $route (keys %routes) {
    local $TODO = $routes{$route}{TODO}; # tests are marked as TODO when $TODO is true
    $mech->get_ok($base->new_abs($route,$base));
  };
};


