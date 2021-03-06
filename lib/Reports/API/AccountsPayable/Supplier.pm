# Copyright 2017 Jason Lewis

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

package Reports::API::AccountsPayable::Supplier;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Database;
use Reports::Utils qw(rtrim);
use Data::Dumper;
use URI;

sub suppliers {

  my $sql = q{Set transaction isolation level read uncommitted;
  select  distinct rtrim(s.supplier_code) as 'supplier_code',
          rtrim(c.name) as 'name'
  from ap_supplier s 
  join in_product p on
    p.primary_supplier = s.supplier_code
  join in_warehouse_product wp on
    wp.supplier_code = p.primary_supplier
  join company c
    on s.company_code = c.company_code 
  where 
  ( s.spare_flag_01 is null or s.spare_flag_01 != 'N') 
  and
  ( p.spare_flag_03 is null or p.spare_flag_03 = 'Y')
  and not (wp.reorder_type = 'Q' and wp.reorder_class = 'Q')
  order by supplier_code
};
  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;
  
  return {
    data => $rows,
  }
};
    
    any ['get','post'] => '/accounts-payable/suppliers' => require_login \&suppliers;

1;
