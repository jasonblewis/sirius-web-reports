package Reports::Schema::ResultSet;

use strict;
use warnings;

use parent 'DBIx::Class::ResultSet';

__PACKAGE__->load_components(qw{Helper::ResultSet::Shortcut});

1;
