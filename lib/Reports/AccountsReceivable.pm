package Reports::AccountsReceivable;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Ajax;
use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::DBIC qw(schema resultset rset);


sub menu {
  template 'ar/accounts-receivable';
};

sub outstanding_invoices {
  template 'ar/outstanding-invoices';
};

sub outstanding_invoices_json {

  my @invoices  = schema->resultset('ArTransaction')->invoices->outstanding(
   {
   prefetch => { ar_customer => 'company' }
 })->rows(30)->hri;

  to_json {
    columns => [
         { data => "batch_nr"},
         { data => "debtor_code"},
         { data => "customer_code"},
	 { data => "trans_date"},
	 { data => "trans_amt"},
	 { data => "ref_1"},
	 { data => "ref_2"},
	 { data => "due_date"},
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
