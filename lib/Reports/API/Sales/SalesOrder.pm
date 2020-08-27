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
  
  my $sql = q!
  Set transaction isolation level read uncommitted;
  select 
  CASE CHARINDEX(' ', u.user_name, 1)
     WHEN 0 THEN u.user_name -- empty or single word
     ELSE SUBSTRING(u.user_name, 1, CHARINDEX(' ', u.user_name, 1) - 1) END as first_name, -- multi-word
    so.customer_code,
    so.name,
    so.order_status,
    so.branch_code,
    so.sale_or_credit,
    so.order_no,
    so.order_date,
    CONVERT(VARCHAR(10),so.order_date,120) as order_date_sortable,
    so.territory_code,
    DATEDIFF(s, '1970-01-01 00:00:00', so.order_date) as odts,
    sum((so.unit_price * so.ordered_qty) * (1 - so.discount_rate/100)) as amount
	
 from so_order_and_lines_view so
 join user_file u on
   u.user_id = so.user_id

where
 so.order_status not in ( 'F','C')
 and so.sale_or_credit = 'S'
 group by CASE CHARINDEX(' ', u.user_name, 1)
     WHEN 0 THEN u.user_name -- empty or single word
     ELSE SUBSTRING(u.user_name, 1, CHARINDEX(' ', u.user_name, 1) - 1) END ,so.customer_code,so.name,so.order_status,so.branch_code,so.sale_or_credit,so.order_no,so.order_date,so.territory_code
 order by so.order_date
  !;
  

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
    name,
    order_status,
    sale_or_credit,
    order_no,
    order_date,
    CONVERT(VARCHAR(10),order_date,120) as order_date_sortable,
    DATEDIFF(s, '1970-01-01 00:00:00', order_date) as odts,
    sum(unit_price * ordered_qty) as amount from so_order_and_lines_view 

where
 order_status not in ( 'F','C')
 and sale_or_credit = 'C'
 group by customer_code,name,order_status,sale_or_credit,order_no,order_date
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
  invoice_no,
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
  name,invoice_no,invoice_date
    
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
