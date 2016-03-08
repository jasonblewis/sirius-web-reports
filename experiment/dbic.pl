#!/usr/bin/env perl
use 5.12.0;
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
my $username = $config->{plugins}->{DBIC}->{default}->{username};
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

my $invoices = $schema->resultset('ArTransaction')->invoices->outstanding;
while (my $tr = $invoices->next) {
  say "batch_nr: ", $tr->batch_nr, "debtor: ", $tr->debtor_code;
}

