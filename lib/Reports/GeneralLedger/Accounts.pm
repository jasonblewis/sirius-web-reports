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

package Reports::GeneralLedger::Accounts;
use 5.22.0;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;
use Dancer2::Plugin::DBIC;


sub get_gl_account_code {
  my $columns = encode_json([
    { data => 'name',
      title => 'GL Account',
      formatfn => 'render_url',
      'target_url' => request->uri . '/',
      'target_url_id_col' => 'account',
    },
    { data => 'account',
      title => 'Account Code',
    },
  ]);
  template 'utils/get-selection-json2', {
    title => 'GL Account Reconciliation<br><small>Select account</small>',
    columns => $columns,
    dt_options => {
      ordering => 'true',
      dom      => 'lfrtip',
      lengthMenu => '[10,25,50,75,100]',
      responsive => 'true',
      pageLength => 50,
      paging => 'false',
    },
    json_data_url => "/api/general-ledger/account",
  }
}

sub gl_account_reconciliation {
  my $account_code;

  my $columns = encode_json([
    { data => 'trans_date',  title => 'Transaction Date', className => 'text-left', formatfn => 'formatdate' },
    { data => 'amt',         title => 'Amount', className => 'text-right', formatfn => 'round2dp' },
    { data => 'RT',          title => 'Running<br>Total', className => 'text-right' },
    { data => 'posted_flag', title => 'Posted?', className => 'text-center' },
    { data => 'description', title => 'Description', className => 'text-left' },
    { data => 'year',        title => 'Year', className => 'text-left' },
    { data => 'period',      title => 'Period', className => 'text-right' },
    { data => 'source',      title => 'Source', className => 'text-left' },
    { data => 'seq',         title => 'Seq', className => 'text-right' },
    { data => 'jnl',         title => 'Journal', className => 'text-right' },
  ]);
  
  if (params->{account_code}) {
    $account_code = route_parameters->get('account_code');
  } else {
    warn "account_code not supplied";
  }
  # stefan says check account code is valid, throw some error if not.

  my $gl_account = schema->resultset('Gl_Account')->search({account => $account_code})->single;
  my $gl_account_select_view = schema->resultset('Gl_Account')->find($account_code);
  my $gl_account_name = $gl_account_select_view->name;

  
  template 'gl/gl-account-reconciliation', {
    title => "GL Account Reconciliation",
    sub_title => "$gl_account_name ($account_code)",
    columns => $columns,
    dt_options => {
      ordering => 'false',
      dom      => 'lBfrptip',
      lengthMenu => '[10,25,50,75,100]',
      responsive => 'true',
      pageLength => 50,
      paging => 'true',
      page   => 'last',
      row_contextual_class => 'row_contextual_class',
      row_tooltip => 'WARNING: Transaction Date out of period',
    },
    caption => "GL Acount Reconciliation for $account_code",
    json_data_url => "/api/general-ledger/account-reconciliation/$account_code"
   }
};

prefix '/general-ledger' => sub {
  get '/account-reconciliation' => require_role GL => \&get_gl_account_code;
  get '/account-reconciliation/:account_code' => require_role GL => \&gl_account_reconciliation;
};

1;
