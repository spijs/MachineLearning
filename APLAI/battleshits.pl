:- lib(ic).
:- lib(lists).
:- lib(ic_global).

battleshits(Hints, Rows, Columns,Solution):-
    initialize_boats(Hints,Solution),
	sumList(Rows,Boats),
	Water is (100-Boats),
	List is Solution[1..10,1..10],
	createOneList(List,OneList),
	check_water(OneList,Water),
    check_rows(Rows,Solution),
    check_columns(Columns,Solution),
	check_boats(Solution),
    write('searching'),nl,
    middle_out(OneList,MOList),
    search(MOList,0,first_fail,indomain_middle,complete, [backtrack(B)]),
    %% search(MOList,0,input_order,indomain,complete, [backtrack(B)]),
	%% search(OneList,0,input_order,indomain,complete,[backtrack(B)]),
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
	count3(2,2,2,OneList,0),
	count2(1,1,OneList,0),
	count2(3,3,OneList,0),
	check_length4(OneList,OneList2,1),
	count3(2,2,2,OneList2,0),
	count2(4,4,OneList2,0),
	count2(5,5,OneList2,0),
    no_touching(Solution),
    no_verticalTouching(Solution),
    no_diagonalRightTouching(Solution),
    no_diagonalLeftTouching(Solution),
    check_submarines(OneList),
	check_length2(OneList,OneList2, 3),
	check_length3(OneList,OneList2,2).


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
			%% Left is I-1,
			Right is I+1,
			%% get_element(RowAbove,Left,LeftElem),
			get_element(RowAbove,Right,RightElem),
			%% check_diagonal(LeftElem,Elem),
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
			%% Right is I+1,
			get_element(RowAbove,Left,LeftElem),
			%% get_element(RowAbove,Right,RightElem),
			check_diagonal(LeftElem,Elem)
			%% check_diagonal(Elem,RightElem)
		)
	).


check_above(Row,N,Solution):-
		(N>1 ->
			Above is N-1,
			RowAbove is Solution[Above,1..10],
			get_element(Row,N,Elem),
			Left is N-1,
			Right is N+1,
			get_element(RowAbove,Left,LeftElem),
			get_element(RowAbove,Right,RightElem),
			check_diagonal(LeftElem,Elem),
			check_diagonal(RightElem,Elem)
		;
		true
		).

check_col_touching(List):-
	for(N,2,10),
	param(List)
	do
		%% write('pos'),write(N),nl,
		get_element(List,N,Elem),
		Above is N-1,
		get_element(List,Above,AboveEl),
		%% check_element(Elem,LeftElem,RightElem).
		check_aboveEl(AboveEl,Elem).

check_row_touching(List):-
	for(N,2,10),
	param(List)
	do
		%% write('pos'),write(N),nl,
		get_element(List,N,Elem),
		Left is N-1,
		get_element(List,Left,LeftElem),
		%% check_element(Elem,LeftElem,RightElem).
		checkLeft(LeftElem,Elem).

check_above(Row,Above):-
	for(N,1,10),
	param(Row),param(Above)
	do
		get_element(Row,N,Elem),
		Left is N-1,
		Right is N+1,
		get_element(Above,Left,LeftElem),
		get_element(Above,Right,RightElem),
		check_diagonal(LeftElem,Elem),
		check_diagonal(RightElem,Elem).


check_straight_above(Above,Elem):-
	#=(Elem,0,ElemZero),
	#=(Above,0,AboveZero),
	#\=(Above,4,AboveNotFour),
	#\=(Elem,0,ElemNotZero),

	#=(Above,4,AboveTop),
	#=(Elem,5,ElemBottom),
	#=(Elem,2,ElemMid),
	#=(Above,2,AboveMid),
	or(ElemBottom,ElemMid,ElemBotOrMid),
	and(AboveTop,ElemBotOrMid,ElementBotOrMid),
	and(AboveMid,ElemBotOrMid,AboveIsMid),
	and(ElemZero,AboveNotFour,ElementIsWater),
	and(ElemNotZero,AboveZero,AboveIsZero),


	sumOfList([ElementIsWater,AboveIsZero,ElementBotOrMid,AboveIsMid],1).


check_diagonal(L,R) :-
	#=(L,0,LWater),
	#=(R,0,RWater),
	#\=(R,0,RnotWater),
	#\=(L,0,LnotWater),
	and(LnotWater,RWater,B1),
	and(RnotWater,LWater,B2),
	and(Lwater,RWater,B3),
	sumOfList([B1,B2,B3],1).


	%% #\=(E,0,ENotZero),
	%% #\=(Other,0,ONotZero),
	%% %% #=(E,0,EZero),
	%% %% #=(Other,0,OZero),
	%% and(ENotZero,ONotZero,0).
	%% and(ENotZero,OZero,B1),
	%% and(EZero,ONotZero,B2),
	%% and(EZero,OZero,BothZero),
	%% #\=(B1,B2,OneOfBoth),
	%% sumOfList([BothZero,OneOfBoth],1).



%% Checks whether or not the elements are compatible. The given LeftElement is located on
%% the left of Element
%% checkLeft(Left,Right):- % Left element is water, right element is not a right piece
%% 	#=(Left,0,1),
%% 	#\=(Right,3,1).

%% checkLeft(Left,Right):- % Left element is a L piece, right element is middle or right
%% 	#=(Left,1,1),
%% 	#=(Right,2,B1),
%% 	#=(Right,3,B2),
%% 	or(B1,B2,1).

