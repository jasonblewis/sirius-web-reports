package Reports::Purchasing;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;


sub menu {
  template 'purchasing/purchasing';
};

sub sales_history {
  my $sth;
  my $sth_dbname;
  my $dat;
  my $dbnames;
  unless  (query_parameters->get('primary_supplier')) {
    get_selection('/purchasing/sales-history'); # get the user selection of which supplier they want
  } else {
    $sth = database->prepare("select \@\@servername as name")  or die "Can't prepare: $DBI::errstr\n";
    $sth->execute or die $sth->errstr;
    $dat = $sth->fetchall_arrayref({});
    $sth->finish;
    
    $sth_dbname = database->prepare("select DB_NAME() as name;") or die "can't prepare\n";
    $sth_dbname->execute or die $sth_dbname->errstr;
    $dbnames = $sth_dbname->fetchall_arrayref({});
    $sth_dbname->finish;
    
    my $sql = q{Set transaction isolation level read uncommitted;
SELECT
  p.product_code,
  p.description,
  [oh].[on_hand],
  po.on_order,
  c.committed,
  rb.qty as return_bin_qty,
  oh.on_hand + po.on_order - coalesce(c.committed,0) - coalesce(rb.qty,0) as available,
  coalesce(ms.[5],0) as ms_5,
  coalesce(ms.[4],0) as ms_4,
  coalesce(ms.[3],0) as ms_3,
  coalesce(ms.[2],0) as ms_2,
  coalesce(ms.[1],0) as ms_1,
  coalesce(ms.[0],0) as ms_0,
  wp.maximum,
  (oh.on_hand + po.on_order - coalesce(c.committed,0) - coalesce(rb.qty,0)) / nullif(wp.maximum, 0) * 100 as available_ratio,
  pc.lead_time_days,
  rc.min_days_stock,
  rc.max_days_stock,
  wp.reorder_class,
  wp.reorder_type
from in_product p
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
join
  zz_sh_monthly_sales_2 ms
  on
    ms.supplier_code = p.primary_supplier
    and
    ms.product_code = p.product_code
join
  in_warehouse_product wp
  on
    wp.product_code = p.product_code
join po_catalogue pc
  on
    pc.supplier_code = p.primary_supplier and
    pc.our_product_code = p.product_code
join in_reorder_class rc
  on
    rc.class = wp.reorder_class and
    rc.reorder_type = wp.reorder_type
where ltrim(rtrim(p.primary_supplier)) = ? ;
};
    $sth = database->prepare($sql) or die "can't prepare\n";
    $sth->bind_param(1,query_parameters->get('primary_supplier'));
    $sth->execute or die $sth->errstr;
    my $fields = $sth->{NAME};
    my $rows = $sth->fetchall_arrayref({});
    $sth->finish;
    
    template 'purchasing/sales-history.tt', {
      'title' => 'Sales History',
      'servers' => $dat,
      'databases' => $dbnames,
      'fields' => $fields,
      'rows' => $rows,
    };
  }; #if
};

prefix '/purchasing' => sub {
  get ''                             => require_login \&menu;
  get '/sales-history'  => require_login \&sales_history;
};

1;
