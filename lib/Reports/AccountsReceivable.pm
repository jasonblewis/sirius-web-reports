package Reports::AccountsReceivable;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Auth::Extensible;


sub menu {
  template 'Accounts Receivable';
};

sub outstandinginvoices {
  template 'AR Outstanding Invoices';
};

sub statementemailaddresses {
  template 'AR Statement Email Addresses';
};



prefix '/Accounts Receivable' => sub {
  get ''                           => require_login \&menu;
  get '/Outstanding Invoices'      => require_login \&outstandinginvoices;
  get '/Statement Email Addresses' => require_login \&statementemailaddresses;
};


1;