%% checkLeft(Left,Right):- % Left element is a M piece, right element is middle or right
%% 	#=(Left,2,1),
%% 	#=(Right,2,B1),
%% 	#=(Right,3,B2),
%% 	#=(Right,0,B3)
%% 	or(B1,B2,B12),
%% 	or(B12,B3,1).

%% checkLeft(Left,Right):-
%% 	#\=(Left,0,1),
%% 	#\=(Left,1,1),
%% 	#\=(Left,2,1),
%% 	#=(Right,0,1).


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

	#\=(Left,0,B41),
	#\=(Left,1,B42),
	#\=(Left,2,B43),
	#=(Right,0,B4W),
	and(B41,B42,B412),
	and(B412,B43,B4T),
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

	#\=(Top,0,B41),
	#\=(Top,4,B42),
	#\=(Top,2,B43),
	#=(Bottom,0,B4W),
	and(B41,B42,B412),
	and(B412,B43,B4T),
	and(B4W,B4T,Fourth),

	sumOfList([First,Second,Third,Fourth],1).


%% check_aboveEl(Top,Bottom):- % Top element is a T piece, Bott element is middle or Botto
%% 	#=(Top,4,B),
%% 	#=(Bottom,2,B1),
%% 	#=(Bottom,5,B2),
%% 	or(B1,B2,B3),
%% 	and(B,B3,Second).

%% check_aboveEl(Top,Bottom):- % Top element is a M piece, Bott element is middle or Botto
%% 	#=(Top,2,1),
%% 	#=(Bottom,2,B1),
%% 	#=(Bottom,5,B2),
%% 	#=(Bottom,0,B3)
%% 	or(B1,B2,B12),
%% 	or(B12,B3,Third).

%% check_aboveEl(Top,Bottom):-
%% 	#\=(Top,0,B1),
%% 	#\=(Top,4,B2),
%% 	#\=(Top,2,B3),
%% 	#=(Bottom,0,BW),
%% 	and(B1,B2,B12),
%% 	and(B12,B3,BT),
%% 	and(B12,BT,Fourth).




	%% % Element on the left is a piece of a boat, which is not the middle or the left piece
	%% % the Botto element should be water
	%% #>(LeftElement,2,B1),
	%% #=(Element,0,B2),
	%% and(B1,B2,ElementIsWater),

	%% % The element on the left is a left or a middle piec of the boat, the right element
	%% % should be a right or middle piece.
	%% #<(LeftElement,3,B3),
	%% #\=(LeftElement,0,B4),
	%% and(B3,B4,ElisLorM),
	%% #=(Elem,3,El3),
	%% #=(Elem,2,El2),
	%% or(El3,El2,ElemMorR),
	%% and(ElemMorR,ElisLorM,ElementIsRightOrMid),

	%% % The left element is water, the right element can be everything but the right side of a boat.
	%% #=(LeftElement,0,LeftWater),
	%% #\=(Elem,3,ElemNotR),
	%% and(LeftWater,ElemNotR,ElementNotR),

	%% % Only one of three cases can be true.
	%% sumOfList([ElementIsWater,ElementIsRightOrMid,ElementNotR],1).

%% Checks whether or not the elements are compatible. The given RightElement is located on
%% the right of Element
checkRight(Element,RightElement):-
	%% #>(RightElement,3,B1), 
	%% #=(RightElement,1,B2), 
	%% or(B1,B2,ElementShouldBeWater),
	%% #=(Element,0,B3),
	%% and(B3,ElementShouldBeWater,ElementIsWater),

	%% #<(RightElement,4,Smaller),
	%% #>(RightElement,1,Larger),
	%% and(Smaller,Larger,RightIsLeftOrMid),
	%% #=(Elem,1,El1),
	%% #=(Elem,2,El2),
	%% or(El1,El2,ElemMorL),
	%% and(RightIsLeftOrMid,ElemMorL,ElementIsLeftOrMid),

	%% #=(RightElement,0,RightWater),
	%% #\=(Elem,1,ElemNotL),
	%% and(RightWater,ElemNotL,ElementNotL),
	%% sumOfList([ElementIsWater,ElementIsLeftOrMid,ElementNotL],1).
	#=(RightElement,0,B1), % Left is water
	#=(Element,0,El0),
	and(B1,El0,Both0),
	#=(Element,2,B2),
	#=(Element,1,B3),
	or(B3,B2,BT),
	#\=(B1,BT,1).



% Ensures that there are only N occurences of a boat of length 2
check_length2(List,Trans, N):-
	%% createDoubles(List,ListD),
	%% createDoubles(Trans,TransD),
	%% count([1,3],ListD,H),
	%% count([4,5],TransD,V),	
	count2(1,3,List,H),
	count2(4,5,Trans,V),
	sumOfList([H,V],N).



createDoubles(List,Result):-createDoubles(List,[],Result).
createDoubles([_],Result,Result).
createDoubles([A,B|T],Acc,Result):-
	append(Acc,[[A,B]],Acc1),
	createDoubles([B|T],Acc1,Result).

% Ensures that there are only N occurences of a boat of length 3
check_length3(List,Trans, N):- 
	count3(1,2,3,List,H),
	count3(4,2,5,Trans,V),
	sumOfList([H,V],N).

% Ensures that there are only N occurences of a boat of length 4
check_length4(List,Trans, N):- 
	count4(1,2,2,3,List,H),
	count4(4,2,2,5,Trans,V),
	sumOfList([H,V],N).

count_Horizontal2(Solution,H):-
	count2(1,3,Solution,H).
	
count_Vertical2(Solution,N):-
	count2(4,5,Solution,N).

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
