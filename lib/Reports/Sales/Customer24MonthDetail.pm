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

package Reports::Sales::Customer24MonthDetail;
use 5.22.0;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;

sub get_customer {
    my $columns = encode_json([
    { data => 'company.name',
      title => 'Customer',
      formatfn => 'render_url',
      'target_url' => request->uri . '/',
      'target_url_id_col' => 'customer_code',
    },
    { data => 'customer_code',
      title => 'Customer Code',
    },
  ]);

  template 'utils/get-selection-json2', {
    title => 'Customer 24 Month Detail <small>Select a customer</small>',
    columns => $columns,
    dt_options => {
      ordering => 'true',
      dom      => 'lfrtip',
      lengthMenu => '[10,25,50,75,100]',
      responsive => 'true',
      pageLength => 50,
      paging => 'false',
    },
    json_data_url => "/api/accounts-receivable/customers",
  }
}

sub customer_24_month_detail {
  my $customer_code;
  
  if (params->{customer_code}) {
    $customer_code = params->{customer_code}
  } else {
    warn "customer_code not supplied";
  }
  
  my $filter = query_parameters->get('filter');
    
  my $columns = [
    { data => 'product_code', title => 'Product<br>Code' },
    { data => 'description',  title => 'Description'},
    { data => 'primary_supplier', title => 'Primary Supplier',
      visible => false},
  ];

  # todo - make this a function in utils or somewhere
  my $months = 24;
    for (my $i = $months; $i >= 0; $i--) {
    push @$columns, {
      data => DateTime->now->subtract(months => $i)->strftime('%Y-%m-01'),
      title => DateTime->now->subtract(months => $i)->strftime('%Y<br>%m'),
      className => 'text-right',
      formatfn => 'round0dp',
    };
  }

  

  template 'sales/customer-24-month-detail', {
    title => "Customer 24 Month Detail of $customer_code",
    #sub_title => "purchased in last 365 days",
    json_data_url => "/api/sales/customer-24-month-detail/$customer_code",
    columns => encode_json($columns),
    dt_options => {
      ordering => 'true',
      dom      => 'lBfrtip',
      lengthMenu => '[10,25,50,75,100]',
      responsive => 'true',
      pageLength => 50,
      paging => 'false',
      filter => $filter,
    },

  }
};

prefix '/sales' => sub {
  get '/customer-24-month-detail' => require_any_role [qw(GL BG stockist)] => \&get_customer;
  get '/customer-24-month-detail/:customer_code' => require_any_role [qw(GL BG stockist)] => \&customer_24_month_detail;
};

1;

