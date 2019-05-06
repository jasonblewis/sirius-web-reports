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

sub stockists_by_supplier {
  
  my $columns = [
    { data => 'name'},
    { data => 'phone'},
    { data => 'address_1'},
    { data => 'address_3'},
    { data => 'address_2'},
    { data => 'postcode'},
  ];


#  push @$columns, { data => '2015-11-01',className => 'text-right',formatfn => 'round2dp'};
  
  template 'sales/stockists-by-supplier', {
    title => "Stockists by Supplier",
    json_data_url => "/api/sales/stockists-by-supplier",
    columns => encode_json($columns),
    json_data_url => "/api/sales/stockists-by-supplier",
      
  }
};

prefix '/sales' => sub {
  get '/stockists-by-supplier' => require_any_role [qw(GL BG)] => \&stockists_by_supplier;
};

1;

