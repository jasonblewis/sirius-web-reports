package Reports;
use strict;
use warnings;
use Dancer2;
use Dancer2::Plugin::Database;
use DBI;
use Reports::AccountsReceivable;
use Reports::AccountsPayable;
use Reports::Sales;

set 'logger'       => 'console';
set 'log'          => 'debug';
set 'show_errors'  => 1;
set 'startup_info' => 1;
set 'warnings'     => 1;
set 'show_errors'  => 1;
set 'startup_info' => 1;
set 'warnings'     => 1;

our $VERSION = '0.1';


get '/' => sub {
  template 'index';
};


get '/test' => sub {
  my $sth = database->prepare(
    'select top 10 * from ap_creditor',
  );
  $sth->execute();
  my $fields = $sth->{NAME};

  template 'test',{
    'fields' => $fields,
    'creditors' => $sth->fetchall_arrayref({}),
  };
};


1;
