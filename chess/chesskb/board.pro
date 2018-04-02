:- op(50,xfy,in).
:- op(35,xfy,on).

% square(a,1).
% square(a,2).
% square(a,3).
% square(a,4).
% square(a,5).
% square(a,6).
% square(a,7).
% square(a,8).
% square(b,1).
% square(b,2).
% square(b,3).
% square(b,4).
% square(b,5).
% square(b,6).
% square(b,7).
% square(b,8).
% square(c,1).
% square(c,2).
% square(c,3).
% square(c,4).
% square(c,5).
% square(c,6).
% square(c,7).
% square(c,8).
% square(d,1).
% square(d,2).
% square(d,3).
% square(d,4).
% square(d,5).
% square(d,6).
% square(d,7).
% square(d,8).
% square(e,1).
% square(e,2).
% square(e,3).
% square(e,4).
% square(e,5).
% square(e,6).
% square(e,7).
% square(e,8).
% square(f,1).
% square(f,2).
% square(f,3).
% square(f,4).
% square(f,5).
% square(f,6).
% square(f,7).
% square(f,8).
% square(g,1).
% square(g,2).
% square(g,3).
% square(g,4).
% square(g,5).
% square(g,6).
% square(g,7).
% square(g,8).
% square(h,1).
% square(h,2).
% square(h,3).
% square(h,4).
% square(h,5).
% square(h,6).
% square(h,7).
% square(h,8).

rank(1).
rank(2).
rank(3).
rank(4).
rank(5).
rank(6).
rank(7).
rank(8).

file(a).
file(b).
file(c).
file(d).
file(e).
file(f).
file(g).
file(h).

diagonal(negative,7).
diagonal(negative,6).
diagonal(negative,5).
diagonal(negative,4).
diagonal(negative,3).
diagonal(negative,2).
diagonal(negative,1).
diagonal(negative,0).
diagonal(negative,-1).
diagonal(negative,-2).
diagonal(negative,-3).
diagonal(negative,-4).
diagonal(negative,-5).
diagonal(negative,-6).
diagonal(negative,-7).

diagonal(positive,16).
diagonal(positive,15).
diagonal(positive,14).
diagonal(positive,13).
diagonal(positive,12).
diagonal(positive,11).
diagonal(positive,10).
diagonal(positive,9).
diagonal(positive,8).
diagonal(positive,7).
diagonal(positive,6).
diagonal(positive,5).
diagonal(positive,4).
diagonal(positive,3).
diagonal(positive,2).

piece(white,rook) on square(a,1) in pos1.
piece(white,knight) on square(b,1) in pos1.
piece(white,bishop) on square(c,1) in pos1.
piece(white,queen) on square(d,1) in pos1.
piece(white,king) on square(e,1) in pos1.
piece(white,bishop) on square(f,1) in pos1.
piece(white,knight) on square(g,1) in pos1.
piece(white,rook) on square(h,1) in pos1.
piece(white,pawn) on square(a,2) in pos1.
piece(white,pawn) on square(b,2) in pos1.
piece(white,pawn) on square(c,2) in pos1.
piece(white,pawn) on square(d,2) in pos1.
% piece(white,pawn) on square(e,2) in pos1.
piece(white,pawn) on square(f,5) in pos1.
piece(white,pawn) on square(f,2) in pos1.
piece(white,pawn) on square(g,2) in pos1.
piece(white,pawn) on square(h,2) in pos1.
piece(black,rook) on square(a,8) in pos1.
piece(black,knight) on square(b,8) in pos1.
piece(black,bishop) on square(c,8) in pos1.
piece(black,queen) on square(d,8) in pos1.
piece(black,king) on square(e,8) in pos1.
piece(black,bishop) on square(f,8) in pos1.
piece(black,knight) on square(g,8) in pos1.
piece(black,rook) on square(h,8) in pos1.
piece(black,pawn) on square(a,7) in pos1.
piece(black,pawn) on square(b,7) in pos1.
piece(black,pawn) on square(c,7) in pos1.
piece(black,pawn) on square(d,7) in pos1.
piece(black,pawn) on square(e,7) in pos1.
piece(black,pawn) on square(f,7) in pos1.
% piece(black,pawn) on square(g,7) in pos1.
piece(black,pawn) on square(h,7) in pos1.

% extras
piece(black,pawn) on square(g,6) in pos1.
piece(black,queen) on square(e,4) in pos1.
piece(white,knight) on square(e,6) in pos1.

corner_square(square(a,1)).
corner_square(square(h,1)).
corner_square(square(a,8)).
corner_square(square(h,8)).

center_square(square(d,4)).
center_square(square(d,5)).
center_square(square(e,4)).
center_square(square(e,5)).

abbreviation(pawn,'P').
abbreviation(rook,'R').
abbreviation(knight,'N').
abbreviation(bishop,'B').
abbreviation(queen,'Q').
abbreviation(king,'K').

file_to_int(a,1).
file_to_int(b,2).
file_to_int(c,3).
file_to_int(d,4).
file_to_int(e,5).
file_to_int(f,6).
file_to_int(g,7).
file_to_int(h,8).

square(X,Y) :-
	file(X),
	rank(Y).

lies_between(square(X1,Y1),square(X3,Y3),square(X2,Y2)) :-
	colinear(square(X1,Y1),square(X2,Y2),Element),
	colinear(square(X1,Y1),square(X3,Y3),Element),
	square_distance(square(X1,Y1),square(X2,Y2),Z12),
	square_distance(square(X1,Y1),square(X3,Y3),Z13),
	square_distance(square(X2,Y2),square(X3,Y3),Z23),
	Z12 > max(Z13,Z23).

