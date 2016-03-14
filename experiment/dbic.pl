#!/usr/bin/env perl
use 5.12.0;
use Smart::Comments;
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Config::Any;
use Carp 'croak';
 
use Data::Dumper;
use Reports::Schema;

my $tmpcfg =  Config::Any->load_files( { files => ["$FindBin::Bin/../environments/development.yml" ], use_ext => 1} )->[0]; 

my ($filename, $config) = %$tmpcfg;
my $dsn = $config->{plugins}->{DBIC}->{default}->{dsn};
my $username = $config->{plugins}->{DBIC}->{default}->{user};
my $password = $config->{plugins}->{DBIC}->{default}->{password};


my $schema = Reports::Schema->connect($dsn,$username,$password);

my $transactions = $schema->resultset('ArTransaction')->search_rs({
  trans_type => 'INV',
  completed_date => undef,
});

# while (my $tr = $transactions->next) {
#   say $tr->batch_nr;
# }


# my $invoices = $schema->resultset('ArTransaction')->invoices->search({completed_date => undef});
# while (my $tr = $invoices->next) {
#   say "batch_nr: ", $tr->batch_nr, "debtor: ", $tr->debtor_code;
# }

# my $invoices = $schema->resultset('ArTransaction')->invoices->outstanding;
# while (my $tr = $invoices->next) {
#   say "batch_nr: ", $tr->batch_nr, "debtor: ", $tr->debtor_code;
# }

### get ar_customer codes and company names
my $ar_customers = $schema->resultset('ArCustomer')->search_rs(undef,
 {
#   join => { company => 'name'},
   prefetch => 'company',
#   prefetch => { company => 'name'},
 }
)->rows(100);

while (my $ar_customer = $ar_customers->next) {
  say "customer_code: ",$ar_customer->customer_code, " company name: ",$ar_customer->company->name;
};


### get ar_transactions

my $ar_transactions = $schema->resultset('ArTransaction')->search_rs(undef,
 {
#   prefetch => 'ar_customer',
   prefetch => { ar_customer => 'company' }
 }
)->rows(10);

while (my $ar_transaction = $ar_transactions->next) {
  say "batch_number: ",$ar_transaction->batch_nr,
    " customer_code: ",$ar_transaction->customer_code,
    " company_code: ",$ar_transaction->ar_customer->company_code,
    " company name: ",$ar_transaction->ar_customer->company->name;
};


### get ar_transactions use select to format columns

$ar_transactions = $schema->resultset('ArTransaction')->search({},
 {
   prefetch => { ar_customer => 'company' },
   '+select' => [
     { '' => \'round(trans_amt,1)', '-as' => 'trans_amt_rounded'}
     ],
#   '+as'     => [qw/one/],
#   '+columns' => [  foo =>   \[ 'convert(varchar,trans_date,103)'  ],
   #ROUND ( numeric_expression , length [ ,function ] )
 }
)->rows(10);

while (my $ar_transaction = $ar_transactions->next) {
  say "batch_number: ",$ar_transaction->batch_nr,
    " customer_code: ",$ar_transaction->customer_code,
    " company_code: ",$ar_transaction->ar_customer->company_code,
    " company name: ",$ar_transaction->ar_customer->company->name,
    " foo: "      ,$ar_transaction->get_column('trans_amt_rounded');
#     " mydate: "      ,$ar_transaction->get_column('mydate'); 
};


### multi step prefetch
  my @invoices  = $schema->resultset('ArTransaction')->invoices->outstanding()->search(undef,
   {
     prefetch => [{ ar_customer => 'company' },
		{ 'ar_debtor' => 'company'}],
     '+select' => [
       { '' => \'ltrim(str(trans_amt,25,2))', '-as' => 'trans_amt_rounded'},
       { '' => \'CONVERT(VARCHAR(10),trans_date,103)', '-as' => 'trans_date_datepart'},
       { '' => \'CONVERT(VARCHAR(10),due_date,103)', '-as' => 'due_date_datepart'}
     ],

 })->rows(30)->hri;

  print Dumper(@invoices);

### get debtor statement email addresses

# my $phones_rs = $schema->resultset('Phone')->search(
#   { phone_type => 'STEM',
#     'debtor_code' => { '!=', undef } },
#   { collapse => 1,
#     prefetch => { company => 'ar_debtors' },
#   }
# );


# my $phoneslist = [];

# while (my $phone = $phones_rs->next) {
#   # say
#   #   "debtor code: ", $phone->company->ar_debtors->first->debtor_code,
#   #   " company name: ", $phone->company->name,
#   #   " phone: ", $phone->phone_no;
#   push @$phoneslist, {debtor_code => $phone->company->ar_debtors->first->debtor_code,
# 		     company_name => $phone->company->name,
# 		     phone => $phone->phone_no}
  
# }

# print Dumper($phoneslist);


# ### select most recent transactions for a given customer1 
# $transactions = $schema->resultset('ShTransaction')->search(
#   {customer_code => 'BOUREH'},
#   {
#     select => ['customer_code','product_code',{max => 'invoice_date', -as => 'max_invoice_date'} ],
#     as     => [qw/ customer_code product_code max_invoice_date/],
#     group_by => [qw/ me.customer_code me.product_code /],
#     prefetch => 'product',
#       }
# )->rows(3);
# while (my $transaction = $transactions->next) {
#   say
#     'product code: ',  $transaction->product_code,
#     'invoice date: ',  $transaction->get_column('max_invoice_date'),
#     ' product description: ', $transaction->product->description;
# }


### select most recent transactions for a given customer2 
my $customer = $schema->resultset('ArCustomer')->find(
  {customer_code => 'IGACRE'}
);


say
  "customer code: ", $customer->customer_code,
  "company name: " , $customer->company->name;
my $phones = $customer->company->phones->buyer_phone_numbers;
while (my $phone = $phones->next) {
  say "   phone: ", $phone->phone_no;
}
