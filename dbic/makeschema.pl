#!/usr/bin/env perl
use DBIx::Class::Schema::Loader qw/ make_schema_at /;

make_schema_at(
    'Reports::Schema',
    {
        #debug => 1,
        #      db_schema => [qw(dbo)],
      moniker_parts => [qw(schema name)],
      dump_directory => './lib',
      components =>     'InflateColumn::DateTime',
      components =>     'TimeStamp',
      constraint => [
          [ qr/\Adbo\z/ => qr/\A(?:
                                  ap_supplier|
                                  company|
                                  in_product|
				  ar_transaction)\z/x ],
      ],
      
  },
    [ 'dbi:ODBC:driver=ODBC Driver 11 for SQL Server;server=tcp:10.0.2.3;database=siriusv8;MARS_Connection=yes', 'dancer2reports', '***REMOVED***',
#      { loader_class => 'MyLoader' } # optionally
    ],
);