colinear(square(X1,Y1),square(X2,Y2),File) :-
	file(X2),
	rank(Y2),
	file(File),
	on_file(square(X1,Y1),File),
	on_file(square(X2,Y2),File).

colinear(square(X1,Y1),square(X2,Y2),Rank) :-
	file(X2),
	rank(Y2),
	rank(Rank),
	on_rank(square(X1,Y1),Rank),
	on_rank(square(X2,Y2),Rank).

colinear(square(X1,Y1),square(X2,Y2),Diagonal) :-
	file(X2),
	rank(Y2),
	diagonal(Sign,Int) = Diagonal,
	on_diagonal(square(X1,Y1),Diagonal),
	on_diagonal(square(X2,Y2),Diagonal).

on_file(square(X,Y),File) :-
	X = File.

on_rank(square(X,Y),Rank) :-
	Y = Rank.

on_diagonal(square(X,Y),Diagonal) :-
	file_to_int(X,A),
	Z is A + Y,
	Diagonal = diagonal(positive,Z).

on_diagonal(square(X,Y),Diagonal) :-
	file_to_int(X,A),
	Z is A - Y,
	Diagonal = diagonal(negative,Z).

square_distance(square(X1,Y1),square(X2,Y2),Z) :-
	abs_distance(X1,X2,Z1),
	abs_distance(Y1,Y2,Z2),
	Z is max(Z1,Z2).

distance(X,Y,Z) :-
	file(X),
	file(Y),
	file_to_int(X,A),
	file_to_int(Y,B),
	Z is B - A.

distance(X,Y,Z) :-
	rank(X),
	rank(Y),
	Z is Y - X.

distance(Color,X,Y,Z) :-
	Color = white,
	rank(X),
	rank(Y),
	Z is Y - X.

distance(Color,X,Y,Z) :-
	Color = black,
	rank(X),
	rank(Y),
	distance(white,X,Y,A),
	Z is -A.

abs_distance(X,Y,Z) :-
	distance(X,Y,A),
	Z is abs(A).

theoretical_range(piece(Color,knight),Purpose,square(X1,Y1),square(X2,Y2)) :-
	abs_distance(X1,X2,1),
	abs_distance(Y1,Y2,2).

theoretical_range(piece(Color,knight),Purpose,square(X1,Y1),square(X2,Y2)) :-
	abs_distance(X1,X2,2),
	abs_distance(Y1,Y2,1).

theoretical_range(piece(Color,king),Purpose,square(X1,Y1),square(X2,Y2)) :-
	not(same_square(square(X1,Y1),square(X2,Y2))),
 	abs_distance(X1,X2,Z1),
 	abs_distance(Y1,Y2,Z2),
 	Z1 < 2,
 	Z2 < 2.

same_square(square(X1,Y1),square(X2,Y2)) :-
	X1 = X2,
	Y1 = Y2.

different_square(square(X1,Y1),square(X2,Y2)) :-
	true.

theoretical_range(piece(white,pawn),move,square(X,2),square(X,4)) :-
	true.

theoretical_range(piece(black,pawn),move,square(X,7),square(X,5)) :-
	true.

theoretical_range(piece(Color,pawn),move,square(X,Y1),square(X,Y2)) :-
	distance(Color,Y1,Y2,1).

theoretical_range(piece(Color,pawn),capture,square(X1,Y1),square(X2,Y2)) :-
	abs_distance(X1,X2,1),
	distance(Color,Y1,Y2,1).

theoretical_range(piece(Color,rook),Purpose,square(X,Y1),square(X,Y2)) :-
	not(Y1 = Y2).

theoretical_range(piece(Color,rook),Purpose,square(X1,Y),square(X2,Y)) :-
	not(X1 = X2).

theoretical_range(piece(Color,bishop),Purpose,square(X1,Y1),square(X2,Y2)) :-
	not(same_square(square(X1,Y1),square(X2,Y2))),
	abs_distance(Y1,Y2,Z1),
	abs_distance(X1,X2,Z2),
	Z1 = Z2.

theoretical_range(piece(Color,queen),Purpose,square(X1,Y1),square(X2,Y2)) :-
	theoretical_range(piece(Color,bishop),Purpose,square(X1,Y1),square(X2,Y2)).

theoretical_range(piece(Color,queen),Purpose,square(X1,Y1),square(X2,Y2)) :-
	theoretical_range(piece(Color,rook),Purpose,square(X1,Y1),square(X2,Y2)).

% we will use the following to represent the diagonals

line_blocked(piece(Color,Type),square(X1,Y1),square(X2,Y2),Pos) :-
	not(Type = knight),
	lies_between(square(X1,Y1),square(X3,Y3),square(X2,Y2)),
	Piece on square(X3,Y3) in Pos.

attacking(piece(Color1,Type1) on square(X1,Y1),piece(Color2,Type2) on square(X2,Y2),Pos) :-
	piece(Color1,Type1) on square(X1,Y1) in Pos,
	piece(Color2,Type2) on square(X2,Y2) in Pos,
	theoretical_range(piece(Color1,Type1),capture,square(X1,Y1),square(X2,Y2)),
	not(line_blocked(piece(Color1,Type1),square(X1,Y1),square(X2,Y2),Pos)),
	not(Color1 = Color2).
