:- lib(ic).
:- lib(lists).
:- lib(ic_global).

solve(Puzzle,Search):-
    problem(Puzzle,Hints, Rows,Columns),
    battleshits(Hints,Rows,Columns,Search).
    
battleshits(Hints, Rows, Columns,Search):-
    initialize_boats(Hints,Solution),
    check_rows(Rows,Solution),
    check_columns(Columns,Solution),
	check_boats(Solution),
    List is Solution[1..10,1..10],
    createOneList(List,OneList),
    write('searching'),nl,
    search(Search,OneList,B),
    pretty_print(Solution, Rows, Columns,B).
	
pretty_print(Solution, Rows, Columns,B):-
	(for(N,1,10),
    param(Solution), param(Rows)
    do
        Row is Solution[N,1..10],
		get_element(Rows,N,Tally),
        writeRow(Row),write(" "),write(Tally),nl
    ),
	(for(N,1,10),
    param(Columns)
    do
		get_element(Columns,N,Tally),
        write(Tally)
    ),
    write(B).
	
writeRow(List):-
(for(N,1,10),
	param(List)
	do
		get_element(List,N,Elem),
		to_string(Elem,Char),
		write(Char)
).
	
check_water(List,Amount):-
	occurrences(0,List,Amount).
    
check_boats(Solution):-
	List is Solution[1..10,1..10],
	createOneList(List,OneList),
	transpose(List,Trans),
	createOneList(Trans,OneList2),
	check_length4(List,Trans,1),
    no_touching(Solution),
    no_verticalTouching(Solution),
    no_diagonalRightTouching(Solution),
    no_diagonalLeftTouching(Solution),
    check_submarines(OneList),
	check_length2(List,Trans, 3),
	check_length3(List,Trans,2).


check_length4(List,Trans, N):- 
	(fromto([], Tail, [H|Tail], Rows),
	foreach(Row,List) 
	do
		count4(1,2,2,3,Row,H)
	),
	(fromto([], Tail, [H|Tail], Columns),
	foreach(Col,Trans) 
	do
		count4(4,2,2,5,Col,H)
	),
	append(Rows,Columns,Total),
	sumOfList(Total,N).

	check_length3(List,Trans, N):- 
	(fromto([], Tail, [H|Tail], Rows),
	foreach(Row,List) 
	do
		count3(1,2,3,Row,H)
	),
	(fromto([], Tail, [H|Tail], Columns),
	foreach(Col,Trans) 
	do
		count3(4,2,5,Col,H)
	),
	append(Rows,Columns,Total),
	sumOfList(Total,N).

	check_length2(List,Trans, N):- 
	(fromto([], Tail, [H|Tail], Rows),
	foreach(Row,List) 
	do
		count2(1,3,Row,H)
	),
	(fromto([], Tail, [H|Tail], Columns),
	foreach(Col,Trans) 
	do
		count2(4,5,Col,H)
	),
	append(Rows,Columns,Total),
	sumOfList(Total,N).


no_verticalTouching(Solution):-
	(for(N,1,10),
	param(Solution)
    do
    	write('column'),write(N),nl,
    	Col is Solution[1..10,N],
    	%% write(Col),nl,
    	check_col_touching(Col)
    ).

no_touching(Solution):-
	(for(N,1,10),
	param(Solution)
    do
    	write('row'),write(N),nl,
    	Row is Solution[N,1..10],
    	check_row_touching(Row)
    ).


no_diagonalRightTouching(Solution):-
	(for(N,2,10),
	param(Solution)
	do 
		(for(I,1,9),
		param(Solution),param(N)
		do
			Row is Solution[N,1..10],
			Above is N-1,
			RowAbove is Solution[Above,1..10],
			get_element(Row,I,Elem),
			Right is I+1,
			get_element(RowAbove,Right,RightElem),
			check_diagonal(Elem,RightElem)
		)
	).

no_diagonalLeftTouching(Solution):-
	(for(N,2,10),
	param(Solution)
	do 
		(for(I,2,10),
		param(Solution),param(N)
		do
			Row is Solution[N,1..10],
			Above is N-1,
			RowAbove is Solution[Above,1..10],
			get_element(Row,I,Elem),
			Left is I-1,
			get_element(RowAbove,Left,LeftElem),
			check_diagonal(LeftElem,Elem)
		)
	).


check_col_touching(List):-
	for(N,2,10),
	param(List)
	do
		%% write('pos'),write(N),nl,
		get_element(List,N,Elem),
		Above is N-1,
		get_element(List,Above,AboveEl),
		check_aboveEl(AboveEl,Elem),
        check_belowEl(AboveEl,Elem).

check_row_touching(List):-
	for(N,2,10),
	param(List)
	do
		%% write('pos'),write(N),nl,
		get_element(List,N,Elem),
		Left is N-1,
		get_element(List,Left,LeftElem),
		checkLeft(LeftElem,Elem),
        checkRight(LeftElem,Elem).


