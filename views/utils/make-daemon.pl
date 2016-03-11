#!/usr/bin/env perl
use warnings;
use strict;
use Daemon::Control;

exit Daemon::Control->new(
    name        => "Reports",
    lsb_start   => '$syslog $remote_fs',
    lsb_stop    => '$syslog',
    lsb_sdesc   => 'OT Reports App',
    lsb_desc    => 'Organic Trader Reports App.',
    path        => '/home/',
 
    user        => 'reports',
    group       => 'www-data',
    program     => '/home/symkat/bin/program',
    program_args => [ '-a', 'orange', '--verbose' ],
 
    pid_file    => '/tmp/mydaemon.pid',
    stderr_file => '/tmp/mydaemon.out',
    stdout_file => '/tmp/mydaemon.out',
 
    fork        => 2,
 
  )->run;
