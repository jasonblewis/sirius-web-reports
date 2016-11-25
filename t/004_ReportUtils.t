use strict;
use warnings;
use 5.22.0;

use Test::More;

use Test::WWW::Mechanize::PSGI;
use Data::Dumper qw(Dumper);

use FindBin;
use lib "$FindBin::Bin/../lib";

use Reports::Utils qw(ltrim rtrim trim url_first_part);

Reports::Utils::set_logger( sub {diag @_});

# ltrim
is(Reports::Utils::ltrim(' 123'), '123', 'ltrim one leading space');
is(Reports::Utils::ltrim('      123'), '123', 'ltrim more than one leading space');
is(Reports::Utils::ltrim(' 123 '), '123 ', 'ltrim test trailing whitespace not touched');

# rtrim
is(Reports::Utils::rtrim('123 '), '123', 'rtrim one space');
is(Reports::Utils::rtrim('123   '), '123', 'rtrim more than  space');
is(Reports::Utils::rtrim(' 123 '), ' 123', 'rtrim leading whitespace not touched');

#trim
is(Reports::Utils::trim(' 123 '), '123', 'trim one space');
is(Reports::Utils::trim('   123   '), '123', 'trim more than  space');

is(Reports::Utils::url_first_part('/some/path'), 'some','first part of path returned' );

ok(Reports::Utils::compare_url_segments('/some/path/a','/some/path',2), '2 paths same to depth 2');

ok(!Reports::Utils::compare_url_segments('/some/path/a','/some/path/b',3), '2 paths not same to depth 3');


done_testing();
1;
