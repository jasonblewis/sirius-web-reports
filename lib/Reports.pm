package Reports;
use strict;
use warnings;
use Dancer2;
use DBI;
use Reports::AccountsReceivable;

set 'logger'       => 'console';
set 'log'          => 'debug';
set 'show_errors'  => 1;
set 'startup_info' => 1;
set 'warnings'     => 1;
set 'show_errors'  => 1;
set 'startup_info' => 1;
set 'warnings'     => 1;

our $VERSION = '0.1';


get '/' => sub {
  template 'index';
};


prefix '/Accounts Receivable' => sub {
  get ''                           => \&Reports::AccountsReceivable::menu;
  get '/Outstanding Invoices'      => \&Reports::AccountsReceivable::outstandinginvoices;
  get '/Statement Email Addresses' => \&Reports::AccountsReceivable::statementemailaddresses;
};


get '/database' => sub {
  my $dbh = DBI->connect("dbi:ODBC:DSN=demo",***REMOVED***, {PrintError => 1});
  my $dt;
  unless ($dbh) {
    die "Unable for connect to server $DBI::errstr";
  }
  my $sth;
  my $sth_dbname;
  my $dat;
  my $dbnames;
  $sth = $dbh->prepare("select \@\@servername as name")  or die "Can't prepare: $DBI::errstr\n";
  $sth->execute or die $sth->errstr;
  $dat = $sth->fetchall_arrayref({});
  $sth->finish;

  $dbh->do("use siriusv8;") or die "Can't use siriusv8: $DBI::errstr\n";
  $sth_dbname = $dbh->prepare("select DB_NAME() as name;") or die "can't prepare\n";
  $sth_dbname->execute or die $sth_dbname->errstr;
  $dbnames = $sth_dbname->fetchall_arrayref({});
  $sth_dbname->finish;

  my $term_sql = qq/SELECT "ap_creditor"."creditor_code", "ap_creditor"."term_code", "term_rate"."description", "term_rate"."term_days", "term_rate"."term_method", "term_rate"."discount_rate"
 FROM   "siriusv8"."dbo"."ap_creditor" "ap_creditor" INNER JOIN "siriusv8"."dbo"."term_rate" "term_rate" ON "ap_creditor"."term_code"="term_rate"."term_code"
 WHERE  "ap_creditor"."term_code"<>'0'/;

  $sth = $dbh->prepare($term_sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $creditors = $sth->fetchall_arrayref({});
  $sth->finish;

  template 'database', {
    'servers' => $dat,
    'databases' => $dbnames,
    'fields' => $fields,
    'creditors' => $creditors,
  };

};

1;
