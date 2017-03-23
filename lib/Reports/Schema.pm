use utf8;
package Reports::Schema;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Schema';

__PACKAGE__->load_namespaces;


# Created by DBIx::Class::Schema::Loader v0.07045 @ 2017-03-23 15:50:54
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:mq03vkMmXnShepJU1QcSMQ

__PACKAGE__->load_namespaces(
   default_resultset_class => '+Reports::Schema::ResultSet',
);

1;
