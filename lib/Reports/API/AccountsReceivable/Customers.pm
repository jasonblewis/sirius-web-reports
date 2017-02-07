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

package Reports::API::AccountsReceivable::Customers;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::DBIC;

use Data::Dumper;
use URI;

use Reports::Utils qw(rtrim);

sub customers {

  my $return_columns = [
      { data => 'customer_code'},
      { data => 'company.name'},
   ];
  
  my @customers = schema->resultset('ArCustomer')->search(undef, {
    prefetch => 'company',
    collapse => 1,
    columns => ['customer_code','company.name']},
							)->hri;

  my $params = request->body_parameters;


  my $target_url = body_parameters->get('target_url');
  if ($target_url) {
    say "target_url = ",$target_url;
    foreach my $customer (@customers) {
      my $full_target_url = new URI $target_url;
      $full_target_url->query_form(customer_code => Reports::Utils::rtrim($customer->{'customer_code'}));
      $customer->{'url'} = "<a href='" . $full_target_url->as_string . "'>" . Reports::Utils::rtrim($customer->{company}->{name}) . "</a>";
    };
    my $extra_column =  { data => 'url', title => 'Customer Name' };
    unshift(@$return_columns, $extra_column); 
  }

  return {
    pageLength => 30,
    columns => $return_columns,
    data => [@customers],
  }
};

sub customers_customer_code {
  my $customer_code = route_parameters->get('customer_code');
  my @customers = schema->resultset('ArCustomer')->search({customer_code => $customer_code}, {
    prefetch => 'company',
    collapse => 1,
    columns => ['customer_code','company_code','company.name']},
							)->hri;
  return {
    data => [@customers],
  }
};


any ['get','post'] => '/accounts-receivable/customers' => require_login \&customers;
any ['get','post'] => '/accounts-receivable/customers/:customer_code' => require_login \&customers_customer_code;

1;
