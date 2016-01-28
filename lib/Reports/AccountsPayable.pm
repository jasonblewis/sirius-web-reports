package Reports::AccountsPayable;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Data::Dumper;

sub menu {
  template 'AP/Accounts Payable';
};

sub creditorterms {

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

  my $term_sql = qq/SELECT "ap_creditor"."creditor_code", "ap_creditor"."term_code", "term_rate"."description", "term_rate"."term_days", "term_rate"."term_method", "term_rate"."discount_rate"
 FROM   "siriusv8"."dbo"."ap_creditor" "ap_creditor" INNER JOIN "siriusv8"."dbo"."term_rate" "term_rate" ON "ap_creditor"."term_code"="term_rate"."term_code"
 WHERE  "ap_creditor"."term_code"<>'0'/;

  $sth = database->prepare($term_sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $creditors = $sth->fetchall_arrayref({});
  $sth->finish;

  template 'AP/Creditor Terms', {
    'title' => 'Creditor Terms',
    'servers' => $dat,
    'databases' => $dbnames,
    'fields' => $fields,
    'creditors' => $creditors,
  };



#  template 'AP/Creditor Terms';
};

sub detailedtrialbalance {

  my $sth;
  my $sth_dbname;
  my $dat;
  my $dbnames;

  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  

  $sth = database->prepare("select \@\@servername as name")  or die "Can't prepare: $DBI::errstr\n";
  $sth->execute or die $sth->errstr;
  $dat = $sth->fetchall_arrayref({});
  $sth->finish;

  $sth_dbname = database->prepare("select DB_NAME() as name;") or die "can't prepare\n";
  $sth_dbname->execute or die $sth_dbname->errstr;
  $dbnames = $sth_dbname->fetchall_arrayref({});
  $sth_dbname->finish;

  my $term_sql = qq/ SELECT 
 "company"."name",
 "ap_transaction"."completed_date",
 "ap_transaction"."trans_date",
 "ap_transaction"."trans_amt",
 "ap_creditor"."creditor_code",
 "ap_transaction"."ref_1",
 "ap_transaction"."creditor_code",
 "ap_transaction"."supplier_code",
 "term_rate"."term_code",
 "term_rate"."term_method",
 "term_rate"."term_days",
 "term_rate"."discount_rate",
 "term_rate"."description",
 "zz_ap_last_payment"."trans_date",
 "zz_ap_last_payment"."trans_amt",
 "zz_ap_allocation_total"."alloc_amt"
 FROM   ("siriusv8"."dbo"."term_rate" "term_rate" INNER JOIN ("siriusv8"."dbo"."zz_ap_last_payment" "zz_ap_last_payment" RIGHT OUTER JOIN (("siriusv8"."dbo"."zz_ap_allocation_total" "zz_ap_allocation_total" FULL OUTER JOIN "siriusv8"."dbo"."ap_transaction" "ap_transaction" ON ("zz_ap_allocation_total"."batch_nr"="ap_transaction"."batch_nr") AND ("zz_ap_allocation_total"."batch_line_nr"="ap_transaction"."batch_line_nr")) INNER JOIN "siriusv8"."dbo"."ap_creditor" "ap_creditor" ON "ap_transaction"."creditor_code"="ap_creditor"."creditor_code") ON "zz_ap_last_payment"."creditor_code"="ap_creditor"."creditor_code") ON "term_rate"."term_code"="ap_creditor"."term_code") INNER JOIN "siriusv8"."dbo"."company" "company" ON "ap_creditor"."company_code"="company"."company_code"
 WHERE  "ap_transaction"."completed_date" IS  NULL  AND ("zz_ap_allocation_total"."alloc_amt" IS  NULL  OR "zz_ap_allocation_total"."alloc_amt"<>"ap_transaction"."trans_amt")
 ORDER BY "ap_creditor"."creditor_code", "ap_transaction"."trans_date"/;

  $sth = database->prepare($term_sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  #print Dumper($rows);
  $sth->finish;

  template 'AP/Detailed Trial Balance', {
    'title' => 'Detailed Trial Balance',
    'servers' => $dat,
    'databases' => $dbnames,
    'fields' => $fields,
    'rows' => $rows,
    'longreadlen' => database->{LongReadLen},
    'longtruncok' => database->{LongTruncOk},
  };

};



prefix '/Accounts Payable' => sub {
  get ''                           => \&menu;
  get '/Creditor Terms'      => \&creditorterms;
  get '/Detailed Trial Balance' => \&detailedtrialbalance;
};


1;
