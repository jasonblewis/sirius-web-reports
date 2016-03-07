package Reports::AccountsReceivable;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::DBIC qw(schema resultset rset);


sub menu {
  template 'ar/accounts-receivable';
};

sub outstanding_invoices {
  template 'ar/ar-outstanding-invoices';
};

sub statement_email_addresses {
  template 'ar/ar-statement-email-addresses';
};



prefix '/accounts-receivable' => sub {
  get ''                           => require_login \&menu;
  get '/outstanding-invoices'      => require_login \&outstanding_invoices;
  get '/statement-email-addresses' => require_login \&statement_email_addresses;
};


1;
