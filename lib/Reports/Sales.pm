package Reports::Sales;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;


sub menu {
  template 'Sales/Sales';
};

sub newstoresquarterlysales {

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

  template 'Sales/New Stores Quarterly Sales', {
    'title' => 'New Stores Quarterly Sales',
    'servers' => $dat,
    'databases' => $dbnames,
    'fields' => $fields,
    'rows' => $rows,
  };

};

sub liststores {

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

  my $term_sql = qq/SELECT ar_customer.customer_code, company.name
                 from ar_customer
join company
on ar_customer.company_code = company.company_code/;

  $sth = database->prepare($term_sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;

  template 'Sales/List Stores', {
    'title' => 'Stores',
    'servers' => $dat,
    'databases' => $dbnames,
    'fields' => $fields,
    'rows' => $rows,
  };

};



sub territory24month {

  my $sql = q/select  
	ac.customer_code,
	ac.territory_code,
	DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0) as 'sale month',
	sum(sh.sales_amt) as sales
 from sh_transaction sh
join ar_cust_ex_shipto_view ac on sh.customer_code = ac.customer_code
where ac.territory_code != sh.territory_code
and sh.invoice_date >= DATEADD(YEAR, DATEDIFF(YEAR, 0, DATEADD(YEAR, -2, GETDATE())), 0)
group by ac.territory_code, ac.customer_code, DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0)

order by DATEADD(month, DATEDIFF(month, 0, sh.invoice_date), 0)/;
  template 'Sales/Territory 24 Month';
};



  prefix '/Sales' => sub {
    get ''                            => require_login \&menu;
    get '/New Stores Quarterly Sales' => require_login \&newstoresquarterlysales;
    get '/Territory 24 Month'         => require_login \&territory24month;
  };


1;
