:- lib(ic).
:- lib(lists).
:- lib(ic_global).

battleshits(Hints, Rows, Columns,Solution):-
	init(Hints,Hits,Boats).

init(Hints,Hits,Boats):-
	dim(Hits,[10,10]),
	dim(Boats,[10,10]),
	Hits::0..1,
	Boats::0..4,

	(foreach(Hint,Hints)),
		param(Boats),
	do
		set_hint(Hint,Solution)
	),



	
	
set_hint((Row,Column,Boat),Solution):-
    to_string(Int,Boat),
    subscript(Solution,[Row,Column],Int).