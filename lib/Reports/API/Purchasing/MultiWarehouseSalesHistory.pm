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

package Reports::API::Purchasing::MultiWarehouseSalesHistory;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Database;
use Data::Dumper;

use List::MoreUtils;

use DateTime;

use URI;

#use Reports::Utils qw(rtrim);

sub multi_warehouse_sales_history {

  my $qry_supplier_code = route_parameters->get('supplier_code');
  
  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  
  my $sql = q/
SET TRANSACTION ISOLATION LEVEL READ uncommitted;  

select 
  --b.branch_code,
  oh.warehouse_code as 'Warehouse',
  p.product_code as 'Product Code',
  p.description as 'Description',
  oh.on_hand as 'On Hand',
  coalesce(c.committed,0) as 'SO Committed',
  coalesce(btc.bt_committed_qty,0) as 'BT Committed',
  coalesce(oh.on_hand,0) - coalesce(c.committed,0) - coalesce(btc.bt_committed_qty,0) as [Available],

  coalesce([0],0) as [0],
  coalesce([1],0) as [1],
  coalesce([2],0) as [2],
  coalesce([3],0) as [3],
  coalesce([4],0) as [4],
  coalesce([5],0) as [5],
  coalesce([6],0) as [6],
  coalesce([7],0) as [7],
  coalesce([8],0) as [8],
  coalesce([9],0) as [9]

from 
  in_product p
left join
	zz_in_stock_on_hand_warehouse_all oh

	on p.product_code = oh.product_code
join
  branch b
on 
  b.default_warehouse = oh.warehouse_code
	
	
left join zz_so_committed2_by_warehouse c on 
	p.product_code = c.product_code
	and
	oh.warehouse_code = c.warehouse_code
left join zz_sh_monthly_sales_by_warehouse shm
	on
	p.product_code = shm.product_code
	and
	oh.warehouse_code = shm.warehouse_code
left join
	zz_bt_committed_by_warehouse btc 
	on
	
	btc.bt_from_branch_code =   b.branch_code
	and
	btc.product_code = oh.product_code

where oh.warehouse_code is not null
and p.primary_supplier = ?

/;

  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute($qry_supplier_code) or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;
  
#  say Dumper $fields;

  sub month_name {
    my $deltamonth = shift(@_);
    return DateTime->now->subtract(months => $deltamonth)->strftime('%b %g');
  }  
  my $columns = [];
  foreach my $field (@$fields) {
    if (List::MoreUtils::any { $_ eq $field} ('Warehouse') ) {
      push @$columns, { data => $field, className => 'warehouse text-center' }; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('Product Code') ) {
      push @$columns, { data => $field, className => 'product-code text-left', title => 'Product Code', }; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('Description') ) {
      push @$columns, { data => $field, className => 'description text-left' }; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('On Hand') ) {
      push @$columns, { data => $field, className => 'on-hand text-right', formatfn => 'round0dp'}; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('SO Committed','BT Committed','Available') ) {
      push @$columns, { data => $field, className => 'committed text-right', formatfn => 'round0dp' }; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('total') ) {
      push @$columns, { data => $field, className => 'text-right row_total' }; 
    } elsif (List::MoreUtils::any { $_ eq $field} (0 .. 12) ) {
      push @$columns, { data => $field, className => 'qty text-right', "title" => month_name($field) , formatfn => 'round0dp' }; 
    } else {
      push @$columns, { data => $field, className => 'text-right', }; 
    }
  }

  # my $detail_url = body_parameters->get('detail_url');
  # if ($detail_url) {
  #   say "detail_url = ",$detail_url;
  #   foreach my $row (@$rows) {
  #     my $full_detail_url = new URI $detail_url;
  #     $full_detail_url->query_form(territory_code => rtrim($row->{'Territory Code'}));
  #     $row->{'Territory Code'} = "<a href='" . $full_detail_url->as_string . "'>" . rtrim($row->{'Territory Code'}) . "</a>";
  #     $row->{'description'} = "<a href='" . $full_detail_url->as_string . "'>" . rtrim($row->{'description'}) . "</a>";
  #   };
  #   #my $extra_column =  { data => 'url', title => 'Row Name' };
  #   #unshift(@$columns, $extra_column); 
  # }
  

  return {
    pageLength => 50,
    columns => $columns,
    data => [@$rows],
    order => [[1,"asc"]],
    columnDefs => [{visible=> "false", targets => ".product-code"}]
  };

};


any ['get','post'] => '/purchasing/multi-warehouse-sales-history/:supplier_code' => require_login \&multi_warehouse_sales_history;

1;
