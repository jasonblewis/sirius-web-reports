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

package Reports::Purchasing::CombinedSalesHistory;
use 5.22.0;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;

sub get_supplier_code {
  my $columns = encode_json([
    { data => 'name',
      title => 'Supplier',
      formatfn => 'render_url',
      'target_url' => request->uri . '/',
      'target_url_id_col' => 'supplier_code',
    },
    { data => 'supplier_code',
      title => 'Supplier_code',
    },
  ]);
  template 'utils/get-selection-json2', {
    title => 'Combined Warehouse Sales History<br><small>Select supplier</small>',
    columns => $columns,
    dt_options => {
      ordering => 'true',
      dom      => 'lfrtip',
      lengthMenu => '[10,25,50,75,100]',
      responsive => 'true',
      pageLength => 50,
      paging => 'false',
    },
    json_data_url => "/api/accounts-payable/suppliers",
  }
}


sub combined_sales_history {

    my $columns = encode_json([
    { data => 'trans_date',  title => 'Transaction Date', className => 'text-left', formatfn => 'formatdate' },
    { data => 'amt',         title => 'Amount', className => 'text-right', formatfn => 'round2dp' },
    { data => 'RT',           title => 'Running<br>Total', className => 'text-right' },
    { data => 'posted_flag', title => 'Posted?', className => 'text-center' },
    { data => 'description', title => 'Description', className => 'text-left' },
    { data => 'year',        title => 'Year', className => 'text-left' },
    { data => 'period',      title => 'Period', className => 'text-right' },
    { data => 'source',      title => 'Source', className => 'text-left' },
    { data => 'seq',         title => 'Seq', className => 'text-right' },
    { data => 'jnl',         title => 'Journal', className => 'text-right' },
  ]);
  


  template 'purchasing/combined-sales-history', {
    title => "Combined Warehouse Sales History",
    columns => $columns,
    dt_options => {
      ordering => 'false',
      dom      => 'lBfrptip',
      lengthMenu => '[10,25,50,75,100]',
      responsive => 'true',
      pageLength => 50,
      paging => 'true',
      page   => 'last',
    },
    caption => "<h4>Combined Warehouse Sales History</h4>",
    json_data_url => "/api/purchasing/combined-sales-history",
  }
    
};


prefix '/purchasing' => sub {
  get '/combined-sales-history' => require_login \&get_supplier_code;
  get '/combined-sales-history:supplier_code'  => require_login \&combined_sales_history;
};

1;
