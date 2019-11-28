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

package Reports::Sales;
use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;
use Reports::Sales::StockistsBySupplier;
use Reports::Sales::Customer24MonthDetail;

sub menu {
  template 'sales/sales';
};

sub new_stores_quarterly_sales {
  my $sth;
  my $sth_dbname;
  my $dat;
  my $dbnames;
  $sth = database->prepare("select \@\@servername as name")  or die "Can't prepare: $DBI::errstr\n";
  $sth->execute or die $sth->errstr;
  $dat = $sth->fetchall_arrayref({});
  $sth->finish;

  $sth_dbname = database->prepare("select DB_NAME() as name;") or die "can't prepare\n";
  $sth_dbname->execute or die $sth_dbname->errstr;
  $dbnames = $sth_dbname->fetchall_arrayref({});
  $sth_dbname->finish;

  my $term_sql = q/Set transaction isolation level read uncommitted;
declare @mydate datetime
set @mydate = getdate()
SELECT "zz_first_order_date"."customer_code",
 "zz_first_order_date"."inv_date" as "first_order_inv_date",
 "sh_transaction"."sales_amt",
 "sh_transaction"."profit_amt",
 "sh_transaction"."invoice_date",
 "company"."territory_code",
 "ar_customer"."sales_rep_code",
 "company"."name",
 DATEADD(qq, DATEDIFF(qq, 0, "zz_first_order_date"."inv_date"), 0) as firstorderquarter
 FROM   ((
        "sirius9"."dbo"."sh_transaction" "sh_transaction"
 INNER JOIN
       "sirius9"."dbo"."zz_first_order_date" "zz_first_order_date"
     ON
     ("sh_transaction"."invoice_date">="zz_first_order_date"."inv_date")
     AND
     ("sh_transaction"."customer_code"="zz_first_order_date"."customer_code"))
 INNER JOIN
        "sirius9"."dbo"."ar_customer" "ar_customer"
     ON
     "sh_transaction"."customer_code"="ar_customer"."customer_code")
 INNER JOIN
     "sirius9"."dbo"."company" "company"
     ON
     "ar_customer"."company_code"="company"."company_code"
 WHERE
 "sh_transaction"."invoice_date">=DATEADD(qq, DATEDIFF(qq, 0, @mydate)-2, 0)
 AND
 "zz_first_order_date"."inv_date">=DATEADD(qq, DATEDIFF(qq, 0, @mydate)-2, 0)
 order by DATEADD(qq, DATEDIFF(qq, 0, "zz_first_order_date"."inv_date"), 0) desc, customer_code/;

  $sth = database->prepare($term_sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;

  template 'sales/new-stores-quarterly-sales', {
    'title' => 'New Stores Quarterly Sales',
    'servers' => $dat,
    'databases' => $dbnames,
    'fields' => $fields,
    'rows' => $rows,
  };

};

sub list_customers {
  my $target = shift;

  my $sth;
  my $sth_dbname;
  my $dat;
  my $dbnames;
  $sth = database->prepare("select \@\@servername as name")  or die "Can't prepare: $DBI::errstr\n";
  $sth->execute or die $sth->errstr;
  $dat = $sth->fetchall_arrayref({});
  $sth->finish;

  $sth_dbname = database->prepare("select DB_NAME() as name;") or die "can't prepare\n";
  $sth_dbname->execute or die $sth_dbname->errstr;
  $dbnames = $sth_dbname->fetchall_arrayref({});
  $sth_dbname->finish;

  my $term_sql = qq/Set transaction isolation level read uncommitted;
SELECT ar_customer.customer_code, company.name
                 from ar_customer
join company
on ar_customer.company_code = company.company_code/;

  $sth = database->prepare($term_sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;

  template 'sales/list-customers', {
    'target' => $target,
    'title' => 'Stores',
    'servers' => $dat,
    'databases' => $dbnames,
    'fields' => $fields,
    'rows' => $rows,
  };

};

sub list_territories {

  my $target = shift;

  my $sth;
  my $sth_dbname;
  my $dat;
  my $dbnames;
  $sth = database->prepare("select \@\@servername as name")  or die "Can't prepare: $DBI::errstr\n";
  $sth->execute or die $sth->errstr;
  $dat = $sth->fetchall_arrayref({});
  $sth->finish;

  $sth_dbname = database->prepare("select DB_NAME() as name;") or die "can't prepare\n";
  $sth_dbname->execute or die $sth_dbname->errstr;
  $dbnames = $sth_dbname->fetchall_arrayref({});
  $sth_dbname->finish;

  my $term_sql = qq/Set transaction isolation level read uncommitted;
                    select 
                     rtrim(territory_code) as territory_code,
                     rtrim(description) as description
                    from dbo.territory
                    where
                    territory_code not in ('ZCNV','ZUNK')
                    and
                    active_flag = 'Y'/;

  $sth = database->prepare($term_sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;

  template 'sales/list-territories', {
    'target' => $target,
    'title' => 'Territories',
    'servers' => $dat,
    'databases' => $dbnames,
    'fields' => $fields,
    'rows' => $rows,
  };
};



sub territory_24_month_detail {
  my $dbh = database(); 
  $dbh->{LongReadLen} = 100000;
  $dbh->{LongTruncOk} = 1;
 

  my $territory_code = query_parameters->get('territory_code');
  
  unless ($territory_code)   {
    list_territories('/sales/territory-24-month-detail');
  } else { # don't know which territory the user wants yet, so ask them then redirect to the real report template
    
    my $sql = q/
Set transaction isolation level read uncommitted;
Declare @debug bit
set @debug = 0


                declare @cols as nvarchar(max),@query as nvarchar(max)
                declare @territory as nvarchar(max);
                set @territory = ?;
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
                	ac.customer_code as ''Customer Code'',
			ac.name as [Customer Name],
	                d.stop_flag as [On Hold],
                	DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0) as ''month'',
                	sum(sh.sales_amt) as sales
                 from sh_transaction sh
                join ar_cust_ex_shipto_view ac on sh.customer_code = ac.customer_code
				join ar_debtor d on ac.debtor_code = d.debtor_code
                where sh.invoice_date >= DATEADD(YEAR, DATEDIFF(YEAR, 0, DATEADD(YEAR, -2, GETDATE())), 0)
                and ltrim(rtrim(ac.territory_code)) = ''' + @territory + '''
                group by ac.territory_code, ac.customer_code, ac.name,ac.debtor_code,d.stop_flag, DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0) ) x
                pivot
                (
                  sum(sales)
                  for [month] in ( ' + @cols + ' )
                ) p'

if @debug = 1 Begin     Print @query End
Else 
Begin Exec SP_EXECUTESQL @query End
 /;
    
    my $sth = database->prepare($sql) or die "can't prepare\n";
    $sth->bind_param(1,$territory_code);
    $sth->execute or die $sth->errstr;
    my $fields = $sth->{NAME};
    my $rows = $sth->fetchall_arrayref({});
    $sth->finish;

    $sth = database->prepare(q/select top 1 * from territory where territory_code = ?/) or die "can't prepare\n";
    $sth->bind_param(1,$territory_code);
    $sth->execute or die $sth->errstr;
    my $territory = $sth->fetchall_arrayref({});
    $sth->finish;
    
    
    template 'sales/territory-24-month-detail', {
      territory_code => $territory_code,
      territory_row => $territory,
      'title' => "Rolling 24 Month Detailed Territory Sales $territory->[0]{description}",

      'detail_url' => '/sales/customer-24-month-detail',
      'fields' => $fields,
      'rows' => $rows,
    };
  };
};

