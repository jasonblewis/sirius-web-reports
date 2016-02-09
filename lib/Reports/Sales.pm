package Reports::Sales;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Data::Dumper;


sub menu {
  template 'Sales/Sales';
};

sub newstoresquaterlysales {

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
 DATEADD(qq, DATEDIFF(qq, 0, "zz_first_order_date"."inv_date"), 0) as firstorderquater
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

  template 'Sales/New Stores Quaterly Sales', {
    'title' => 'New Stores Quaterly Sales',
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



  prefix '/Sales' => sub {
    get ''                           => \&menu;
#    get '/New Stores Quaterly Sales'  => \&liststores;
    get '/New Stores Quaterly Sales'  => \&newstoresquaterlysales;
  };


1;
