package Reports::Purchasing;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;
use Dancer2::Plugin::DBIC qw(schema resultset rset);
use Dancer2::Plugin::Ajax;


#use Reports::Schema;
#use Reports::Schema::Result::DboApSupplier;
#use Reports::Schema::Result::DboInProduct;




sub menu {
  template 'purchasing/purchasing';
};

sub data_suppliers_json {
    my $rs = schema('default')->resultset('DboApSupplier')->search(
        { supplier_code => {like => '%ORG%'}},
        { select => [qw(supplier_code company_code)]},
    );
    $rs->result_class('DBIx::Class::ResultClass::HashRefInflator');

    to_json({data => [$rs->all] });
};


sub sales_history_get_primary_supplier {

  my $sql = q{Set transaction isolation level read uncommitted;
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
    
    my $sql = q{Set transaction isolation level read uncommitted;
SELECT
  p.product_code,
  p.description,
  s.notes,
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
  ap_supplier s
  on
    s.supplier_code = p.primary_supplier
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
where ltrim(rtrim(p.primary_supplier)) = ?
and (p.spare_flag_03 is null or p.spare_flag_03 = 'Y');
};
    $sth = database->prepare($sql) or die "can't prepare\n";
    $sth->bind_param(1, $primary_supplier);
    $sth->execute or die $sth->errstr;
    my $fields = $sth->{NAME};
    my $rows = $sth->fetchall_arrayref({});
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
      'title' => 'Sales History',
      'primary_supplier' => $primary_supplier,
      'servers' => $dat,
      'databases' => $dbnames,
      'heading' => [
        'Product Code',
        'Description',
        'On Hand',
        'On Order',
        'Committed',
        'Return bin',
        'Available',
        "$abbr[$monthnum[5]-1]<br />$monthnum[5]<br />$fmmonthnum[5]",
        "$abbr[$monthnum[4]-1]<br />$monthnum[4]<br />$fmmonthnum[4]",
        "$abbr[$monthnum[3]-1]<br />$monthnum[3]<br />$fmmonthnum[3]",
        "$abbr[$monthnum[2]-1]<br />$monthnum[2]<br />$fmmonthnum[2]",
        "$abbr[$monthnum[1]-1]<br />$monthnum[1]<br />$fmmonthnum[1]",
        "$abbr[$monthnum[0]-1]<br />$monthnum[0]<br />$fmmonthnum[0]",
        'Max',
        'Ratio %<br />on hand<br />to max',
        'Lead Time',
        'Min',
        'Max',
        'T',
        'C',
      ],
      'fields' => $fields,
      'rows' => $rows,
      'poemails' => $poemails,
    }
  }
};

prefix '/purchasing' => sub {
  get ''                             => require_login \&menu;
  get '/sales-history'  => require_login \&sales_history;
  ajax '/data/suppliers.json' => require_login \&data_suppliers_json;
  
};

1;
