print_board(Pos) :-
	rank(Y),
	file_separator,
	write(Y),
	write(' |'),
	print_rank(Pos,Y),
	fail.

print_board(_) :-
	file_separator,
	write('    a    b    c    d    e    f    g    h'),
	nl,nl.

file_separator :-
	nl,
	% write('  +---+---+---+---+---+---+---+---+'),
	write('  +----+----+----+----+----+----+----+----+'),
	nl.

print_rank(Pos,Y) :-
	file(X),
	print_special(Pos,X,Y),
	print_square(Pos,X,Y),
	write('|'),
	fail.

print_square(Pos,X,Y) :-
	piece(Color,Type) on square(X,Y) in Pos,
	Color = white,
	write('|'),
	abbreviation(Type,B),
	write(B),
	write('|'),
	!.

print_square(Pos,X,Y) :-
	piece(Color,Type) on square(X,Y) in Pos,
	Color = black,	
	write('-'),
	abbreviation(Type,B),
	write(B),
	write('-'),
	!.

print_square(_,_,_) :-
	write('   '),
	!.

print_special(Pos,X,Y) :-
	attacking(piece(black,queen) on square(e,4),A on square(X,Y),Z),
	write('*'),
	!.

print_special(Pos,X,Y) :-
	write(' ').
