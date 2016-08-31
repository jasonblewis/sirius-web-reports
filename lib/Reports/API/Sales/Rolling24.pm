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
use Data::Dumper;

use List::MoreUtils;

use URI;

use ReportUtils qw(rtrim);

sub territory_24_month_summary {

  my $params = request->body_parameters;

  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  
  my $sql = q/Set transaction isolation level read uncommitted;
Declare @debug bit
set @debug = 1

declare @cols as nvarchar(max)
declare @colheads as nvarchar(max)

declare @sumcols as nvarchar(max)

declare @query as nvarchar(max)

;with cte(intCount,month)
 as
 (
   Select 0, 	       convert(char(10),DATEADD(month, DATEDIFF(month, 0, DATEADD(month, 0,            GETDATE())), 0),126) as month
   union all
    Select intCount+1, convert(char(10),DATEADD(month, DATEDIFF(month, 0, DATEADD(month, -(intCount+1), GETDATE())), 0),126) as month
	 from cte
                            where intCount<=24
 )
Select @cols = coalesce(@cols + ',','') + quotename(convert(varchar(10),month,120))

from cte order by month

;with cte(intCount,month)
 as
 (
   Select 0, 	       convert(char(10),DATEADD(month, DATEDIFF(month, 0, DATEADD(month, 0,            GETDATE())), 0),126) as month
   union all
    Select intCount+1, convert(char(10),DATEADD(month, DATEDIFF(month, 0, DATEADD(month, -(intCount+1), GETDATE())), 0),126) as month
	 from cte
                            where intCount<=24
 )
Select @sumcols = coalesce(@sumcols + '+','') + 'coalesce(' +  quotename(convert(varchar(10),month,120)) + ',0)'

from cte order by month

;with cte(intCount,month)
 as
 (
   Select 0, 	       convert(char(10),DATEADD(month, DATEDIFF(month, 0, DATEADD(month, 0,            GETDATE())), 0),126) as month
   union all
    Select intCount+1, convert(char(10),DATEADD(month, DATEDIFF(month, 0, DATEADD(month, -(intCount+1), GETDATE())), 0),126) as month
	 from cte
                            where intCount<=24
 )
Select @colheads = coalesce(@colheads + ',','') + 'coalesce(' +  quotename(convert(varchar(10),month,120)) + ',0) as ' + quotename(convert(varchar(10),month,120))

from cte order by month
print @colheads

select @query =
'select [Territory Code], description, ' + @colheads + ',
' + @sumcols + ' as [total] from 
 (select
	rtrim(ac.territory_code) as ''Territory Code'',
	t.description,	
	convert(char(10),DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0),126) as ''month'',
	convert(int,round(sum(sh.sales_amt),0,0)) as sales
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

if @debug = 1 
Begin  

   Print @query
      exec SP_EXECUTESQL @query
    End
Else 
Begin

Exec SP_EXECUTESQL @query

End/;

  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;

  say Dumper( $fields);
  
  my $columns = [];
  # push @$columns, (
  #     { className => 'dt-right', data => 'Territory Code'},
  #     { className => 'dt-left', data => 'description', title => 'description'},
  #   );
  foreach my $field (@$fields) {
    if (List::MoreUtils::any { $_ eq $field} ('Territory Code') ) {
      push @$columns, { data => $field, className => 'dt-left' }; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('description') ) {
      push @$columns, { data => $field, className => 'dt-left nowrap smaller-font' }; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('total') ) {
      push @$columns, { data => $field, className => 'dt-right row_total' }; 
    } else {
      push @$columns, { data => $field, className => 'dt-right' }; 
    }
  }

  my $detail_url = body_parameters->get('detail_url');
  if ($detail_url) {
    say "detail_url = ",$detail_url;
    foreach my $row (@$rows) {
      my $full_detail_url = new URI $detail_url;
      $full_detail_url->query_form(territory_code => rtrim($row->{'Territory Code'}));
      $row->{'Territory Code'} = "<a href='" . $full_detail_url->as_string . "'>" . rtrim($row->{'Territory Code'}) . "</a>";
      $row->{'description'} = "<a href='" . $full_detail_url->as_string . "'>" . rtrim($row->{'description'}) . "</a>";
    };
    #my $extra_column =  { data => 'url', title => 'Row Name' };
    #unshift(@$columns, $extra_column); 
  }
  

  return {
    pageLength => 50,
    columns => $columns,
    data => [@$rows],
  };
  
};


any ['get','post'] => '/sales/territory-24-month-summary' => require_login \&territory_24_month_summary;


1;
