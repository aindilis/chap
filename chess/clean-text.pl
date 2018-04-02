#!/usr/bin/perl -w

use Text::Wrap;

$initial_tab = "";    # Tab before first line
$subsequent_tab = "";   # All other lines flush left

my $text = `cat lasker.txt`;
$text =~ s/\n\nChess and Checkers: The Way to Mastership\n+/\n/g;

my $OUT;
open(OUT,">res");
foreach my $line (split /\n/,$text) {
  print OUT wrap($initial_tab, $subsequent_tab, $line);
  print OUT "\n";
}
close(OUT);
