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

package Reports::Purchasing::BlueGreen;
use 5.22.0;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;

sub blue_green {
  
  my $columns = [
    { data => 'OT Brand'},
    { data => 'supplier_code', title => 'Supplier Code', className => 'text-left'},
    { data => 'name', title => 'Supplier Name'},
    { data => 'sale_or_purchase',
      title => '<span class=text-primary>Sale</span><br><span class=text-success>Purchase</span>',
      className => 'text-right',
      visible => 1,
    },
    { data => 'suggested_purchase', title => 'Budget', className => 'text-right text-warning',formatfn => 'round0dp',},
    { data => 'value', title => 'SOH', className => 'text-right text-black',formatfn => 'round0dp'},
  ];

  my $months = 34;
    for (my $i = $months; $i >= 0; $i--) {
    push @$columns, {
      data => DateTime->now->subtract(months => $i)->strftime('%Y-%m-01'),
      title => DateTime->now->subtract(months => $i)->strftime('%Y<br>%m'),
      className => 'text-right',
      formatfn => 'round0dp',
    };
  }


#  push @$columns, { data => '2015-11-01',className => 'text-right',formatfn => 'round2dp'};
  
  template 'purchasing/blue-green', {
    title => "The Blue Green Report",
    json_data_url => "/api/purchasing/blue-green",
    columns => encode_json($columns),
    dt_options => {
      order      => '[[0, "desc"],[1,"asc"],[2,"desc"]]',
      responsive => 'true',
      dom        => 'ftrpl',
      pageLength => 100,
      paging => 'true',
      page   => 'first',
      createdRowFn => 'blue_green',
     },
    json_data_url => "/api/purchasing/blue-green",
      
  }
};

prefix '/purchasing' => sub {
  get '/blue-green' => require_any_role [qw(GL BG)] => \&blue_green;
};

1;

