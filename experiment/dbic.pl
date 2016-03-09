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

