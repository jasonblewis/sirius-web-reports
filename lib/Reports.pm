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

package Reports;
use strict;
use warnings;
use 5.22.0;
use Dancer2;
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Session::Cookie;
use DBI;
use Reports::AccountsReceivable;
use Reports::AccountsPayable;
use Reports::Sales;
use Reports::Purchasing;
use Reports::Login;
use Reports::GeneralLedger::Accounts;
use Reports::Utils qw(compare_url_segments);

set 'logger'       => 'console';
#set 'log'          => 'error';
set 'show_errors'  => 1;
set 'startup_info' => 1;
set 'warnings'     => 1;
set 'show_errors'  => 1;
set 'startup_info' => 1;
set 'warnings'     => 1;

our $VERSION = '0.1';

Reports::Utils::set_logger( sub {debug @_});

my $order_columns = encode_json([
  {  data => 'first_name', title=>'User', className => 'text-left',      },
  {  data => 'name',       title=>'Store Name', className => 'text-left',      },
  {  data => 'order_no',   title=>'Order<br>Number', className => 'text-right',      },
  {  data => 'amount',     title=>'Total', className => 'text-right', formatfn => 'round2dp',   },

  { data => 'order_date',
    render => {"_" => 'order_date',
            },
    title=>'Age',
    orderable => false,
    className => 'text-right',
    formatfn => 'fromnow',
    type => 'date' },


  
  {  data => 'order_date_sortable', title=>'Date', className => 'text-right', 'visible' => true, type => 'date' },
  {  data => 'order_status', title=>'Order<br>Status', className => 'text-right'},
  {  data => 'branch_code', title=>'Branch', className => 'text-right'},
  {  data => 'territory_code', title=>'Ter', className => 'text-right'},
  
],);

my $credit_columns = encode_json([
  {  data => 'name',       title=>'Store Name', className => 'text-left',      },
  {  data => 'order_no',   title=>'Credit<br>Number', className => 'text-right',      },
  {  data => 'amount',     title=>'Total', className => 'text-right', formatfn => 'round2dp',   },
 # {  data => 'order_date', title=>'Date', className => 'text-right', formatfn => 'fromnow', orderData => 4, },
  {  data => {"_" => 'order_date',
              sort => 'order_date_sortable',
            },
              title=>'Age', className => 'text-right', formatfn => 'fromnow', orderData => 4, },
#  {  data => 'odts', title=>'Date timestamp', className => 'text-right', 'visible' => false },
  {  data => 'order_status', title=>'Credit<br>Status', className => 'text-right'},
  
],);
my $invoice_columns = encode_json([
  {  data => 'name',       title=>'Store Name', className => 'text-left',      },
  {  data => 'invoice_no',   title=>'Invoice<br>Number', className => 'text-right',      },
  {  data => 'total inc gst',     title=>'Total', className => 'text-right', formatfn => 'round2dp',   },
  {  data => 'invoice_date', title=>'Date', className => 'text-right', formatfn => 'fromnow' },
  
],);

hook before => sub {
  var compare_url_segments => \&Reports::Utils::compare_url_segments;
};

get '/' => require_login sub {
  template 'index', {
    title => 'OT Reports',
    order_columns => $order_columns,
    outstanding_sales_orders_url => '/api/sales/outstanding-sales-orders',
    order_table_caption => '<h4>Outstanding Orders</h4>',

    credit_columns => $credit_columns,
    outstanding_sales_credits_url => '/api/sales/outstanding-sales-credits',
    credit_table_caption => '<h4>Outstanding Credits</h4>',

    invoice_columns => $invoice_columns,
    sales_invoices_url => '/api/sales/sales-invoices',
    invoice_table_caption => '<h4>Invoices</h4>',

  };
};

1;
