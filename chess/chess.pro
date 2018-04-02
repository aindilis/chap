init :-
	consult('chesskb/board.pro'),
	consult('chesskb/display.pro').

:- init.

move(Square1,_,Pos1,_) :-
	X on Square1 in Pos1,
	write(X),
	fail.

% move(Square1,Square2,Pos1,Pos2) :-
% 	write(X),
% 	retract(X on Square1 in Pos2),
% 	assert(X on Square2 in Pos2),
% 	!.

move(Square1,Square2,Pos1,Pos2) :-
	write('no piece on '),
	write(Square1),
	nl.

% :- equate(pos1,pos2).

:- move(square(d,2),square(d,4),pos1,pos2).

:- print_board(pos1).
