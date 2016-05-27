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

package Reports::API::Sales::Rolling24;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Database;

sub territory_24_month_summary {


  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  
  my $sql = q/Set transaction isolation level read uncommitted;
declare @cols as nvarchar(max),@query as nvarchar(max)
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
	rtrim(ac.territory_code) as ''Territory Code'',
	t.description,	
	DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0) as ''month'',
	sum(sh.sales_amt) as sales
 from sh_transaction sh
join ar_cust_ex_shipto_view ac on sh.customer_code = ac.customer_code
join territory t on ac.territory_code = t.territory_code
where sh.invoice_date >= DATEADD(YEAR, DATEDIFF(YEAR, 0, DATEADD(YEAR, -2, GETDATE())), 0)
group by ac.territory_code, t.description, DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0) ) x
pivot
(
  sum(sales)
  for [month] in ( ' + @cols + ' )
) p'
EXEC SP_EXECUTESQL @query/;

  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;

  


  return {
    pageLength => 50,
    columns => [
      { className => 'dt-right', data => 'product_code', title => 'Product Code'},
      { className => 'dt-right', data => 'sh_transaction.product.department.description', title => 'Department'},
      { className => 'dt-left',  data => 'sh_transaction.product_list_today.description', title => 'Description'},
      { className => 'dt-right', data => 'unitprice_2dp_na', title => 'Unit Price'},
      { className => 'dt-right', data => 'cartonprice_2dp', title => 'Carton Price'},
      { className => 'dt-right', data => 'sh_transaction.product_list_today.cartonsize', title => 'U/C'},
      { className => 'dt-right', data => 'sh_transaction.product.gst_tax_table.tax_rate', title => 'GST %'},
      { className => 'dt-right', data => 'invoice_date_datepart', title => 'Last Purchased'},
      { className => 'dt-right', data => 'sh_transaction.sales_qty', title => 'Last Purch. Qty'},
      { className => 'dt-right', data => 'sh_transaction.product_list_today.barcode', title => 'Barcode'},
    ],
    data => [@$rows],
  };
  
};


get '/sales/territory-24-month-summary' => require_login \&territory_24_month_summary;


1;
