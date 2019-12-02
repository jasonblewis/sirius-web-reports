# Copyright 2019 Jason Lewis

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

package Reports::Sales::StockistBySupplier;
use 5.22.0;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;

sub get_primary_supplier {
    my $columns = encode_json([
    { data => 'name',
      title => 'Supplier',
      formatfn => 'render_url',
      'target_url' => request->uri . '/',
      'target_url_id_col' => 'supplier_code',
    },
    { data => 'supplier_code',
      title => 'Supplier Code',
    },
  ]);

  template 'utils/get-selection-json2', {
    title => 'Stockists by supplier <small>Select a primary Supplier</small>',
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

sub stockists_by_supplier {
  my $supplier_code;
  
  if (params->{supplier_code}) {
    $supplier_code = params->{supplier_code}
  } else {
    warn "supplier_code not supplied";
  }
  

    
  my $columns = [
    { data => 'name',
      title => 'Store Name',
      formatfn => 'render_url',
      target_url => '/sales/customer-24-month-detail/',
      'target_url_id_col' => 'customer_code',
    },
    { data => 'phone',
      title => 'Phone Number',
      formatfn => 'render_url',
      'target_url' => 'tel:',
      'target_url_id_col' => 'phone',
    },
    { data => 'address_1', title => 'Address 1'},
    { data => 'address_3', title => 'Address 2'},
    { data => 'address_2', title => 'Address 3'},
    { data => 'postcode', title => 'Postcode'},
  ];


#  push @$columns, { data => '2015-11-01',className => 'text-right',formatfn => 'round2dp'};
  
  template 'sales/stockists-by-supplier', {
    title => "Stockists of $supplier_code",
    sub_title => "purchased in last 365 days",
    warning => "Confidential - data not for distribution outside Organic Trader",
    json_data_url => "/api/sales/stockists-by-supplier/$supplier_code",
    columns => encode_json($columns),
    dt_options => {
      ordering => 'true',
      dom      => 'lBfrtip',
      lengthMenu => '[10,25,50,75,100]',
      responsive => 'true',
      pageLength => 50,
      paging => 'false',
    },

  }
};

prefix '/sales' => sub {
  get '/stockists-by-supplier' => require_any_role [qw(GL BG stockist)] => \&get_primary_supplier;
  get '/stockists-by-supplier/:supplier_code' => require_any_role [qw(GL BG stockist)] => \&stockists_by_supplier;
};

1;

