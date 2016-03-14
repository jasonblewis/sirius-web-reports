package Reports::AccountsReceivable;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
#se Dancer2::Plugin::Ajax;
use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::DBIC qw(schema resultset rset);

#use Data::Dumper;
#local $Data::Dumper::Freezer = '_dumper_hook';
 
sub menu {
  template 'ar/accounts-receivable';
};

sub outstanding_invoices {
  template 'ar/outstanding-invoices', {
    json_data_url => '/api/accounts-receivable/outstanding-invoices'
  }
};



sub statement_email_addresses {
  template 'ar/statement-email-addresses';
};

sub statement_email_addresses_json {
  my @phones  = schema->resultset('Phones')->search(undef,
   {
     prefetch => ['company' ],

 })->hri;

   to_json {
     pageLength => 50,
     columns => [
       className => "dt-left",
   	 { data => "phone_no",        title => 'Phone Nimber',                className => "dt-left"},
        ],
     data => [@phones]
   }
};


prefix '/accounts-receivable' => sub {
  get  ''                           => require_login \&menu;
#  ajax '/outstanding-invoices' => require_login \&outstanding_invoices_json;
  get  '/outstanding-invoices'      => require_login \&outstanding_invoices;
  get  '/statement-email-addresses' => require_login \&statement_email_addresses;
};


1;
