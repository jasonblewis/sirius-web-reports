package Reports::AccountsPayable;
use strict;
use warnings;
use Dancer2 appname => 'Reports';


sub menu {
  template 'AP/Accounts Payable';
};

sub creditorterms {
  template 'AP/Creditor Terms';
};

sub detailedtrialbalance {
  template 'AP/Detailed Trial Balance';
};



prefix '/Accounts Payable' => sub {
  get ''                           => \&menu;
  get '/Creditor Terms'      => \&creditorterms;
  get '/Detailed Trial Balance' => \&detailedtrialbalance;
};


1;
