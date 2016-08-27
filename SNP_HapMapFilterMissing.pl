#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my ($input) = @ARGV;

open (MYFILE, $ARGV[0]);
open (WFILE, '>'.$ARGV[0].'_filter_'.$ARGV[1].'_missing');

my $header = <MYFILE>;
chomp $header;
my @header = split /\t/,$header ;
my $col_count = $#header - 11;

print WFILE join("\t",@header),"\n";

my $i = 1;
OUTER:
while (<MYFILE>) {
    chomp;
    my @arr = split /\t/, $_;
    my @arr2 = @arr[ 11 .. $#arr ];

    my $c = 0;
    my $perc = 0;
    for (@arr2) {
        if ($_ eq 'N') {
            $c++;
            $perc = 100*$c/$col_count;
        }

        if ($perc >= $ARGV[1]) {
            next OUTER;
        }

    }

    print WFILE join("\t", @arr),"\n";

    $i++;
}
