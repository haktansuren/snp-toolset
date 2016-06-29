#!/usr/bin/perl

use strict;
use Data::Dumper;

my $sep = "\t";
my $column = $ARGV[1]-1;

my %allele_type = (
        AA => 'homo',
        CC => 'homo',
        GG => 'homo',
        TT => 'homo',
        AG => 'hetero',
        AT => 'hetero',
        AC => 'hetero',
        CG => 'hetero',
        CT => 'hetero',
        CA => 'hetero',
        GT => 'hetero',
        GA => 'hetero',
        GC => 'hetero',
        TG => 'hetero',
        TA => 'hetero',
        TC => 'hetero',
        );

my %convert = (
    homo_major => '0',
    homo_minor => '2',
    hetero => '1'
);

my ($input) = @ARGV;

open (MYFILE, $ARGV[0]);
open (WFILE, '>'.$ARGV[0].'_num');

my $header = <MYFILE>;
chomp $header;

print WFILE $header,"\n";

while (<MYFILE>) {
    chomp;
    my @arr = split /$sep/, $_;
    
    my %alleles;
    for (my $i=$column; $i<scalar(@arr); $i++ )
    {
        $arr[$i] =~ s/^\s+|\s+$//g;
        $alleles{$arr[$i]}++;
    }
    
    my $major = 0;
    my %conv = ();
    foreach my $allele (sort {$alleles{$b} <=> $alleles{$a} } keys %alleles) {
        if ($allele_type{$allele} =~ 'homo') {
            if (!$major) {
                $conv{$allele} = $convert{'homo_major'};
                $major = 1;
            }
            else{
                $conv{$allele} = $convert{'homo_minor'};
            }
        }elsif ($allele_type{$allele} =~ 'hetero') {
            $conv{$allele} = $convert{'hetero'};
        }elsif ( $allele =~ /\A[acgt]+\z/i) {
            $conv{$allele} = $convert{'hetero'};
        }else{
            $conv{$allele} = "NA";
        }
    }
    
    my %new_alleles = ();
    
    for (my $i=$column; $i<scalar(@arr); $i++ )
    {
        $arr[$i] =~ s/($arr[$i])/$conv{$1}/g; 
    }

    print WFILE join("\t", @arr),"\n";
    
}
close(WFILE);
