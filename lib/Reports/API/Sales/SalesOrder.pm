# Copyright 2016 Jason Lewis

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

package Reports::API::Sales::SalesOrder;

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


sub outstanding_sales_orders {

  my $params = request->body_parameters;

  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  
  my $sql = q/
Set transaction isolation level read uncommitted;
  select 
    customer_code,
    name,
    order_status,
    branch_code,
    sale_or_credit,
	order_nr,
	order_date,
	sales_rep_code,
    DATEDIFF(s, '1970-01-01 00:00:00', order_date) as odts,
    sum(unit_price * ordered_qty) as amount
	
 from so_order_and_lines_view 

where
 order_status not in ( 'F','C')
 and sale_or_credit = 'S'
 group by customer_code,name,order_status,branch_code,sale_or_credit,order_nr,order_date,sales_rep_code
 order by order_date
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


sub outstanding_sales_credits {

  my $params = request->body_parameters;

  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  
  my $sql = q/Set transaction isolation level read uncommitted;
  select 
    customer_code,
    name,order_status,sale_or_credit,order_nr,order_date,
    DATEDIFF(s, '1970-01-01 00:00:00', order_date) as odts,
    sum(unit_price * ordered_qty) as amount from so_order_and_lines_view 

where
 order_status not in ( 'F','C')
 and sale_or_credit = 'C'
 group by customer_code,name,order_status,sale_or_credit,order_nr,order_date
 order by order_date
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


sub sales_invoices {
  # returns todays invoices only
my $sql = q{select 
  name,
  invoice_nr,
  invoice_date,
  sum(round(round(unit_price,2)*shipped_qty*(1-discount_rate/100),2)) as [summary total],
sum(round(round(unit_price,2)*shipped_qty*(1-discount_rate/100) * (tax_rate/100),2)) as [gst],
  
  sum(round(round(unit_price,2)*shipped_qty*(1-discount_rate/100),2) + (round(round(unit_price,2)*shipped_qty*(1-discount_rate/100) * (tax_rate/100),2))) as [total inc gst]
  
  from so_invoice_view 
  
  where 
  invoice_date >= dateadd(d,-1,getdate())
  and
  sale_or_credit = 'S'
  group by 
  name,invoice_nr,invoice_date
    
  };

  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;

  return {
    data => [@$rows],
  };

};


any ['get','post'] => '/sales/outstanding-sales-orders' => require_login \&outstanding_sales_orders;
any ['get','post'] => '/sales/outstanding-sales-credits' => require_login \&outstanding_sales_credits;
any ['get','post'] => '/sales/sales-invoices' => require_login \&sales_invoices;



1;
