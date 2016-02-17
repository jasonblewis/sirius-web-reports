use strict;
use warnings;

use Test::More tests => 4;

use Test::WWW::Mechanize::PSGI;

use_ok 'Reports';

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


