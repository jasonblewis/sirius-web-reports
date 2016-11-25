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

package Reports::API::GeneralLedger::CreditCards;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Database;
use Reports::Utils qw(rtrim);
use Data::Dumper;
use URI;

sub credit_cards {
  my $sql = q{
              select * from zz_gl_account_creditcard
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

sub credit_card_reconciliation {
  my $account_code = route_parameters->get('account_code');
  my $sql = q{
set transaction isolation level read uncommitted
SELECT
 batch_code,
 trans,
 "gl_transaction"."amt",
 (select sum(t2.amt)
   from gl_transaction t2
   where 
     t2.account='20110' and (
	   ( t2."period"<>0 and 
	     (	 (t2.batch_code < gl_transaction.batch_code) or
             (t2.batch_code = gl_transaction.batch_code and t2.trans <= gl_transaction.trans))) 
	   or

 
       (t2."period"=0 AND t2."year"=2006))


  

	 ) as [running total],
 "gl_transaction"."posted_flag",
 "gl_transaction"."year",
 "gl_transaction"."period",
 "gl_transaction"."trans_date",
 "gl_transaction"."seq",
 "gl_transaction"."description",
 "gl_transaction"."source",
 "gl_transaction"."jnl",
 "zz_gl_account_creditcard"."account",
 "zz_gl_account_creditcard"."name",
 "gl_account_idx"."account"
FROM  
 "siriusv8"."dbo"."gl_transaction" "gl_transaction" 
INNER JOIN
 (  "siriusv8"."dbo"."gl_account_idx" "gl_account_idx"
    INNER JOIN "siriusv8"."dbo"."zz_gl_account_creditcard" "zz_gl_account_creditcard"
	 ON 
	 "gl_account_idx"."account"="zz_gl_account_creditcard"."account")
ON "gl_transaction"."account"="zz_gl_account_creditcard"."account"
WHERE  
("zz_gl_account_creditcard"."account"=? and
  (( "gl_transaction"."period"<>0 )
   OR 
  ("gl_transaction"."period"=0 AND "gl_transaction"."year"=2006)
  ))
ORDER BY "gl_transaction"."year",
  "gl_transaction"."period",
  "gl_transaction"."trans_date",
   "gl_transaction"."seq"

  };

  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->bind_param(1,$account_code);
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;
  
  return {
    data => $rows,
  }

}

any ['get','post'] => '/general-ledger/credit-cards' => require_login \&credit_cards;
any ['get','post'] => '/general-ledger/credit-card-reconciliation/:account_code' => require_login \&credit_card_reconciliation;

1;
