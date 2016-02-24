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
                                  in_product)\z/x ],
      ],
      
  },
    [ 'dbi:ODBC:DSN=sirius', ***REMOVED***,
#      { loader_class => 'MyLoader' } # optionally
    ],
);


