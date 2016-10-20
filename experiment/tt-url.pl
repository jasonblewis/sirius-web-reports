#!/usr/bin/env perl
use warnings;
use strict;
use feature qw/say/;
use String::TT qw/tt/;


say tt q{
[% request.path =  '/purchasing/multi-warehouse-sales-history/PUKHER' %]
request.path: [% request.path %]
request.path.replace: [% request.path.replace('(/[^/]+.*?)/.*', '$1') %]

[% request.path =  '/purchasing/multi-warehouse-sales-history' %]
request.path.replace: [% request.path.replace('(/[^/]+.*?)/.*', '$1') %]
};





