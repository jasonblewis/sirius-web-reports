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

package Reports::API::Sales;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::DBIC;

use DateTime::Duration;


# curl -b ~/.curl-cookies localhost:5000/api/sales/order-form-w-pricecode
sub order_form_w_pricecode {
  my $customer_code = route_parameters->get('customer_code');
  my $customer  = schema->resultset('ArCustomer')->find($customer_code);

  my $dtf = schema->storage->datetime_parser;

  
  my $duration = DateTime::Duration->new( months => 12 );
  my $start_date = DateTime->now - $duration;


  my @mrps = $customer->most_recent_purchases->search(
    { 'sh_transaction.sales_qty' => { '>=' => 0},
      'sh_transaction.invoice_date' => { '>=' => $dtf->format_datetime($start_date)},

    },
    { prefetch => { sh_transaction =>  ['product_list_today',
					{product => ['gst_tax_table', 'department']} ] } ,
      order_by => [qw( sh_transaction.department sh_transaction.product_code)],
     '+select' => [
       { '' => \'CONVERT(VARCHAR(10),sh_transaction.invoice_date,103)', '-as' => 'invoice_date_datepart'},
       { '' => \'convert(varchar,convert(decimal(8,2),product_list_today.cartonprice))', '-as' => 'cartonprice_2dp'},
       { '' => \'convert(varchar,convert(decimal(8,2),product_list_today.unitprice))', '-as' => 'unitprice_2dp'},
       { '' => \"case when cartononly is not null then 'N/A' ELSE ( convert(varchar,convert(decimal(8,2),product_list_today.unitprice)) ) end", '-as' => 'unitprice_2dp_na'},
     ],
    })->hri;


  return {
    pageLength => 50,
    columns => [
      { className => 'text-left small', data => 'product_code', title => 'Product<br>Code'},
      { className => 'text-left small', data => 'sh_transaction.product.department.description', title => 'Department'},
      { className => 'text-left small',  data => 'sh_transaction.product_list_today.description', title => 'Description'},
      { className => 'text-right small', data => 'unitprice_2dp_na', title => 'Unit<br>Price'},
      { className => 'text-right small', data => 'cartonprice_2dp', title => 'Carton<br>Price'},
      { className => 'text-right small', data => 'sh_transaction.product_list_today.cartonsize', title => 'U/C'},
      { className => 'text-right small', data => 'sh_transaction.product.gst_tax_table.tax_rate', title => 'GST %'},
      { className => 'text-right small', data => 'invoice_date_datepart', title => 'Last Purchased'},
      { className => 'text-right small', data => 'sh_transaction.sales_qty', title => 'Last Purch. Qty'},
      { className => 'text-right small', data => 'sh_transaction.product_list_today.barcode', title => 'Barcode',},
      { className => 'text-right small', defaultContent => '',  title => 'Order Qty', },
    ],
    data => [@mrps],
  };
  
};

# app is mounted onder /api
get '/sales/order-form-w-pricecode/:customer_code' => require_login \&order_form_w_pricecode;

1;