check_diagonal(L,R) :-
	#=(L,0,LWater),
	#=(R,0,RWater),
	#\=(R,0,RnotWater),
	#\=(L,0,LnotWater),
	and(LnotWater,RWater,B1),
	and(RnotWater,LWater,B2),
	and(Lwater,RWater,B3),
	sumOfList([B1,B2,B3],1).

checkLeft(Left,Right):-
	#=(Left,0,B1),
	#\=(Right,3,B2),
	and(B1,B2,First),

	#=(Left,1,B),
	#=(Right,2,B21),
	#=(Right,3,B22),
	or(B21,B22,B23),
	and(B,B23,Second),

	#=(Left,2,B3),
	#=(Right,2,B31),
	#=(Right,3,B32),
	#=(Right,0,B33),
	or(B31,B32,B312),
	or(B312,B33,B3T),
	and(B3,B3T,Third),

	#=(Left,3,B41),
	#=(Left,4,B42),
	#=(Left,5,B43),
    #=(Left,6,B44),
	#=(Right,0,B4W),
	or(B41,B42,B412),
	or(B412,B43,B45),
    or(B44,B45,B4T),
	and(B4W,B4T,Fourth),

	sumOfList([First,Second,Third,Fourth],1).
    
%% Checks whether or not the elements are compatible. The given RightElement is located on
%% the right of Element
checkRight(Left,Right):-
    % l . kan niet
	#=(Right,0,B1),
	#\=(Left,1,B2),
	and(B1,B2,First),

    % als rechtse r is is links m of l
	#=(Right,3,B),
	#=(Left,2,B21),
	#=(Left,1,B22),
	or(B21,B22,B23),
	and(B,B23,Second),

    % Als rechtse m is is links m of l of .
	#=(Right,2,B3),
	#=(Left,2,B31),
	#=(Left,1,B32),
	#=(Left,0,B33),
	or(B31,B32,B312),
	or(B312,B33,B3T),
	and(B3,B3T,Third),

    % rechtse c,t,b,l -> links is .
	#=(Right,1,B41),
	#=(Right,4,B42),
	#=(Right,5,B43),
    #=(Right,6,B44),
	#=(Left,0,B4W),
	or(B41,B42,B412),
	or(B412,B43,B45),
    or(B44,B45,B4T),
	and(B4W,B4T,Fourth),

	sumOfList([First,Second,Third,Fourth],1).


check_aboveEl(Top,Bottom):- % Top element is water, bottom element is not a bottom piece
	#=(Top,0,B1),
	#\=(Bottom,5,B2),
	and(B1,B2,First),

	#=(Top,4,B),
	#=(Bottom,2,B21),
	#=(Bottom,5,B22),
	or(B21,B22,B23),
	and(B,B23,Second),

	#=(Top,2,B3),
	#=(Bottom,2,B31),
	#=(Bottom,5,B32),
	#=(Bottom,0,B33),
	or(B31,B32,B312),
	or(B312,B33,B3T),
	and(B3,B3T,Third),

	#=(Top,1,B41),
	#=(Top,3,B42),
	#=(Top,5,B43),
    #=(Top,6,B44),
	#=(Bottom,0,B4W),
	or(B41,B42,B412),
	or(B43,B44,B434),
    or(B412,B434,B4T),
	and(B4W,B4T,Fourth),

	sumOfList([First,Second,Third,Fourth],1).
    
 check_belowEl(Top,Bottom):- % Top element is water, bottom element is not a bottom piece
	#=(Bottom,0,B1),
	#\=(Top,4,B2),
	and(B1,B2,First),

	#=(Bottom,5,B),
	#=(Top,2,B21),
	#=(Top,4,B22),
	or(B21,B22,B23),
	and(B,B23,Second),

	#=(Bottom,2,B3),
	#=(Top,4,B31),
	#=(Top,2,B32),
	#=(Top,0,B33),
	or(B31,B32,B312),
	or(B312,B33,B3T),
	and(B3,B3T,Third),

	#=(Bottom,1,B41),
	#=(Bottom,3,B42),
	#=(Bottom,4,B43),
    #=(Bottom,6,B44),
	#=(Top,0,B4W),
	or(B41,B42,B412),
	or(B43,B44,B434),
    or(B412,B434,B4T),
	and(B4W,B4T,Fourth),

	sumOfList([First,Second,Third,Fourth],1).



%% % Ensures that there are only N occurences of a boat of length 2
%% check_length2(List,Trans, N):-
%% 	count2(1,3,List,H),
%% 	count2(4,5,Trans,V),
%% 	sumOfList([H,V],N).

%% % Ensures that there are only N occurences of a boat of length 3
%% check_length3(List,Trans, N):- 
%% 	count3(1,2,3,List,H),
%% 	count3(4,2,5,Trans,V),
%% 	sumOfList([H,V],N).

%% % Ensures that there are only N occurences of a boat of length 4
%% check_length4(List,Trans, N):- 
%% 	count4(1,2,2,3,List,H),
%% 	count4(4,2,2,5,Trans,V),
%% 	sumOfList([H,V],N).


 check_submarines(Solution):-
    occurrences(6,Solution,4).
	

    
