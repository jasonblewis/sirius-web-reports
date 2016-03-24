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
    { prefetch => { sh_transaction => 'product_list_today'},
      order_by => [qw( sh_transaction.department sh_transaction.product_code)],
    })->hri;


  return {
    pageLength => 50,
    columns => [
      { data => 'product_code', title => 'Product Code'}
    ],
    data => [@mrps],
  };
  
};

# app is mounted onder /api
get '/sales/order-form-w-pricecode' => require_login \&order_form_w_pricecode;

1;
