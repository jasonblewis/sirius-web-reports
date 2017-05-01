use strict;
use warnings;
use 5.22.0;

use Test::More;

use FindBin;
use lib "$FindBin::Bin/../lib";


use Reports::DateUtils qw(month_name_from_age month_number_from_age);

my ( $day, $month_0, $year ) = ( localtime )[3,4,5];
my $month = $month_0+1;

my @months =  qw/ Jan Feb Mar 
                   Apr May Jun 
                   Jul Aug Sep 
                   Oct Nov Dec /;

is(month_name_from_age(0),$months[($month_0-0) % 12 ]);
is(month_name_from_age(1),$months[($month_0-1) % 12 ]);
is(month_name_from_age(2),$months[($month_0-2) % 12 ]);
is(month_name_from_age(3),$months[($month_0-3) % 12 ]);
is(month_name_from_age(4),$months[($month_0-4) % 12 ]);
is(month_name_from_age(5),$months[($month_0-5) % 12 ]);
is(month_name_from_age(6),$months[($month_0-6) % 12 ]);
is(month_name_from_age(7),$months[($month_0-7) % 12 ]);
is(month_name_from_age(8),$months[($month_0-8) % 12 ]);
is(month_name_from_age(9),$months[($month_0-9) % 12 ]);
is(month_name_from_age(10),$months[($month_0-10) % 12 ]);
is(month_name_from_age(11),$months[($month_0-11) % 12 ]);
is(month_name_from_age(12),$months[($month_0-12) % 12 ]);

# hmm.. can pass negative ages too.
is(month_name_from_age(-1),$months[($month_0+1) % 12 ]);
is(month_name_from_age(-2),$months[($month_0+2) % 12 ]);
is(month_name_from_age(-3),$months[($month_0+3) % 12 ]);
is(month_name_from_age(-4),$months[($month_0+4) % 12 ]);
is(month_name_from_age(-5),$months[($month_0+5) % 12 ]);
is(month_name_from_age(-6),$months[($month_0+6) % 12 ]);
is(month_name_from_age(-7),$months[($month_0+7) % 12 ]);
is(month_name_from_age(-8),$months[($month_0+8) % 12 ]);
is(month_name_from_age(-9),$months[($month_0+9) % 12 ]);
is(month_name_from_age(-10),$months[($month_0+10) % 12 ]);
is(month_name_from_age(-11),$months[($month_0+11) % 12 ]);
is(month_name_from_age(-12),$months[($month_0+12) % 12 ]);


# check if it croaks if you pass a non int.
eval { Reports::DateUtils::month_name_from_age(12.5)};
ok($@, 'croak on float passed to month_name_from_age');

# $month is 0..11. see perldoc perlfunc / localtime
is(month_number_from_age(0),($month - 0 -1) % 12 + 1);
is(month_number_from_age(1),($month - 1 -1) % 12 + 1);
is(month_number_from_age(2),($month - 2 -1) % 12 + 1);
is(month_number_from_age(3),($month - 3 -1) % 12 + 1);
is(month_number_from_age(4),($month - 4 -1) % 12 + 1);
is(month_number_from_age(5),($month - 5 -1) % 12 + 1);
is(month_number_from_age(6),($month - 6 -1) % 12 + 1);
is(month_number_from_age(7),($month - 7 -1) % 12 + 1);
is(month_number_from_age(8),($month - 8 -1) % 12 + 1);
is(month_number_from_age(9),($month - 9 -1) % 12 + 1);
is(month_number_from_age(10),($month - 10 -1) % 12 + 1);
is(month_number_from_age(11),($month - 11 -1) % 12 + 1);
is(month_number_from_age(12),($month - 12 -1) % 12 + 1);

# check if it croaks if you pass a non int.
eval { month_number_from_age(12.5)};
ok($@, 'croak on float passed to month_number_from_age');


done_testing();
1;
