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

package Reports::API::Purchasing::BlueGreen;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Database;
use Data::Dumper;

use DateTime;

use URI;


sub blue_green {
  
  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  
  my $sql = q{
set transaction isolation level read uncommitted

Declare @debug bit
set @debug = 0
declare @months int
set @months = 15
declare @startdate datetime
set @startdate = DATEADD(month, DATEDIFF(month, 0, dateadd(m,-@months,getdate())), 0)

 declare @cols as nvarchar(max),@query as nvarchar(max)

                ;with cte(intCount,month)
                 as
                 (
                   Select 0, 	       DATEADD(month, DATEDIFF(month, 0, DATEADD(month, 0,            GETDATE())), 0) as month
                   union all
                    Select intCount+1, DATEADD(month, DATEDIFF(month, 0, DATEADD(month, -(intCount+1), GETDATE())), 0) as month
                	 from cte
                                            where intCount < @months
                 )
                Select @cols = coalesce(@cols + ',','') + quotename(convert(varchar(10),month,120))
                from cte order by month



declare @spmonths int
set @spmonths = 3
declare @spstartdate datetime
set @spstartdate = DATEADD(m, - @spmonths, DATEADD(dd, - DAY(GETDATE()) + 1,GETDATE()))
declare @spenddate datetime
set @spenddate = DATEADD(dd, - DAY(GETDATE()) + 1, GETDATE())


select @query =
'
select 
aps.spare_flag_02 as [OT Brand],
case when (sale_or_purchase = ''S'') then ''success'' else ''info'' end as [row_contextual_class],
 * 
from (
select 
supplier_code,
sale_or_purchase,
' + @cols + '

 from
(select 
  ''S'' as [sale_or_purchase],
  s.supplier_code,
  DATEADD(month, DATEDIFF(month, 0, sht.invoice_date), 0) as [month],
  sum(sht.sales_amt) as sales
  
 from 
   in_product p
 join 
   ap_supplier s
 on 
   p.primary_supplier = s.supplier_code
 join 
	sh_transaction sht
 on
	p.primary_supplier = sht.supplier_code
	and p.product_code = sht.product_code


	WHERE    sht.invoice_date >=  @p1
group by
  s.supplier_code,
  DATEADD(month, DATEDIFF(month, 0, sht.invoice_date), 0) ) x
 pivot
   (
                  sum(sales)
                  for [month] in (   ' + @cols + ' )
) s 



union

select 
  supplier_code,
  sale_or_purchase,
  ' + @cols + '
 from
(
select 
	''P''as [sale_or_purchase],
	i.supplier_code,
	DATEADD(month, DATEDIFF(month, 0, i.invoice_date), 0) as [month],
	sum(i.invoice_amt) as purchases
from 
    po_invoice i


where 
    i.invoice_date >=   @p1

group by
  i.supplier_code,
  DATEADD(month, DATEDIFF(month, 0, i.invoice_date), 0)) x
 pivot
   (
                  sum(purchases)
                  for [month] in (   ' + @cols + ' )
 ) p
 
) q

join
zz_stock_on_hand_value_by_primary_supplier sohv
 on q.supplier_code = sohv.primary_supplier
join
	ap_supplier aps
on
	aps.supplier_code = q.supplier_code
join
	(SELECT        
  p.primary_supplier as supplier_code,
  SUM(sh.sales_amt) / @spmonths * 0.73 AS suggested_purchase
FROM
   sh_transaction sh WITH (NOLOCK)
left join
	in_product p
	on p.product_code = sh.product_code
WHERE
   (sh.invoice_date >= @spstartdate) AND (sh.invoice_date < @spenddate)
GROUP BY p.primary_supplier)
	
	pg
on
	pg.supplier_code = q.supplier_code
order by
    aps.spare_flag_02 desc,
	pg.supplier_code,
	sale_or_purchase desc
'


 if @debug = 1 
 Begin
     Print @query 
 End
 Else 
 Begin 
   Exec SP_EXECUTESQL @query,N'@p1 DateTime,@spstartdate DateTime,@spenddate DateTime,@spmonths int',@startdate,@spstartdate,@spenddate,@spmonths 
 End 


  };

  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;

  return {
    data => $rows,
  }
}

any ['get','post'] => '/purchasing/blue-green' => require_login \&blue_green;

1;
