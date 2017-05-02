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

package Reports::API::Purchasing::CombinedWarehouseSalesHistory;

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

sub combined_sales_history {

  my $qry_supplier_code = route_parameters->get('supplier_code');
  
  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  
  my $sql = q/
Set transaction isolation level read uncommitted;
SELECT
  p.product_code,
  p.description,
  s.notes,
  convert(int,round([oh].[on_hand],0,0)) as on_hand,
  convert(int,round(po.on_order,0,0)) as on_order,
  convert(int,round(soc.committed,0,0)) as so_committed,
  convert(int,round(coalesce(btc.qty,0),0,0)) as bt_committed,
  convert(int,round(rb.qty,0,0)) as return_bin_qty,
  convert(int,round(oh.on_hand + po.on_order - coalesce(soc.committed,0) - coalesce(rb.qty,0)- coalesce(btc.qty,0),0,0)) as available,
  convert(int,round(oh.on_hand + po.on_order - coalesce(soc.committed,0) - coalesce(rb.qty,0),0,0)) as available_no_bt,

  convert(int,round(coalesce(ms.[5],0),0,0)) as ms_5,
  convert(int,round(coalesce(ms.[4],0),0,0)) as ms_4,
  convert(int,round(coalesce(ms.[3],0),0,0)) as ms_3,
  convert(int,round(coalesce(ms.[2],0),0,0)) as ms_2,
  convert(int,round(coalesce(ms.[1],0),0,0)) as ms_1,
  convert(int,round(coalesce(ms.[0],0),0,0)) as ms_0,
  convert(int,round(coalesce(ms.[0],0) + 
                    coalesce(ms.[1],0) +
                    coalesce(ms.[2],0) +
                    coalesce(ms.[3],0) +
                    coalesce(ms.[4],0) +
                    coalesce(ms.[5],0) ,0)) as [mtotal],
  wp.maximum,
  pc.lead_time_days,
  rc.min_days_stock,
  rc.max_days_stock,
  wp.reorder_class,
  wp.reorder_type,
  ssv.name,
  pc.active_flag,
  cc.catalogue_count
from in_product p
join
  ap_supplier s
  on
    s.supplier_code = p.primary_supplier
join
	ap_supplier_select_view ssv
	on
	s.supplier_code = ssv.supplier_code
join 
  zz_in_stock_on_hand_all [oh]
  on 
    oh.product_code = p.product_code
join 
  zz_in_on_purchase_order_all po
  on 
    po.product_code = p.product_code
left join 
  zz_so_committed2 soc
  on
    soc.product_code = p.product_code
left join
  zz_bt_committed_combined btc
  on
    btc.product_code = p.product_code
left join
  zz_in_stock_in_return_bin rb
  on
    rb.product_code = p.product_code
left join
  zz_sh_monthly_sales_2 ms
  on
    ms.supplier_code = p.primary_supplier
    and
    ms.product_code = p.product_code
join po_catalogue pc
  on
    pc.supplier_code = p.primary_supplier and
    pc.our_product_code = p.product_code


left join in_warehouse_product wp
	on p.product_code = wp.product_code
	and wp.warehouse_code = 'M'
join in_reorder_class rc
  on
    rc.class = wp.reorder_class and
    rc.reorder_type = wp.reorder_type

left join (select our_product_code,
                  supplier_code,
				  count(our_product_code) as catalogue_count 
				  
		   from po_catalogue_view
		   where active_flag = 'Y'
		   group by supplier_code,our_product_code
  ) as cc
on cc.our_product_code = p.product_code and
	cc.supplier_code = p.primary_supplier

  where ltrim(rtrim(p.primary_supplier)) = ?
and pc.active_flag = 'Y'
and (p.spare_flag_03 is null or p.spare_flag_03 = 'Y')
and not ((wp.reorder_type = 'Q' and wp.reorder_class = 'Q'))

order by p.product_code

/;

  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute($qry_supplier_code) or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;
  

  return {
    data => $rows,
  };

};


any ['get','post'] => '/purchasing/combined-sales-history/:supplier_code' => require_login \&combined_sales_history;

1;
