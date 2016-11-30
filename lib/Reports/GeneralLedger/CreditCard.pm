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

package Reports::GeneralLedger::CreditCard;
use 5.22.0;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;

sub credit_card_reconciliation {
  my $account_code;

  my $columns = encode_json([
    { data => 'trans_date',  title => 'Transaction Date', className => 'text-left', formatfn => 'formatdate' },
    { data => 'amt',         title => 'Amount', className => 'text-right', formatfn => 'round2dp' },
    { data => 'running total', title => 'Total', className => 'text-right', formatfn => 'round2dp' },
    { data => 'posted_flag', title => 'Posted?', className => 'text-center' },
    { data => 'description', title => 'Description', className => 'text-left' },
    { data => 'year',        title => 'Year', className => 'text-left' },
    { data => 'period',      title => 'Period', className => 'text-left' },
    { data => 'source',      title => 'Source', className => 'text-left' },
    { data => 'seq',         title => 'Seq', className => 'text-left' },
    { data => 'jnl',         title => 'Journal', className => 'text-left' },
  ]);
  
  if (params->{account_code}) {
    $account_code = route_parameters->get('account_code');
  } else {
    warn "account_code not supplied";
  }
  
  template 'gl/credit-card-reconciliation', {
    title => "Credit Card Reconciliation",
    sub_title => "$account_code",
    columns => $columns,
    dt_options => {
      ordering => 'false',
      dom      => 'lBfrtip',
      lengthMenu => '[10,25,50,75,100]',
      responsive => 'true',
      pageLength => 50,
      paging => 'true',
      page   => 'last',
      row_contextual_class => 'row_contextual_class',
      row_tooltip => 'WARNING: Transaction Date out of period',
    },
    caption => "<h4>Credit Card Reconciliation for $account_code</h4>",
    json_data_url => "/api/general-ledger/credit-card-reconciliation/$account_code"
   }
};

prefix '/general-ledger' => sub {
  get '/credit-card/reconciliation' => require_login \&get_credit_card_account_code;
  get '/credit-card/reconciliation/:account_code' => require_login \&credit_card_reconciliation;
};

1;