check_columns([],[]).
check_columns(Columns,Solution):-
    (for(N,1,10),
    param(Solution),
    param(Columns)
    do
        get_element(Columns,N,Tally),
        Column is Solution[1..10,N],
        check_row(Tally,Column)
    ).
    
check_rows([],[]).
check_rows(Rows,Solution):-
    (for(N,1,10),
    param(Solution),
    param(Rows)
    do
        get_element(Rows,N,Tally),
        Row is Solution[N,1..10],
        check_row(Tally,Row)
    ).
    
get_element(List,N,Elem):-
    get_element(N,List,0,Elem).
    
get_element(_,[],_,_).
get_element(N,[Elem|Others],Current,Result):-
    Next is Current+1,
    (Next==N ->
        Result = Elem
    ;
        get_element(N,Others,Next,Result)
    ).
	
check_row(Tally,SolutionRow):-
	N is (10-Tally),
	occurrences(0,SolutionRow,N).
    
initialize_boats(Hints, Solution):-
    dim(Solution,[10,10]),
    Solution::0..6,
    
    (foreach(Hint,Hints),
        param(Solution)
    do
        set_hint(Hint,Solution)
    ).

set_hint((Row,Column,Boat),Solution):-
    to_string(Int,Boat),
    subscript(Solution,[Row,Column],Int).

%Takes a list of lists and returns the concatenation of the lists into one list.                
createOneList(L,R):-createOneList(L,[],R).
createOneList([],Acc,Acc).
createOneList([H|T],Acc,List):-
    append(Acc,H,R1),
    createOneList(T,R1,List).
	
count([_,_],[],0).
count([A,B],[[C,D]|T],N):-count([A,B],T,N1),#=(A,C,B1),#=(B,D,B2),and(B1,B2,Tot),N#=N1+Tot.

count2(_,_,[_],0).
count2(A,B,[X,Y|T],N):- 
	count2(A,B,[Y|T],N1), 
	#=(A,X,B1), 
	#=(B,Y,B2), 
	and(B1,B2,B3),
	N#=B3+N1.


count3(_,_,_,[_,_],0).
count3(A,B,C,[X,Y,Z|T],N):- 
	count3(A,B,C,[Y,Z|T],N1), 
	#=(A,X,B1), 
	#=(B,Y,B2), 
	and(B1,B2,B3),
	#=(C,Z,B4),
	and(B3,B4,Btotal),
	N#=Btotal+N1.

count4(_,_,_,_,[_,_,_],0).
count4(A,B,C,D,[W,X,Y,Z|T],N):- 
	count4(A,B,C,D,[X,Y,Z|T],N1), 
	#=(A,W,B1), 
	#=(B,X,B2), 
	and(B1,B2,B3),
	#=(C,Y,B4),
	and(B3,B4,B34),
	#=(D,Z,B5),	
	and(B34,B5,Btotal),
	N#=Btotal+N1.


sumList([], 0).
sumList([H|T], Sum) :-
   sum(T, Rest),
   Sum is H + Rest.

% Transpose matrix - http://stackoverflow.com/questions/4280986/how-to-transpose-a-matrix-in-prolog   
transpose([], []).
transpose([F|Fs], Ts) :-
    transpose(F, [F|Fs], Ts).

transpose([], _, []).
transpose([_|Rs], Ms, [Ts|Tss]) :-
        lists_firsts_rests(Ms, Ts, Ms1),
        transpose(Rs, Ms1, Tss).

lists_firsts_rests([], [], []).
lists_firsts_rests([[F|Os]|Rest], [F|Fs], [Os|Oss]) :-
        lists_firsts_rests(Rest, Fs, Oss).


%% Calculates the sum of all variables in list
sumOfList(List,Sum):-
    (
	foreach(X,List),
   fromto(Expr,S1,S2,0)
   do
   S1 = X + S2
   ),
   Sum $= eval(Expr).


to_string(0,".").
to_string(1,"l").
to_string(2,"m").
to_string(3,"r").
to_string(4,"t").
to_string(5,"b").
to_string(6,"c").
to_string(0,water).
to_string(1,left).
to_string(2,middle).
to_string(3,right).
to_string(4,top).
to_string(5,bottom).
to_string(6,circle).

 %   
/* SEARCH */
%
search(naive,List,B) :-
    search(List,0,input_order,indomain,complete,[backtrack(B)]).
    
search(middle_out,List,B) :-
    middle_out(List,MOList),
    search(MOList,0,input_order,indomain,complete, [backtrack(B)]).
    
search(first_fail,List,B) :-
    search(List,0,first_fail,indomain,complete, [backtrack(B)]).
    
search(moff,List,B) :-
    middle_out(List,MOList),
    search(MOList,0,first_fail,indomain,complete, [backtrack(B)]).
    
search(moffmo,List,B) :-
    middle_out(List,MOList),
    search(MOList,0,first_fail,
    indomain_middle,complete, [backtrack(B)]).    