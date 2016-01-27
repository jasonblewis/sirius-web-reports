package Reports::AccountsReceivable;
use strict;
use warnings;
use Dancer2 appname => 'Reports';


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
  get ''                           => \&menu;
  get '/Outstanding Invoices'      => \&outstandinginvoices;
  get '/Statement Email Addresses' => \&statementemailaddresses;
};


1;
