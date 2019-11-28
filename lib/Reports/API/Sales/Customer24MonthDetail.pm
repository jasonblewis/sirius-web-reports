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

package Reports::API::Sales::Customer24MonthDetail;

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


sub customer_24_month_detail {
  my $dbh = database(); 
  $dbh->{LongReadLen} = 100000;
  $dbh->{LongTruncOk} = 1;
 

  my $customer_code = route_parameters->get('customer_code');

  unless ($customer_code) {
    my ($error) = @_;
    warning 'must supply a customer code for this api ' . request->remote_address; 
  } else { 
    debug "customer_code: $customer_code";
  
    my $sql = q/

Set transaction isolation level read uncommitted;

Declare @debug bit
set @debug = 0


declare @cols as nvarchar(max),@query as nvarchar(max)
declare @customer as nvarchar(max);
set @customer = ?;
;with cte(intCount,month)
as
(
Select 0, 	       DATEADD(month, DATEDIFF(month, 0, DATEADD(month, 0,            GETDATE())), 0) as month
union all
Select intCount+1, DATEADD(month, DATEDIFF(month, 0, DATEADD(month, -(intCount+1), GETDATE())), 0) as month
from cte
where intCount<=24
)
Select @cols = coalesce(@cols + ',','') + quotename(convert(varchar(10),month,120))
from cte order by month
select @query =
'select * from 
(select
sh.product_code,
sh.description,
p.primary_supplier,
DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0) as ''month'',
sum(sh.sales_qty) as sales_qty
from
 sh_select_trans_view sh
join
 in_prod_whouse_view p 
 on sh.product_code = p.product_code


where sh.invoice_date >= DATEADD(YEAR, DATEDIFF(YEAR, 0, DATEADD(YEAR, -2, GETDATE())), 0)
and ltrim(rtrim(sh.customer_code)) = ''' + @customer + '''
group by sh.product_code, sh.description, p.primary_supplier, DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0)   ) x
pivot
(
sum(sales_qty)
for [month] in ( ' + @cols + ' )
) p'

if @debug = 1 Begin     Print @query End
Else 
Begin Exec SP_EXECUTESQL @query End


/;
    #debug "sql = $sql";
    my $sth = database->prepare($sql) or die "can't prepare\n";
    $sth->bind_param(1,$customer_code);
    $sth->execute or die $sth->errstr;
    my $fields = $sth->{NAME};
    my $rows = $sth->fetchall_arrayref({});
    debug "number of rows retreived: " . $sth->rows;
    $sth->finish;

    $sth = database->prepare(q/select top 1 * from ar_customer_select_view where customer_code = ?/) or die "can't prepare\n";
    $sth->bind_param(1,$customer_code);
    $sth->execute or die $sth->errstr;
    my $customer = $sth->fetchall_arrayref({});
    $sth->finish;

    return {
      data => [@$rows],
    }
    
  };
};

any ['get','post'] => '/sales/customer-24-month-detail/:customer_code' => require_any_role [qw(GL BG stockist)] => \&customer_24_month_detail;


1;


    # template 'sales/customer-24-month-detail2', {
    #   customer_code => $customer_code,
    #   customer_row => $customer,
    #   'title' => "Customer 24 Month Detail $customer_code",
    #   'fields' => $fields,
    #   'rows' => $rows,
    # };
