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

  my @invoices  = schema->resultset('ArTransaction')->invoices->outstanding->hri;

  to_json {data => [@invoices]};

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
