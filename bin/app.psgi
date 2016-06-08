#!/usr/bin/env perl

use strict;
use diagnostics;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Reports;
use Reports::API;

use Plack::Builder;

builder {
  mount '/' =>  Reports->to_app;
  mount '/api' => Reports::API->to_app;
};
