#!/usr/bin/env perl
# run this from the project root to update the schema
use 5.12.0;
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Config::Any;
use Carp 'croak';
 
use Data::Dumper;

use DBIx::Class::Schema::Loader qw/ make_schema_at /;

my $tmpcfg =  Config::Any->load_files( { files => ["$FindBin::Bin/../environments/development.yml" ], use_ext => 1} )->[0]; 

my ($filename, $config) = %$tmpcfg;
my $dsn = $config->{plugins}->{DBIC}->{default}->{dsn};
my $username = $config->{plugins}->{DBIC}->{default}->{user};
my $password = $config->{plugins}->{DBIC}->{default}->{password};


make_schema_at(
    'Reports::Schema',
    {
        #debug => 1,
      db_schema => [qw(dbo)],
      naming => 'v8',
      moniker_parts => [qw(schema name)],
      moniker_map => sub { my $name = $_[0]; $name =~ s/^dbo//; join '', map ucfirst, split '_', $name },
      dump_directory => './lib',
      components =>     [
	'InflateColumn::DateTime',
#	'Schema::Config',
      ],
      constraint => [
          [ qr/\Adbo\z/ => qr/\A(?:
                                  ap_supplier|
                                  company|
				  phone|
                                  in_product|
				  ar_transaction|
				  ar_customer|
				  ar_customer_select_view|
				  ar_debtor|
                                  ap_supplier_select_view|
				  sh_transaction|
				  gst_tax_table|
				  in_department|
				  zz_most_recent_purchase|
				  zz_product_list_today|
                                  period|
				  pr_price|
				  pr_qty_break)\z/x ],
	],
      overwrite_modifications => 1,
      
  },
    [ $dsn, $username, $password,
#      { loader_class => 'MyLoader' } # optionally
    ],
);


