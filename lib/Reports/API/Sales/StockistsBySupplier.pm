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
  my $qry_supplier_code = route_parameters->get('supplier_code');

  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  
  my $sql = q/

SET TRANSACTION ISOLATION LEVEL READ uncommitted;  
select distinct
  sh.customer_code,
  --sh.product_code,
  --c.company_code,
  --p.primary_supplier,
  y.name,
  ph.phone,
  ph.phone_type,
  y.address_1,
  y.address_2,
  y.address_3,
  y.postcode
from 
  sh_transaction sh
join in_product p 
on
  sh.product_code = p.product_code
join ar_customer c
on
	sh.customer_code = c.customer_code
join company y
on
	c.company_code = y.company_code
right outer join phone ph
on 
	y.company_code = ph.company_code
	and ph.phone_type = 'BUS'

where 
  sh.invoice_date >= '2018-03-01 00:00:00'
  and p.primary_supplier = ?
  
  /;
  

  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute($qry_supplier_code) or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;

  return {
    data => [@$rows],
  };
  
};

any ['get','post'] => '/sales/stockists-by-supplier/:supplier_code' => require_any_role [qw(GL BG)] => \&stockists_by_supplier;


1;
