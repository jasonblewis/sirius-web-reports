package Reports::API::Sales;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::DBIC qw(schema resultset rset);


# curl -b ~/.curl-cookies localhost:5000/api/sales/order-form-w-pricecode
sub order_form_w_pricecode {
  my $customer  = schema->resultset('ArCustomer')->find('IGACRO');
  
  my @mrps = $customer->most_recent_purchases->search(
    { 'sh_transaction.sales_qty' => { '>=' => 0},
    },
    { prefetch => { sh_transaction =>  ['product_list_today', {product => 'gst_tax_table'} ] } ,
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
      { data => 'product_code', title => 'Product Code'},
      { data => 'sh_transaction.product_list_today.description', title => 'Description'},
      { data => 'unitprice_2dp_na', title => 'Unit Price'},
      { data => 'cartonprice_2dp', title => 'Carton Price'},
      { data => 'sh_transaction.product_list_today.cartonsize', title => 'U/C'},
      { data => 'sh_transaction.product.gst_tax_table.tax_rate', title => 'GST'},
      { data => 'invoice_date_datepart', title => 'Last Purchased'},
      { data => 'sh_transaction.sales_qty', title => 'Last Purch. Qty'},
      { data => 'sh_transaction.product_list_today.barcode', title => 'Barcode'},
    ],
    data => [@mrps],
  };
  
};

# app is mounted onder /api
get '/sales/order-form-w-pricecode' => require_login \&order_form_w_pricecode;

1;
