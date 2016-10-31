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

package Reports::Login;
use strict;
use warnings;
use Dancer2 appname => 'Reports';
use Dancer2::Plugin::Auth::Extensible;
use 5.24.0;

sub login_page_handler {
    my $return_url = query_parameters->get('return_url');
    template
      'account/login', {
        title => 'Sign in OT Reports',
        return_url => $return_url,
    },
        { layout => 'login.tt',
        };
}

1;
