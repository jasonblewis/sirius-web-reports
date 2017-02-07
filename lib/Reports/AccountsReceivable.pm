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

package Reports::AccountsReceivable;
use strict;
use warnings;
use 5.22.0;

use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::DBIC;

#use Data::Dumper;
#local $Data::Dumper::Freezer = '_dumper_hook';
 
sub menu {
  template 'ar/accounts-receivable';
};

sub outstanding_invoices {
  template 'ar/outstanding-invoices', {
    title => 'Outstanding Invoices',
    json_data_url => '/api/accounts-receivable/outstanding-invoices'
  }
};



sub statement_email_addresses {
  template 'ar/statement-email-addresses', {
    json_data_url => '/api/accounts-receivable/statement-email-addresses'
  } ;
};



prefix '/accounts-receivable' => sub {
  get  ''                           => require_login \&menu;
  get  '/outstanding-invoices'      => require_login \&outstanding_invoices;
  get  '/statement-email-addresses' => require_login \&statement_email_addresses;
};


1;
