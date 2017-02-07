# Copyright 2017 Jason Lewis

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

package Reports::API::Purchasing::BlueGreen;

use strict;
use warnings;
use 5.22.0;
use Dancer2 appname => 'Reports::API';

use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Database;
use Data::Dumper;

use List::MoreUtils;

use DateTime;

use URI;


sub blue_green {

  
  database->{LongReadLen} = 100000;
  database->{LongTruncOk} = 0;
  
  my $sql = q/
select 1
/;

  my $sth = database->prepare($sql) or die "can't prepare\n";
  $sth->execute($qry_supplier_code) or die $sth->errstr;
  my $fields = $sth->{NAME};
  my $rows = $sth->fetchall_arrayref({});
  $sth->finish;
  
#  say Dumper $fields;

  sub month_name {
    my $deltamonth = shift(@_);
    return DateTime->now->subtract(months => $deltamonth)->strftime('%b %g');
  }  
  my $columns = [];
  foreach my $field (@$fields) {
    if (List::MoreUtils::any { $_ eq $field} ('Warehouse') ) {
      push @$columns, { data => $field, className => 'warehouse text-center' }; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('Product Code') ) {
      push @$columns, { data => $field, className => 'product-code text-left', title => 'Product Code', }; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('Description') ) {
      push @$columns, { data => $field, className => 'description text-left' }; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('On Hand') ) {
      push @$columns, { data => $field, className => 'on-hand text-right', formatfn => 'round0dp'}; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('Committed') ) {
      push @$columns, { data => $field, className => 'committed text-right', formatfn => 'round0dp' }; 
    } elsif (List::MoreUtils::any { $_ eq $field} ('total') ) {
      push @$columns, { data => $field, className => 'text-right row_total' }; 
    } elsif (List::MoreUtils::any { $_ eq $field} (0 .. 12) ) {
      push @$columns, { data => $field, className => 'qty text-right', "title" => month_name($field) , formatfn => 'round0dp' }; 
    } else {
      push @$columns, { data => $field, className => 'text-right', }; 
    }
  }

  # my $detail_url = body_parameters->get('detail_url');
  # if ($detail_url) {
  #   say "detail_url = ",$detail_url;
  #   foreach my $row (@$rows) {
  #     my $full_detail_url = new URI $detail_url;
  #     $full_detail_url->query_form(territory_code => rtrim($row->{'Territory Code'}));
  #     $row->{'Territory Code'} = "<a href='" . $full_detail_url->as_string . "'>" . rtrim($row->{'Territory Code'}) . "</a>";
  #     $row->{'description'} = "<a href='" . $full_detail_url->as_string . "'>" . rtrim($row->{'description'}) . "</a>";
  #   };
  #   #my $extra_column =  { data => 'url', title => 'Row Name' };
  #   #unshift(@$columns, $extra_column); 
  # }
  

  return {
    pageLength => 50,
    columns => $columns,
    data => [@$rows],
    order => [[1,"asc"]],
    columnDefs => [{visible=> "false", targets => ".product-code"}]
  };

};


any ['get','post'] => '/purchasing/blue-green' => require_login \&blue_green;

1;
