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

package Reports::Purchasing::CombinedWarehouse;
use 5.22.0;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;
use Dancer2::Plugin::DBIC;
use Dancer2::Plugin::Ajax;

sub sales_history_get_primary_supplier {

  my $sql = q{
  Set transaction isolation level read uncommitted;
  select  distinct rtrim(s.supplier_code) as 'supplier_code',
          rtrim(c.name) as 'name'
  from ap_supplier s 
  join in_product p on
    p.primary_supplier = s.supplier_code
  join in_warehouse_product wp on
    wp.supplier_code = p.primary_supplier
  join company c
    on s.company_code = c.company_code 
  where 
  ( s.spare_flag_01 is null or s.spare_flag_01 != 'N') 
  and
  ( p.spare_flag_03 is null or p.spare_flag_03 = 'Y')
  and not (wp.reorder_type = 'Q' and wp.reorder_class = 'Q')
  order by supplier_code
};
  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;
  
  
  template 'utils/get-selection', {
      'target' => request->uri,
      'rows' => $rows,
  };
};



sub sales_history {
  my $primary_supplier = query_parameters->get('primary_supplier');
  unless ( $primary_supplier ) {
    sales_history_get_primary_supplier;
  } else {
    
    my $sth;
    my $sth_dbname;
    my $dat;
    my $dbnames;
    
    $sth = database->prepare("select \@\@servername as name")  or die "Can't prepare: $DBI::errstr\n";
    $sth->execute or die $sth->errstr;
    $dat = $sth->fetchall_arrayref({});
    $sth->finish;
    
    $sth_dbname = database->prepare("select DB_NAME() as name;") or die "can't prepare\n";
    $sth_dbname->execute or die $sth_dbname->errstr;
    $dbnames = $sth_dbname->fetchall_arrayref({});
    $sth_dbname->finish;
    
    my $sql = q{
Set transaction isolation level read uncommitted;
--select * from po_catalogue where our_product_code in( '6013401','6013402','6013403')
--select * from in_warehouse_product where product_code in( '6013401','6013402','6013403')
SELECT
  p.product_code,
  p.description,
  s.notes,
  convert(int,round([oh].[on_hand],0,0)) as on_hand,
  convert(int,round(po.on_order,0,0)) as on_order,
  convert(int,round(c.committed,0,0)) as committed,
  convert(int,round(rb.qty,0,0)) as return_bin_qty,
  convert(int,round(oh.on_hand + po.on_order - coalesce(c.committed,0) - coalesce(rb.qty,0),0,0)) as available,
  convert(int,round(coalesce(ms.[5],0),0,0)) as ms_5,
  convert(int,round(coalesce(ms.[4],0),0,0)) as ms_4,
  convert(int,round(coalesce(ms.[3],0),0,0)) as ms_3,
  convert(int,round(coalesce(ms.[2],0),0,0)) as ms_2,
  convert(int,round(coalesce(ms.[1],0),0,0)) as ms_1,
  convert(int,round(coalesce(ms.[0],0),0,0)) as ms_0,
  convert(int,round(coalesce(ms.[0]+ms.[1]+ms.[2]+ms.[3]+ms.[4]+ms.[5],0),0,0)) as [mtotal],
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
  zz_so_committed2 c
  on
    c.product_code = p.product_code
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

};

############# end SQL
    $sth = database->prepare($sql) or die "can't prepare\n";
    $sth->bind_param(1, $primary_supplier);
    $sth->execute or die $sth->errstr;
    my $fields = $sth->{NAME};
    my $rows = $sth->fetchall_arrayref({});
    #say Dumper $rows;
    #Dump($rows->[0]{on_hand});
    
    $sth->finish;

    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    my @abbr = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
                        # 0 1 2 3 4 5 6 7 8 9 10 11
    my @abbr_fm_num =  qw(8 7 6 5 4 3 2 1 12 11 10 9);
    my @abbr_cal_num = qw(8 7 6 5 4 3 2 1 12 11 10 9);

    my $fm = ($mon + 6) % 12;
    my @monthnum = (($mon-0)%12+1,
                    ($mon-1)%12+1,
                    ($mon-2)%12+1,
                    ($mon-3)%12+1,
                    ($mon-4)%12+1,
                    ($mon-5)%12+1,
                  );
    my @fmmonthnum = (($fm-0)%12+1,
                      ($fm-1)%12+1,
                      ($fm-2)%12+1,
                      ($fm-3)%12+1,
                      ($fm-4)%12+1,
                      ($fm-5)%12+1,
                  );

    # get the email addresses of the ap
    my $apemailsql = q(select phone_type,phone_no,s.supplier_code,s.company_code
 from phone ph
 join 
 ap_supplier s
 on ph.company_code = s.company_code
 where phone_type = ? and s.supplier_code = ?);
    $sth = database->prepare($apemailsql) or die "can't prepare\n";
    $sth->bind_param(1,'PO');
    $sth->bind_param(2, $primary_supplier);
    $sth->execute or die $sth->errstr;
    my $poemails = $sth->fetchall_arrayref({});
    $sth->finish;

    template 'purchasing/sales-history.tt', {
      'title' => 'Combined Warehouse Sales History',
      'primary_supplier' => $primary_supplier,
      'servers' => $dat,
      'databases' => $dbnames,
      'heading' => [
        'Product Code',
        'Description',
        'On<br /> Hand',
        'On<br />Order',
        'Committed',
        'Return<br />bin',
        'Available',
        "$abbr[$monthnum[5]-1]<br />$monthnum[5]<br />$fmmonthnum[5]",
        "$abbr[$monthnum[4]-1]<br />$monthnum[4]<br />$fmmonthnum[4]",
        "$abbr[$monthnum[3]-1]<br />$monthnum[3]<br />$fmmonthnum[3]",
        "$abbr[$monthnum[2]-1]<br />$monthnum[2]<br />$fmmonthnum[2]",
        "$abbr[$monthnum[1]-1]<br />$monthnum[1]<br />$fmmonthnum[1]",
        "$abbr[$monthnum[0]-1]<br />$monthnum[0]<br />$fmmonthnum[0]",
	'6 Month<br />Total',
        'Max<br />O/H',
	'Lead<br />Time',
        'Min<br />days',
        'Max<br />days',
        'T',
        'C',
      ],
      'fields' => $fields,
      'rows' => $rows,
      'poemails' => $poemails,
      'order' => [2,"desc"],
    }
  }
};

prefix '/purchasing' => sub {
  get '/sales-history'  => require_login \&sales_history;
};

1;
