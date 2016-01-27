#!/usr/bin/env perl

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";

use Reports;
use Reports::AccountsReceivable;
Reports->to_app;
