#!/usr/bin/perl -w

# Written by Karolis Uziela in 2012


use strict;
use File::Basename;

if ($#ARGV != 4) {
    die "
Usage:

$0 [Parameters]

Parameters:
    <input-file> - input rsa file
    <output-file-rel>
    <output-file-abs>
    <chain>
    <id>
\n";
}

# input files/directories   
my $INPUT_FILE = $ARGV[0];

# output files/directories
my $OUTPUT_FILE_REL = $ARGV[1];
my $OUTPUT_FILE_ABS = $ARGV[2];

# constants
my $CHAIN_ID = $ARGV[3];
my $ID = $ARGV[4];
#my $CHAIN_ID = $ARGV[1];
#my $ID = basename("$INPUT_FILE",  ".rsa");
my @amino_acids_1 = ("A","C","D","E","F","G","H","I","K","L","M","N","P","Q","R","S","T","V","W","Y","X");
my @amino_acids_3 = ("ALA","CYS","ASP","GLU","PHE","GLY","HIS","ILE","LYS","LEU","MET","ASN","PRO","GLN","ARG","SER","THR","VAL","TRP","TYR","UNK");
my @start_pos = (4, 8, 35, 16);
my @col_len = (3, 1, 6, 6);


# global variables
# N/A

###################### main script ######################

print "$0 has started with parameters: @ARGV\n";

open(IN_FILE, "$INPUT_FILE") or die "Error occured opening input file '$INPUT_FILE': $!";
open(OUT_FILE_ABS,">$OUTPUT_FILE_ABS") or die "Error occured opening output file: '$OUTPUT_FILE_ABS': $!";
open(OUT_FILE_REL,">$OUTPUT_FILE_REL") or die "Error occured opening output file: '$OUTPUT_FILE_REL': $!";

print OUT_FILE_REL ">$ID\n";
print OUT_FILE_ABS ">$ID\n";

my $aa_seq = "";
my $rel_seq = "";
my $abs_seq = "";

while (my $line=<IN_FILE>) {
    chomp $line;
    if ($line =~ /^RES/) {
        my $three = substr($line, $start_pos[0], $col_len[0]);
        my $chain = substr($line, $start_pos[1], $col_len[1]);
        my $rel = substr($line, $start_pos[2], $col_len[2]);
        my $abs = substr($line, $start_pos[3], $col_len[3]);
        $rel =~ s/\s//g;
        $abs =~ s/\s//g;
        #print "$three $chain $rel\n";
        if ( ($chain eq $CHAIN_ID) || ($CHAIN_ID eq ".") || ($CHAIN_ID eq "_") ) {
            my $one = "";
            for(my $a = 0; $a < 21; $a++) {
                if($three eq $amino_acids_3[$a]) {
                    $one = $amino_acids_1[$a];
                    last;
                }   
            }   
            #printf "%s %s \n",$three,$one ;
            if ( ! $one ) { 
                print "Warning: Single letter code for $three not found. Using 'X'...\n"; 
                $one = "X";
            }
            #print OUT_FILE_ABS $one;
            #print OUT_FILE_REL "$rel ";
            $aa_seq .= $one;
            if ($rel < 25) {
                $rel_seq .= "b";
            } else {
                $rel_seq .= "e";
            }
            if ($abs < 25) {
                $abs_seq .= "b";
            } else {
                $abs_seq .= "e";
            }
        }
    }
}

print OUT_FILE_REL "$aa_seq\n$rel_seq\n";
print OUT_FILE_ABS "$aa_seq\n$abs_seq\n";


close(OUT_FILE_ABS) or die "Error occured closing output file: $!";
close(OUT_FILE_REL) or die "Error occured closing output file: $!";
close(IN_FILE) or die "Error occured closing input file: $!";

print "$0 done.\n";
