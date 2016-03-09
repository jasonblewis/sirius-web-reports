package Reports::AccountsReceivable;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Ajax;
use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::DBIC qw(schema resultset rset);

use Data::Dumper;
local $Data::Dumper::Freezer = '_dumper_hook';
 
sub menu {
  template 'ar/accounts-receivable';
};

sub outstanding_invoices {
  template 'ar/outstanding-invoices';
};

sub outstanding_invoices_json {

  my @invoices  = schema->resultset('ArTransaction')->invoices->outstanding()->search(undef,
   {
     prefetch => { ar_customer => 'company' },
     '+select' => [
       { '' => \'ltrim(str(trans_amt,25,2))', '-as' => 'trans_amt_rounded'},
       { '' => \'CONVERT(VARCHAR(10),trans_date,103)', '-as' => 'trans_date_datepart'},
       { '' => \'CONVERT(VARCHAR(10),due_date,103)', '-as' => 'due_date_datepart'}
     ],

 })->rows(30)->hri;

  print Dumper(@invoices);
  
  to_json {
    columns => [
         { data => "batch_nr",     title => 'Batch Number',  className => "dt-right"},
         { data => "debtor_code",  title => 'Debtor Code',   className => "dt-left"},
         { data => "customer_code",title => 'Customer code', className => "dt-left"},
	 { data => "trans_date_datepart",  title => 'Transaction<br />Date',      className => "dt-left"},
	 { data => "trans_amt_rounded", title => 'Transaction<br />Amount', className => "dt-right"},
	 { data => "ref_1",             title => 'Ref1', className => "dt-left"},
	 { data => "ref_2",             title => 'Ref2', className => "dt-left"},
	 { data => "due_date_datepart",          title => 'Due Date', className => "dt-left"},
	 { data => "ar_customer.company.name",          title => 'customer name', className => "dt-left"},
       ],
    data => [@invoices]};

};


sub statement_email_addresses {
  template 'ar/statement-email-addresses';
};


prefix '/accounts-receivable' => sub {
  get  ''                           => require_login \&menu;
  get  '/outstanding-invoices'      => require_login \&outstanding_invoices;
  ajax '/outstanding-invoices.json' => require_login \&outstanding_invoices_json;
  get  '/statement-email-addresses' => require_login \&statement_email_addresses;
};


1;
