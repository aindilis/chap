#!/usr/bin/perl -w

use KBS2::Client;
use PerlLib::SwissArmyKnife;

my $client = KBS2::Client->new
  (
   Context => "Org::FRDCSA::CHAP",
  );

foreach my $query (
		   '("equals" ("rank" "a") ("rank" "a"))',
		   '("rank" var-RANK)',
		   '("in" ("on" var-PIECE var-SQUARE) var-POSITION)',
		   '("abbreviation" var-NAME var-ABBREV)',
		   '("colinear" var-SQUARE1 var-SQUARE2 var-Element)',
		   '("theoretical_range" ("piece" var-Color "pawn") "capture" ("square" var-X1 var-Y1) ("square" var-X2 var-Y2))',
		   '("attacking" ("on" var-PIECE1 var-SQUARE1) ("on" var-PIECE2 var-SQUARE2) var-POSITION)',
		  ) {
  my $res = $client->Send
    (
     Debug => 1,
     QueryAgent => 1,
     Query => $query,
     InputType => "Emacs String",
     Flags => {
	       OutputType => "CycL String",
	      },
    );
  # extract here the bindings, in a cycl format for ease of display
  print $res->Data->{Result}->{CycL}."\n";
  GetSignalFromUserToProceed();
}
