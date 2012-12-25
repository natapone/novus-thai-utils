#!/usr/bin/perl -w

use strict;
use warnings;
use Test::More tests => 1;
use novus::thai::utils;

my $config = novus::thai::utils->get_config();
is($config->{'schema_class'}, "Novus::Thai::Schema", "Return schema from config correctly");


