package Reports::API::AccountsReceivable;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::DBIC qw(schema resultset rset);

sub outstanding_invoices {
  my @invoices  = schema->resultset('ArTransaction')->invoices->outstanding()->search(undef,
   {
     prefetch => [{ ar_customer => 'company' },
		  { ar_debtor => 'company'}],
     '+select' => [
       { '' => \'ltrim(str(trans_amt,25,2))', '-as' => 'trans_amt_rounded'},
       { '' => \'CONVERT(VARCHAR(10),trans_date,103)', '-as' => 'trans_date_datepart'},
       { '' => \'CONVERT(VARCHAR(10),due_date,103)', '-as' => 'due_date_datepart'}
     ],

 })->hri;

  return {
    pageLength => 50,
      columns => [
	{ data => "batch_nr",                 title => 'Batch<br />Number',       className => "dt-right"},          
	{ data => "ar_debtor.company.name",   title => 'Debtor',                  className => "dt-left"},
	{ data => "ar_customer.company.name", title => 'Customer',                className => "dt-left"},
	{ data => "trans_date_datepart",      title => 'Transaction<br />Date',   className => "dt-right"},
	{ data => "trans_amt_rounded",        title => 'Transaction<br />Amount', className => "dt-right"},
	{ data => "ref_1",                    title => 'Ref1',                    className => "dt-left"},
	{ data => "ref_2",                    title => 'Ref2',                    className => "dt-left"},
	{ data => "due_date_datepart",        title => 'Due Date',                className => "dt-left"},
      ],
	data => [@invoices],
      };
  
};



sub statement_email_addresses {
  my $phones_rs = schema->resultset('Phone')->search_rs(
    { phone_type => 'STEM',
      'debtor_code' => { '!=', undef } },
    { collapse => 1,
      prefetch => { company => 'ar_debtors' },
    }
  );
  
  my $phoneslist = [];
  
  while (my $phone = $phones_rs->next) {
    push @$phoneslist, {debtor_code => $phone->company->ar_debtors->first->debtor_code,
		       company_name => $phone->company->name,
		       phone => $phone->phone_no}
  }
  return { columns => [
    { data => 'debtor_code', title => 'Debtor Code', className => 'dt-right'},
    { data => 'company_name', title => 'Debtor Name', className => 'dt-right'},
    { data => 'phone', title => 'Statement Email Address', className => 'dt-right'},
  ],
    data => $phoneslist}
};


# app is mounted onder /api
get '/accounts-receivable/outstanding-invoices' => require_login \&outstanding_invoices;
get '/accounts-receivable/statement-email-addresses' => require_login \&statement_email_addresses;
1;
