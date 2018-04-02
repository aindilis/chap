#!/usr/bin/perl -w

use Lingua::LinkParser;

our $parser = new Lingua::LinkParser;
my $sentence = $parser->create_sentence("This is the turning point.");
my @linkages = $sentence->linkages;
# If there are NO LINKAGES, set min_null_count to a positive number:
# $parser->opts('min_null_count' => 1);
# See scripts/parse.pl for examples.
foreach $linkage (@linkages) {
  print ($parser->get_diagram($linkage));
}
