# Copyright 2019 Jason Lewis

# This file is part of Sirius Web Reports.

#     Sirius Web Reports is free software: you can redistribute it and/or modify
#     it under the terms of the GNU Affero Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.

#     Sirius Web Reports is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU Affero Public License for more details.

#     You should have received a copy of the GNU Affero Public License
#     along with Sirius Web Reports.  If not, see <http://www.gnu.org/licenses/>.

package Reports::API::Sales::StockistsBySupplier;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Database;
use Data::Dumper;

use List::MoreUtils;

use URI;

use Reports::Utils qw(rtrim);

Reports::Utils::set_logger( sub {debug @_});


sub stockists_by_supplier {

  my $params = request->body_parameters;

  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  
  my $sql = q/
  /;
  

  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;

  return {
    data => [@$rows],
  };
  
};

any ['get','post'] => '/sales/stockists-by-supplier' => require_any_role [qw(GL BG)] => \&stockists_by_supplier;


1;
