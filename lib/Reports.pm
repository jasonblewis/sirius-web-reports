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

package Reports;
use strict;
use warnings;
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

set 'logger'       => 'console';
#set 'log'          => 'error';
set 'show_errors'  => 1;
set 'startup_info' => 1;
set 'warnings'     => 1;
set 'show_errors'  => 1;
set 'startup_info' => 1;
set 'warnings'     => 1;

our $VERSION = '0.1';

  my $order_columns = encode_json([
    {  data => 'name',       title=>'Store Name', className => 'text-left',      },
    {  data => 'order_nr',   title=>'Order<br>Number', className => 'text-right',      },
    {  data => 'amount',     title=>'Total', className => 'text-right', formatfn => 'round2dp',   },
    {  data => 'order_date', title=>'Date', className => 'text-right', formatfn => 'fromnow' },
    {  data => 'order_status', title=>'Order<br>Status', className => 'text-right'},
    
  ],);

  my $credit_columns = encode_json([
    {  data => 'name',       title=>'Store Name', className => 'text-left',      },
    {  data => 'order_nr',   title=>'Credit<br>Number', className => 'text-right',      },
    {  data => 'amount',     title=>'Total', className => 'text-right', formatfn => 'round2dp',   },
    {  data => 'order_date', title=>'Date', className => 'text-right', formatfn => 'fromnow' },
    {  data => 'order_status', title=>'Order<br>Status', className => 'text-right'},

  ],);

get '/' => require_login sub {
  template 'index', {
    order_columns => $order_columns,
    outstanding_sales_orders_url => '/api/sales/outstanding-sales-orders',
    order_table_caption => '<h4>Outstanding Orders</h4>',

    credit_columns => $credit_columns,
    outstanding_sales_credits_url => '/api/sales/outstanding-sales-credits',
    credit_table_caption => '<h4>Outstanding Credits</h4>',

  };
};

1;