sub territory_24_month_summary {
  my $columns = [
    {data => 'Territory Code',
     title => 'Territory',
     className => 'text-center',
     formatfn => 'render_url',
     target_url => '/sales/territory-24-month-detail?territory_code=',
     target_url_id_col => 'Territory Code',
   },
    {data => 'description',
     formatfn => 'render_url',
     target_url => '/sales/territory-24-month-detail?territory_code=',
     target_url_id_col => 'Territory Code',
   },
  ];
  for (my $i = 25; $i >= 0; $i--) {
    push @$columns, {
      data => DateTime->now->subtract(months => $i)->strftime('%Y-%m-01'),
      title => DateTime->now->subtract(months => $i)->strftime('%Y<br>%m'),
      className => 'text-right',
    };
  }
  push @$columns, {data => 'total',className => 'text-right', title => 'Total', };
  template 'sales/territory-24-month-summary',
    {
      json_data_url => "/api/sales/territory-24-month-summary",
      columns => encode_json($columns),
      title => "Territory 24 Month Rolling summary",
      dt_options => {
        ordering => 'true',
        dom      => 'lBfrtip',
        lengthMenu => '[10,25,50,75,100]',
        responsive => 'true',
        pageLength => 50,
        paging => 'true',
      },
    };
};



sub select_customer {
  my ($target_url) = @_;
  template 'ar/select-customer',
    { title => 'Select Customer',
      json_data_url => '/api/accounts-receivable/customers',
      target_url => $target_url}
}



