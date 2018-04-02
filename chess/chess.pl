#!/usr/bin/perl -w

use strict;
use AI::Prolog;
use Data::Dumper;

my $prolog = AI::Prolog->new(<<'END_PROLOG');
occupies([white,rook],[a,1],pos0).
occupies([white,knight],[b,1],pos0).
occupies([white,bishop],[c,1],pos0).
occupies([white,queen],[d,1],pos0).
occupies([white,king],[e,1],pos0).
occupies([white,bishop],[f,1],pos0).
occupies([white,knight],[g,1],pos0).
occupies([white,rook],[h,1],pos0).
occupies([white,pawn],[a,2],pos0).
occupies([white,pawn],[b,2],pos0).
occupies([white,pawn],[c,2],pos0).
occupies([white,pawn],[d,2],pos0).
occupies([white,pawn],[e,2],pos0).
occupies([white,pawn],[f,2],pos0).
occupies([white,pawn],[g,2],pos0).
occupies([white,pawn],[h,2],pos0).
occupies([black,rook],[a,8],pos0).
occupies([black,knight],[b,8],pos0).
occupies([black,bishop],[c,8],pos0).
occupies([black,queen],[d,8],pos0).
occupies([black,king],[e,8],pos0).
occupies([black,bishop],[f,8],pos0).
occupies([black,knight],[g,8],pos0).
occupies([black,rook],[h,8],pos0).
occupies([black,pawn],[a,7],pos0).
occupies([black,pawn],[b,7],pos0).
occupies([black,pawn],[c,7],pos0).
occupies([black,pawn],[d,7],pos0).
occupies([black,pawn],[e,7],pos0).
occupies([black,pawn],[f,7],pos0).
occupies([black,pawn],[g,7],pos0).
occupies([black,pawn],[h,7],pos0).

attacks(Piece,TargetSquare,Pos) :-
occupies(Piece,SourceSquare,Pos),
nth(2,Piece,"rook").

END_PROLOG



$prolog->query("attacks(X,Y,Z).");

while (my $result = $prolog->results) {
  print join(" ", @$result)."\n";
}
