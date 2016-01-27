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

1;