sub debtor_24_month_detail {
  my $dbh = database(); 
  $dbh->{LongReadLen} = 100000;
  $dbh->{LongTruncOk} = 1;
 

  my $debtor_code = query_parameters->get('debtor_code');

  unless ($debtor_code) {
    select_debtor('/sales/debtor-24-month-detail');
  } else { # don't know which debtor the user wants yet, so ask them then redirect to the real report template
    
    my $sql = q/
Set transaction isolation level read uncommitted;

Declare @debug bit
set @debug = 0


declare @cols as nvarchar(max),@query as nvarchar(max)
declare @debtor as nvarchar(max);
set @debtor = ?;
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
DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0) as ''month'',
sum(sh.sales_qty) as sales_qty
from
 sh_select_trans_view sh
 join
 ar_customer cu
 on sh.customer_code = cu.customer_code
where sh.invoice_date >= DATEADD(YEAR, DATEDIFF(YEAR, 0, DATEADD(YEAR, -2, GETDATE())), 0)
and ltrim(rtrim(cu.debtor_code)) = ''' + @debtor + '''
group by sh.product_code, sh.description, DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0)   ) x
pivot
(
sum(sales_qty)
for [month] in ( ' + @cols + ' )
) p'

if @debug = 1 Begin     Print @query End
Else 
Begin Exec SP_EXECUTESQL @query End


/;
    
    my $sth = database->prepare($sql) or die "can't prepare\n";
    $sth->bind_param(1,$debtor_code);
    $sth->execute or die $sth->errstr;
    my $fields = $sth->{NAME};
    my $rows = $sth->fetchall_arrayref({});
    $sth->finish;

    $sth = database->prepare(q/select top 1 * from ar_debtor_selections_view where debtor_code = ?/) or die "can't prepare\n";
    $sth->bind_param(1,$debtor_code);
    $sth->execute or die $sth->errstr;
    my $debtor = $sth->fetchall_arrayref({});
    $sth->finish;
    
    
    template 'sales/customer-24-month-detail', {
      debtor_code => $debtor_code,
      debtor_row => $debtor,
      'title' => "Debtor 24 Month Detail $debtor_code",
      'fields' => $fields,
      'rows' => $rows,
    };
  };
}; # end sub debtor_24_month_detail

sub select_debtor {
  my ($target_url) = @_;
  template 'ar/select-customer',
    { title => 'Select Debtor',
      json_data_url => '/api/accounts-receivable/debtors',
      target_url => $target_url}
}



sub order_form_w_pricecode {
  my $customer = query_parameters->get('customer_code');
  unless ($customer) {
    select_customer('/sales/order-form-w-pricecode');
  } else {
    template 'sales/order-form-w-pricecode',
      {
	json_data_url => "/api/sales/order-form-w-pricecode/$customer",
	'title' => "Order Form $customer",
      };
  }
};

prefix '/sales' => sub {
  get ''                            => require_login \&menu;
  get '/new-stores-quarterly-sales' => require_login \&new_stores_quarterly_sales;
  get '/territory-24-month-summary' => require_login \&territory_24_month_summary;
  get '/territory-24-month-detail'  => require_login \&territory_24_month_detail;
  get '/debtor-24-month-detail'     => require_login \&debtor_24_month_detail;
  get '/order-form-w-pricecode'     => require_login \&order_form_w_pricecode;
  get '/stockists-by-supplier'      => require_login \&stockists_by_supplier;
};


1;
