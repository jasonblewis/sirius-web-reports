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

package Reports::Purchasing::MultiWarehouseSalesHistory;
use 5.22.0;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;
use Dancer2::Plugin::DBIC;


sub get_primary_supplier {
    my $columns = encode_json([
    { data => 'name',
      title => 'Supplier',
      formatfn => 'render_url',
      'target_url' => request->uri,
      'target_url_id_col' => 'supplier_code',
    },
    { data => 'supplier_code',
      title => 'Supplier Code',
    },
  ]);

  template 'utils/get-selection-json2', {
    title => 'Multi Warehouse Sales History <small>Select a primary Supplier</small>',
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

sub multi_warehouse_sales_history {
  my $supplier_code;
  
  if (params->{supplier_code}) {
    $supplier_code = params->{supplier_code}
  } else {
    warn "supplier_code not supplied";
  }
  
  template 'purchasing/multi-warehouse-sales-history', {
    title => "Multi Warehouse Sales History $supplier_code",
    caption => "<h4>Multi Warehouse Sales History $supplier_code</h4>",
    json_data_url => "/api/purchasing/multi-warehouse-sales-history/$supplier_code"
   }
};

prefix '/purchasing' => sub {
  get '/multi-warehouse-sales-history' => require_login \&get_primary_supplier;
  get '/multi-warehouse-sales-history/:supplier_code' => require_login \&multi_warehouse_sales_history;
};

1;
