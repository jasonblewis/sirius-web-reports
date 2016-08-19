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
use Dancer2::Plugin::Ajax;

sub multi_warehouse_sales_history {
   template 'purchasing/multi-warehouse-sales-history', {
     json_data_url => '/api/purchasing/multi-warehouse-sales-history'
   }
};


# sub outstanding_invoices {
#   template 'ar/outstanding-invoices', {
#     json_data_url => '/api/accounts-receivable/outstanding-invoices'
#   }
# };


prefix '/purchasing' => sub {
  get '/multi-warehouse-sales-history' => require_login \&multi_warehouse_sales_history;
};

1;
