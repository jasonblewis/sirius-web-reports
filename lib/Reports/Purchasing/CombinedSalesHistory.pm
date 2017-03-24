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
use Dancer2::Plugin::DBIC;

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
    { data => 'product_code',   title => 'Product<br>Code', className => 'text-left'},
    { data => 'description',    title => 'Description', className => 'text-left border-right' },
    { data => 'on_hand',        title => 'On<br>Hand', className => 'text-right' },
    { data => 'on_order',       title => 'On<br>Order', className => 'text-right' },
    { data => 'so_committed',   title => 'SO<br>Comm', className => 'text-right' },
    { data => 'bt_committed',   title => 'BT<br>Comm', className => 'text-right' },
    { data => 'return_bin_qty', title => 'Return<br>Bin', className => 'text-right' },
    { data => 'available',      title => 'Available', className => 'text-right border-right' },
    { data => 'ms_5',           title => 'ms_5', className => 'text-right' },
    { data => 'ms_4',           title => 'ms_4', className => 'text-right' },
    { data => 'ms_3',           title => 'ms_3', className => 'text-right' },
    { data => 'ms_2',           title => 'ms_2', className => 'text-right' },
    { data => 'ms_1',           title => 'ms_1', className => 'text-right' },
    { data => 'ms_0',           title => 'ms_0', className => 'text-right border-right text-primary' },
    { data => 'mtotal',         title => '6 Month<br>Total', className => 'text-right' },
    { data => 'maximum',        title => 'Max<br>O/H', className => 'text-right' },
    { data => 'lead_time_days', title => 'Lead<br>Time', className => 'text-right' },
    { data => 'min_days_stock', title => 'Min<br>Days', className => 'text-right' },
    { data => 'reorder_class',  title => 'C', className => 'text-right' },
    { data => 'reorder_type',   title => 'T', className => 'text-left' },
  ]);
  
  my $supplier_code = route_parameters->get('supplier_code');
  my $supplier = schema->resultset('ApSupplier')->find($supplier_code);
  my $supplier_select_view = schema->resultset('ApSupplierSelectView')->find($supplier_code);
  my $supplier_notes = $supplier->notes;
  my $supplier_name = $supplier_select_view->name;
  my @supplier_emails = schema->resultset('ApSupplier')->find($supplier_code);
  template 'purchasing/combined-sales-history', {
    title => "Combined Warehouse Sales History",
    sub_title => "$supplier_name <small>($supplier_code)</small>",
    columns => $columns,
    dt_options => {
      ordering => 'false',
      dom      => 'Bfrti',
      lengthMenu => '[10,25,50,75,100]',
      responsive => 'true',
      pageLength => 50,
      paging => 'false',
      page   => 'last',
    },
    caption => "<h4>Combined Warehouse Sales History for $supplier_name</h4>",
    json_data_url => "/api/purchasing/combined-sales-history/$supplier_code",
    notes => $supplier_notes,
  }
    
};


prefix '/purchasing' => sub {
  get '/combined-sales-history' => require_login \&get_supplier_code;
  get '/combined-sales-history/:supplier_code'  => require_login \&combined_sales_history;
};

1;