# Copyright 2016 Jason Lewis

# This file is part of Sirius Web Reports.

#     Sirius Web Reports is free software: you can redistribute it and/or modify
#     it under the terms of the GNU Affero Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.

#     Sirius Web Reports is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU Affero Public License for more details.

#     You should have received a copy of the GNU Affero Public License
#     along with Sirius Web Reports.  If not, see <http://www.gnu.org/licenses/>.

package Reports::API::AccountsReceivable::Debtors;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::DBIC;

use Data::Dumper;
use URI;

sub ltrim { my $s = shift; $s =~ s/^\s+//;       return $s };
sub rtrim { my $s = shift; $s =~ s/\s+$//;       return $s };
sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };


sub debtors {

  my $return_columns = [
    { data => 'debtor_code'},
    { data => 'company.name'},
  ];
  
  my @debtors = schema->resultset('ArDebtor')->search(undef, {
    prefetch => 'company',
    collapse => 1,
    columns => ['debtor_code','company.name']},
						    )->hri;
  
  my $params = request->body_parameters;
  
  
  my $target_url = body_parameters->get('target_url');
  if ($target_url) {
    say "target_url = ",$target_url;
    foreach my $debtor (@debtors) {
      my $full_target_url = new URI $target_url;
      $full_target_url->query_form(debtor_code => rtrim($debtor->{'debtor_code'}));
      $debtor->{'url'} = "<a href='" . $full_target_url->as_string . "'>" . rtrim($debtor->{company}->{name}) . "</a>";
    };
    my $extra_column =  { data => 'url', title => 'Debtor Name' };
    unshift(@$return_columns, $extra_column); 
  }
  
  return {
    pageLength => 30,
    columns => $return_columns,
    data => [@debtors],
  }
};

sub debtors_debtor_code {
  my $debtor_code = route_parameters->get('debtor_code');
  my @debtors = schema->resultset('ArDebtor')->search({debtor_code => $debtor_code}, {
    prefetch => 'company',
    collapse => 1,
    columns => ['debtor_code','company_code','company.name']},
							)->hri;
  return {
    data => [@debtors],
  }
};


any ['get','post'] => '/accounts-receivable/debtors' => require_login \&debtors;
any ['get','post'] => '/accounts-receivable/debtors/:debtor_code' => require_login \&debtors_debtor_code;

1;
