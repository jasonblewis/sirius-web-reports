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

package Reports::Purchasing;
use 5.12.0;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Database;
use Dancer2::Plugin::Auth::Extensible;
use Data::Dumper;
use Dancer2::Plugin::DBIC;
use Dancer2::Plugin::Ajax;

use Reports::Purchasing::CombinedWarehouse;
use Reports::Purchasing::MultiWarehouseSalesHistory;
#use Devel::Peek;

#use Reports::Schema;
#use Reports::Schema::Result::DboApSupplier;
#use Reports::Schema::Result::DboInProduct;




sub menu {
  template 'purchasing/purchasing';
};

sub data_suppliers_json {
    my $rs = schema('default')->resultset('DboApSupplier')->search(
        { supplier_code => {like => '%ORG%'}},
        { select => [qw(supplier_code company_code)]},
    );
    $rs->result_class('DBIx::Class::ResultClass::HashRefInflator');

    to_json({data => [$rs->all] });
};



prefix '/purchasing' => sub {
  get ''                             => require_login \&menu;
  ajax '/data/suppliers.json' => require_login \&data_suppliers_json;
  
};

1;
