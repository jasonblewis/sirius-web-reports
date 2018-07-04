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

package Reports::AccountsPayable;
use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;

sub menu {
  template 'ap/accounts-payable';
};

sub creditor_terms {

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
 FROM   "sirius9"."dbo"."ap_creditor" "ap_creditor" INNER JOIN "sirius9"."dbo"."term_rate" "term_rate" ON "ap_creditor"."term_code"="term_rate"."term_code"
 WHERE  "ap_creditor"."term_code"<>'0'/;

  $sth = database->prepare($term_sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $creditors = $sth->fetchall_arrayref({});
  $sth->finish;

  template 'ap/creditor-terms', {
    'title' => 'Creditor Terms',
    'servers' => $dat,
    'databases' => $dbnames,
    'fields' => $fields,
    'creditors' => $creditors,
  };



#  template 'AP/Creditor Terms';
};

sub detailed_trial_balance {

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
 "ap_transaction"."trans_date" as "ap_transaction_trans_date",
 "ap_transaction"."trans_amt" as "ap_transaction_trans_amt",
 "ap_creditor"."creditor_code" as ap_creditor_code,
 "ap_transaction"."ref_1",
 "ap_transaction"."creditor_code" as ap_trasaction_creditor_code,
 "ap_transaction"."supplier_code",
 "term_rate"."term_code",
 "term_rate"."term_method",
 "term_rate"."term_days",
 "term_rate"."discount_rate",
 "term_rate"."description",
 "zz_ap_last_payment"."trans_date" as "zz_ap_last_payment_trans_date",
 "zz_ap_last_payment"."trans_amt" as "zz_ap_last_payment_trans_amt",
 "zz_ap_allocation_total"."alloc_amt" as "zz_ap_allocation_total_alloc_amt",
 "ap_transaction"."trans_amt" - ISNULL("zz_ap_allocation_total"."alloc_amt",0) as owing
 FROM   ("sirius9"."dbo"."term_rate" "term_rate" INNER JOIN ("sirius9"."dbo"."zz_ap_last_payment" "zz_ap_last_payment" RIGHT OUTER JOIN (("sirius9"."dbo"."zz_ap_allocation_total" "zz_ap_allocation_total" FULL OUTER JOIN "sirius9"."dbo"."ap_transaction" "ap_transaction" ON ("zz_ap_allocation_total"."batch_nr"="ap_transaction"."batch_nr") AND ("zz_ap_allocation_total"."batch_line_no"="ap_transaction"."batch_line_no")) INNER JOIN "sirius9"."dbo"."ap_creditor" "ap_creditor" ON "ap_transaction"."creditor_code"="ap_creditor"."creditor_code") ON "zz_ap_last_payment"."creditor_code"="ap_creditor"."creditor_code") ON "term_rate"."term_code"="ap_creditor"."term_code") INNER JOIN "sirius9"."dbo"."company" "company" ON "ap_creditor"."company_code"="company"."company_code"
 WHERE  "ap_transaction"."completed_date" IS  NULL  AND ("zz_ap_allocation_total"."alloc_amt" IS  NULL  OR "zz_ap_allocation_total"."alloc_amt"<>"ap_transaction"."trans_amt")
 ORDER BY "ap_creditor"."creditor_code", "ap_transaction"."trans_date"/;

  $sth = database->prepare($term_sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  #print Dumper($rows);
  $sth->finish;

  template 'ap/detailed-trial-balance', {
    'title' => 'Detailed Trial Balance',
    'servers' => $dat,
    'databases' => $dbnames,
    'fields' => $fields,
    'rows' => $rows,
    'longreadlen' => database->{LongReadLen},
    'longtruncok' => database->{LongTruncOk},
  };

};



prefix '/accounts-payable' =>  sub {
  get ''                        => require_login \&menu;
  get '/creditor-terms'         => require_login \&creditor_terms;
  get '/detailed-trial-balance' => require_login \&detailed_trial_balance;
};


1;
