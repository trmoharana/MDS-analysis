#! /usr/bin/perl
# Programe to seperate phi ans psi angle for each amino acids from the output of gmx rama
# Usage batch.pl input.txt output.txt
use strict;
use warnings;
my @line; my @aminoacids; my $last; my $frame=1;
open (READ, "$ARGV[0]") || die "Couldn,t open file $ARGV[0]";
while (<READ>){
if (/^#/){
next;
}
if (/^@/){
next;
}
@line=split();
if ($line[2]eq$aminoacids[0]){
last;
}
push @aminoacids, $line[2];
$last=$line[2];
}
close READ;
open (WRITE, ">$ARGV[1]") || die "Couldn,t write file $ARGV[1]";
print WRITE "Frame ";
foreach my $a (@aminoacids){
print WRITE "$a\_phi $a\_psi ";
}
print WRITE "\n1 ";
open (READ, "$ARGV[0]") || die "Couldn,t open file $ARGV[0]";
while (<READ>){
if (/^#/){
next;
}
if (/^@/){
next;
}
@line=split();
print WRITE "$line[0] $line[1] ";
if ($line[2] eq $last){
$frame+=1;
print WRITE "\n$frame ";
}
}
close READ;
close WRITE;
