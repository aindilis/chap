% here is a sample translation
% implies(distance(X,Y,Z),rank(X), rank(Y), is(Z,minus(Y,X)).)
% ("implies" ("and" ("rank" ?X) ("rank" ?Y) ("is" ?Z ("minus" ?Y ?X))) ("distance" ?X ?Y ?Z))

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

in(on(piece(white,rook),square(a,1)),pos1).
in(on(piece(white,knight),square(b,1)),pos1).
in(on(piece(white,bishop),square(c,1)),pos1).
in(on(piece(white,queen),square(d,1)),pos1).
in(on(piece(white,king),square(e,1)),pos1).
in(on(piece(white,bishop),square(f,1)),pos1).
in(on(piece(white,knight),square(g,1)),pos1).
in(on(piece(white,rook),square(h,1)),pos1).
in(on(piece(white,pawn),square(a,2)),pos1).
in(on(piece(white,pawn),square(b,2)),pos1).
in(on(piece(white,pawn),square(c,2)),pos1).
in(on(piece(white,pawn),square(d,2)),pos1).
% in(on(piece(white,pawn),square(e,2)),pos1).
in(on(piece(white,pawn),square(f,5)),pos1).
in(on(piece(white,pawn),square(f,2)),pos1).
in(on(piece(white,pawn),square(g,2)),pos1).
in(on(piece(white,pawn),square(h,2)),pos1).
in(on(piece(black,rook),square(a,8)),pos1).
in(on(piece(black,knight),square(b,8)),pos1).
in(on(piece(black,bishop),square(c,8)),pos1).
in(on(piece(black,queen),square(d,8)),pos1).
in(on(piece(black,king),square(e,8)),pos1).
in(on(piece(black,bishop),square(f,8)),pos1).
in(on(piece(black,knight),square(g,8)),pos1).
in(on(piece(black,rook),square(h,8)),pos1).
in(on(piece(black,pawn),square(a,7)),pos1).
in(on(piece(black,pawn),square(b,7)),pos1).
in(on(piece(black,pawn),square(c,7)),pos1).
in(on(piece(black,pawn),square(d,7)),pos1).
in(on(piece(black,pawn),square(e,7)),pos1).
in(on(piece(black,pawn),square(f,7)),pos1).
% in(on(piece(black,pawn),square(g,7)),pos1).
in(on(piece(black,pawn),square(h,7)),pos1).

% extras
in(on(piece(black,pawn),square(g,6)),pos1).
in(on(piece(black,queen),square(e,4)),pos1).
in(on(piece(white,knight),square(e,6)),pos1).

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
	greater_than(Z12,max(Z13,Z23)).

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
	equals(diagonal(Sign,Int),Diagonal),
	on_diagonal(square(X1,Y1),Diagonal),
	on_diagonal(square(X2,Y2),Diagonal).

on_file(square(X,Y),File) :-
	equals(X,File).

on_rank(square(X,Y),Rank) :-
	equals(Y,Rank).

on_diagonal(square(X,Y),Diagonal) :-
	file_to_int(X,A),
	is(Z,plus(A,Y)),
	equals(Diagonal,diagonal(positive,Z)).

on_diagonal(square(X,Y),Diagonal) :-
	file_to_int(X,A),
	is(Z,minus(A,Y)),
	equals(Diagonal,diagonal(negative,Z)).

square_distance(square(X1,Y1),square(X2,Y2),Z) :-
	abs_distance(X1,X2,Z1),
	abs_distance(Y1,Y2,Z2),
	is(Z,max(Z1,Z2)).

distance(X,Y,Z) :-
	file(X),
	file(Y),
	file_to_int(X,A),
	file_to_int(Y,B),
	is(Z,minus(B,A)).

distance(X,Y,Z) :-
	rank(X),
	rank(Y),
	is(Z,minus(Y,X)).

distance(Color,X,Y,Z) :-
	equals(Color,white),
	rank(X),
	rank(Y),
	is(Z,minus(Y,X)).

distance(Color,X,Y,Z) :-
	equals(Color,black),
	rank(X),
	rank(Y),
	distance(white,X,Y,A),
	is(Z,negative(A)).

abs_distance(X,Y,Z) :-
	distance(X,Y,A),
	is(Z,abs(A)).

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
 	less_than(Z1,2),
 	less_than(Z2,2).

same_square(square(X1,Y1),square(X2,Y2)) :-
	equals(X1,X2),
	equals(Y1,Y2).

different_square(square(X1,Y1),square(X2,Y2)) :-
	not(same_square(square(X1,Y1),square(X2,Y2))).

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
	not(equals(Y1,Y2)).

theoretical_range(piece(Color,rook),Purpose,square(X1,Y),square(X2,Y)) :-
	not(equals(X1,X2)).

theoretical_range(piece(Color,bishop),Purpose,square(X1,Y1),square(X2,Y2)) :-
	not(same_square(square(X1,Y1),square(X2,Y2))),
	abs_distance(Y1,Y2,Z1),
	abs_distance(X1,X2,Z2),
	equals(Z1,Z2).

