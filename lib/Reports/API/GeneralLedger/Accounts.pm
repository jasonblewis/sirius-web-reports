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

package Reports::API::GeneralLedger::Accounts;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Database;
use Reports::Utils qw(rtrim);
use Data::Dumper;
use URI;
use Math::Round;
sub accounts {
  my $sql = q{
              set transaction isolation level read uncommitted
              select * from zz_gl_account
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

sub gl_account_reconciliation {
  my $account_code = route_parameters->get('account_code');
  my $sql = q{
set transaction isolation level read uncommitted
SELECT
 batch_no,
 trans,
 p.period_start,
 p.period_end,
 "gl_transaction"."amt",
 case when ((gl_transaction.trans_date < p.period_start) or (gl_transaction.trans_date > p.period_end)) then 'warning' else null end as [row_contextual_class],
 "gl_transaction"."posted_flag",
 "gl_transaction"."year",
 "gl_transaction"."period",
 "gl_transaction"."trans_date",
 "gl_transaction"."seq",
 "gl_transaction"."description",
 "gl_transaction"."source",
 "gl_transaction"."jnl",
 "zz_gl_account"."account",
 "zz_gl_account"."name",
 "gl_account_idx"."account"
FROM  
 "sirius9"."dbo"."gl_transaction" "gl_transaction" 
INNER JOIN
 (  "sirius9"."dbo"."gl_account_idx" "gl_account_idx"
    INNER JOIN "sirius9"."dbo"."zz_gl_account" "zz_gl_account"
	 ON 
	 "gl_account_idx"."account"="zz_gl_account"."account")
ON "gl_transaction"."account"="zz_gl_account"."account"

  join period p
  on gl_transaction.year = p.year and
     gl_transaction.period = p.period 
	 and p.period_type = 'FM'


WHERE  
("zz_gl_account"."account"= ? and
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

  my $rt = 0; # make a running total column
  foreach my $row (@$rows) {
    $rt = nearest(0.01,$rt + nearest(0.01,$row->{amt}));
    $row->{RT} = $rt;
  };

    say Dumper($rows->[0]);

  return {
    data => $rows,
  }

}

any ['get','post'] => '/general-ledger/account' => require_role GL => \&accounts;
any ['get','post'] => '/general-ledger/account-reconciliation/:account_code' => require_role GL => \&gl_account_reconciliation;

1;
