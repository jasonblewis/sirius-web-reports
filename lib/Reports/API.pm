package Reports::API;

use 5.22.0;
use strict;
use warnings;

use Dancer2;
use Reports::API::AccountsReceivable;
use Reports::API::Sales;

# use Dancer2::Plugin::Auth::Extensible;
# use Dancer2::Plugin::DBIC qw(schema resultset rset);
set serializer => 'JSON';

1;
