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

package Reports::API::Purchasing::MultiWarehouseSalesHistory;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Database;
use Data::Dumper;

use List::MoreUtils;

use URI;

sub ltrim { my $s = shift; $s =~ s/^\s+//;       return $s };
sub rtrim { my $s = shift; $s =~ s/\s+$//;       return $s };
sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

sub multi_warehouse_sales_history {
  my $params = request->body_parameters;
  
  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  
  my $sql = q/SET TRANSACTION ISOLATION LEVEL READ uncommitted;  

select oh.warehouse_code, p.product_code, p.description, oh.on_hand, c.committed, [0],[1],[2],[3],[4],[5],[6],[7],[8],[9]
from in_product p
left join
	zz_in_stock_on_hand_warehouse_all oh

	on p.product_code = oh.product_code
	
	
left join zz_so_committed2_by_warehouse c on 
	p.product_code = c.product_code
	and
	oh.warehouse_code = c.warehouse_code
left join zz_sh_monthly_sales_by_warehouse shm
	on
	p.product_code = shm.product_code
	and
	oh.warehouse_code = shm.warehouse_code

where oh.warehouse_code is not null
/;

  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;
  
  say Dumper $fields;
  
  my $columns = [];
  foreach my $field (@$fields) {
    # if (List::MoreUtils::any { $_ eq $field} ('Territory Code') ) {
    #   push @$columns, { data => $field, className => 'dt-left' }; 
    # } elsif (List::MoreUtils::any { $_ eq $field} ('description') ) {
    #   push @$columns, { data => $field, className => 'dt-left nowrap smaller-font' }; 
    # } elsif (List::MoreUtils::any { $_ eq $field} ('total') ) {
    #   push @$columns, { data => $field, className => 'dt-right row_total' }; 
    # } else {
      push @$columns, { data => $field, className => 'dt-right' }; 
    #}
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
  };

};


any ['get','post'] => '/purchasing/multi-warehouse-sales-history' => require_login \&multi_warehouse_sales_history;

1;