theoretical_range(piece(Color,queen),Purpose,square(X1,Y1),square(X2,Y2)) :-
	theoretical_range(piece(Color,bishop),Purpose,square(X1,Y1),square(X2,Y2)).

theoretical_range(piece(Color,queen),Purpose,square(X1,Y1),square(X2,Y2)) :-
	theoretical_range(piece(Color,rook),Purpose,square(X1,Y1),square(X2,Y2)).

% we will use the following to represent the diagonals

line_blocked(piece(Color,Type),square(X1,Y1),square(X2,Y2),Pos) :-
	not(equals(Type,knight)),
	lies_between(square(X1,Y1),square(X3,Y3),square(X2,Y2)),
	in(on(Piece,square(X3,Y3)),Pos).

attacking(on(piece(Color1,Type1),square(X1,Y1)),on(piece(Color2,Type2),square(X2,Y2)),Pos) :-
	in(on(piece(Color1,Type1),square(X1,Y1)),Pos),
	in(on(piece(Color2,Type2),square(X2,Y2)),Pos),
	theoretical_range(piece(Color1,Type1),capture,square(X1,Y1),square(X2,Y2)),
	not(line_blocked(piece(Color1,Type1),square(X1,Y1),square(X2,Y2),Pos)),
	not(equals(Color1,Color2)).

%% valid_move(square(X1,Y1),square(X2,Y2),Pos) :-
%% 	true.

%% % sort of need to know who is on the giving versus receiving end
%% stalemate(Pos,Turn) :-
%% 	true.

%% % sort of need to know who is on the giving versus receiving end
%% checkmate(Pos,Turn) :-
%% 	true.

%% % need to know who is on the giving versus receiving end
%% check(Pos,Turn) :-
%% 	true.

%% % need to know who has the force mate
%% force_mate_exists(Pos,Turn) :-
%% 	true.

%% % need to know who has the force mate
%% force_mate_in(Pos,Turn,Ply) :-
%% 	true.

%% here are just some ideas for position predicates

% open_file(Pos,File)
% current_move_is_forced(Pos,Turn)
% no_valid_moves_remain(Pos,Turn)
% stands_better(Pos,Turn,Side)
% winning_chances(Pos,Turn,Side)
% gained_a_tempo(Pos,Moves)
% lost_a_tempo(Pos,Moves)
% a_blunder(Pos,Move)
% a_good_move(Pos,Move)
% a_great_move(Pos,Move)
% best_move(Pos,Move)
% only_move_that_leads_to_a_win(Pos,Move)
% better_move_than(Pos,Move1,Move2)
% attacking_move(Pos,Move)
% defensive_move(Pos,Move)
% strong_move(Pos,Move)
% weak_move(Pos,Move)
% overly_passive_move(Pos,Move)
% overly_aggressive_move(Pos,Move)
% overextended_position(Pos,Turn)
% failed_attack(Pos,Turn)
% the_king_is_vulnerable(Pos,Turn)
% the_king_is_fleeing(Pos,Moves)
% queen_sacrifice(Pos,Move)
% piece_sacrifice(Pos,Move)
% hung_a_piece(Pos,Move)
% in_zugzwang(Pos,Turn,Side)
% weak_pawn_chain(Pos,Turn,Side,PawnChainBase)
% hanging_piece(Pos,Turn,Piece,Square)
% backrow_mate_possible(Pos,Turn,ReceivingSide)
% suffocation_mate_possible(Pos,Turn,ReceivingSide)
% double_check()
% enpassant()
% promoted()
% queened()
% pawn_to_the_eight_rank()
% objective_is_forced()
% move_calculated_to_put_house_in_order()
% underdeveloped()
% has_good_development()
% objective(Pos,Side,Square)
% overprotected(Pos,Side,Square)
% pinned(Pos,Side,Piece,Square)
% obnoxious_or_offensive_move()
% double_rooks()
% twin_bishops (there is a better term for this) ()
% rook_on_the_seventh_rank()
% half_pin()
% escaping_a_situation_via_a_check()
% strategem()
% breaking_a_pin()
% forked()
% skewered()
% discovered_check()
% discovered_pin()
% protecting()
% has_higher_protection_count()
% will_win_exchange()
% will_lose_exchange()
% winning_exchange()
% losing_exchange()

% will()
% wont()

% did()
% didnt()

% was()
% wasnt()

% could()
% couldnt()

% must()
% musnt()

% needs_must()

% should()
% shouldnt()

% might()

% will_eventually()

% resigns()
% offers_draw()
% drawn()

% time_pressure()
% lost_on_time()
% won_on_time()
% ()

%% then all the typical agent language here

% ethical_move(Pos,Move)
% unethical_move(Pos,Move)
% egalitarian_move(Pos,Move)
% unjust_move(Pos,Move)
% invalid_move(Pos,Move)
% impossible_move(Pos,Move)
% nonsensical_move(Pos,Move)
