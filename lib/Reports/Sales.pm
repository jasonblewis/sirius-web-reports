package Reports::Sales;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;


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
        "siriusv8"."dbo"."sh_transaction" "sh_transaction"
 INNER JOIN
       "siriusv8"."dbo"."zz_first_order_date" "zz_first_order_date"
     ON
     ("sh_transaction"."invoice_date">="zz_first_order_date"."inv_date")
     AND
     ("sh_transaction"."customer_code"="zz_first_order_date"."customer_code"))
 INNER JOIN
        "siriusv8"."dbo"."ar_customer" "ar_customer"
     ON
     "sh_transaction"."customer_code"="ar_customer"."customer_code")
 INNER JOIN
     "siriusv8"."dbo"."company" "company"
     ON
     "ar_customer"."company_code"="company"."company_code"
 WHERE
 "sh_transaction"."invoice_date">=DATEADD(qq, DATEDIFF(qq, 0, @mydate)-1, 0)
 AND
 "zz_first_order_date"."inv_date">=DATEADD(qq, DATEDIFF(qq, 0, @mydate)-1, 0)
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
  database->{LongReadLen} = 1000000;
  database->{LongTruncOk} = 0;
  my $territory_code = query_parameters->get('territory_code');
  
  unless ($territory_code)   {
    list_territories('/sales/territory-24-month-detail');
  } else { # don't know which territory the user wants yet, so ask them then redirect to the real report template
    
    my $sql = q/Set transaction isolation level read uncommitted;
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
                	ac.customer_code as ''Customer Code'', ac.name,
                	DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0) as ''month'',
                	sum(sh.sales_amt) as sales
                 from sh_transaction sh
                join ar_cust_ex_shipto_view ac on sh.customer_code = ac.customer_code
                where sh.invoice_date >= DATEADD(YEAR, DATEDIFF(YEAR, 0, DATEADD(YEAR, -2, GETDATE())), 0)
                and ltrim(rtrim(ac.territory_code)) = ''' + @territory + '''
                group by ac.territory_code, ac.customer_code, ac.name, DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0) ) x
                pivot
                (
                  sum(sales)
                  for [month] in ( ' + @cols + ' )
                ) p'

                EXEC SP_EXECUTESQL @query
/;
    warn $sql;
    
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
      'title' => 'Territory Detail',
      'fields' => $fields,
      'rows' => $rows,
    };
  };
};

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
  template 'sales/territory-24-month-summary', {
    'title' => 'Territory Summary',
    'detail_url' => '/sales/territory-24-month-detail',
    'fields' => $fields,
    'rows' => $rows,
  };
};


prefix '/sales' => sub {
  get ''                            => require_login \&menu;
  get '/new-stores-quarterly-sales' => require_login \&new_stores_quarterly_sales;
  get '/territory-24-month-detail'  => require_login \&territory_24_month_detail;
  get '/territory-24-month-summary' => require_login \&territory_24_month_summary;
};


1;
