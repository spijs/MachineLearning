:- lib(ic).
:- lib(lists).
:- lib(ic_global).

% Generate all solutions for the given puzzle
all_solutions(Puzzle,Search):-
	write('Puzzle: '),write(Puzzle),nl,
	problem(Puzzle,_,Rows,Columns),
	findall(_,battleships([],Rows,Columns,Search),L),length(L,LL),
	write('NbSolutions: '),write(LL),nl,
	write('############').

% Solves the given puzzle with the given search method
solve(Puzzle,Search):-
    problem(Puzzle,Hints, Rows,Columns),
    write('Puzzle'),write(Puzzle),nl,
    battleships(Hints,Rows,Columns,Search).
  
% Solve the battleships problem for the given set of hints and tallies  
battleships(Hints, Rows, Columns,Search):-
    initialize_boats(Hints,Solution),
    check_rows(Rows,Solution),
    check_columns(Columns,Solution),
	check_boats(Solution),
    List is Solution[1..10,1..10],
    createOneList(List,OneList),
    write('searching'),nl,
    search(Search,OneList,B),
    write(Search),nl,
    pretty_print(Solution, Rows, Columns,B).
	

% Print the solution and tallies in a nice format. 
% Also prints the amount of backtracks
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
    nl,write('backtracks:'),write(B),nl,
    write('#############'),nl.

writeRow(List):-
(for(N,1,10),
	param(List)
	do
		get_element(List,N,Elem),
		to_string(Elem,Char),
		write(Char)
).

% The restrictions on the boats are added to the solution
check_boats(Solution):-
	List is Solution[1..10,1..10],
	createOneList(List,OneList),
	transpose(List,Trans),
	createOneList(Trans,OneList2),
    set_sides(Solution),
    set_corners(Solution),
    count_pieces(OneList, OneList2),
    no_touching(Solution),
    no_verticalTouching(Solution),
    no_diagonalRightTouching(Solution),
    no_diagonalLeftTouching(Solution),
    check_length4(List,Trans,1),
	check_length3(List,Trans,2),
	check_length2(List,Trans, 3),
    check_submarines(OneList).


% Ensure that the solution contains the right amount of pieces. 
% This predicate also checks a set of combinations that are allowed by the other constraints, but cannot happen
count_pieces(List,OtherList):-
	occurrences(2,List,4),
	occurrences(1,List,H),
	occurrences(3,List,H),
	occurrences(4,List,V),
	occurrences(5,List,V),
	sumOfList([H,V],6),
	count3(2,2,2,List,0), % mmm 
	count3(1,2,0,List,0), % lm.
	count4(1,2,2,0,List,0), % lmm.
	count3(0,2,3,List,0), % .mr
	count4(0,2,2,3,List,0), % .mmr
	count4(0,2,2,0,List,0), % .mm.

	count3(2,2,2,OtherList,0), % mmm
	count3(4,2,0,OtherList,0), % tm.
	count4(4,2,2,0,OtherList,0), % tmm.
	count3(0,2,5,OtherList,0), % .mb
	count4(0,2,2,0,OtherList,0), % .mm.
	count4(0,2,2,5,OtherList,0). % .mmb

% Ensure that the sum of the occurrences of lmmr in the rows and tmmb in the columns is equal to N.
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

% Ensure that the sum of the occurrences of lmr in the rows and tmb in the columns is equal to N.
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

% Ensure that the sum of the occurrences of lr in the rows and tb in the columns is equal to N.
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

% Ensure that two vertically adjacent squares contain compatible pieces.
no_verticalTouching(Solution):-
	(for(N,1,10),
	param(Solution)
    do
    	Col is Solution[1..10,N],
    	check_col_touching(Col)
    ).
% Ensure that two horizontally adjacent squares contain compatible pieces.
no_touching(Solution):-
	(for(N,1,10),
	param(Solution)
    do
    	Row is Solution[N,1..10],
    	check_row_touching(Row)
    ).

% Ensure that the squares on the side of the grid are not occupied with pieces that cannot be there (e.g. left piece on the right side )
set_sides(Solution):-
    set_vertical_sides(Solution),
    set_horizontal_sides(Solution).
 
% Ensure that squares on the left are no 'r' piece, and pieces on the right are no 'l' piece.   
set_vertical_sides(Solution):-
	(for(N,1,10),
	param(Solution)
    do 
        Row is Solution[N,1..10],
        get_element(Row,1,Left),
        get_element(Row,10,Right),
        Left #\= 3,
        Right #\= 1
    ).

% Squares on the corners of the grid cannot contain 'm' pieces.
set_corners(Solution):-
    Lu is Solution[1,1],
    Ru is Solution[1,10],
    Lb is Solution[10,1],
    Rb is Solution[10,10],
    Lu #\= 2,
    Ru #\= 2,
    Lb #\= 2,
    Rb #\= 2.

% Squares on top row cannot contain 'b' pieces, and squares on the bottom row cannot contain 't' pieces.
set_horizontal_sides(Solution):-
    Row is Solution[1,1..10],
    (for(I,1,10),
	param(Row)
		do
            get_element(Row,I,Elem),
            Elem #\= 5
    )
    ,
    Row2 is Solution[10,1..10],
    (for(J,1,10),
	param(Row2)
		do
            get_element(Row2,J,Elem),
            Elem #\= 4
    ).    
    

% When two squares touch diagonally, at most one of them can be no 'w' piece.
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

% When two squares touch diagonally, at most one of them can be no 'w' piece.
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

% The elements in the same column should be compatible with their neighbours in that column
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

% The elements in the same row should be compatible with their neighbours in that row
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


% Two diagonally touching squares cannot both be different from 'w'
check_diagonal(L,R) :-
	#=(L,0,LWater),
	#=(R,0,RWater),
	#\=(R,0,RnotWater),
	#\=(L,0,LnotWater),
	and(LnotWater,RWater,B1),
	and(RnotWater,LWater,B2),
	and(LWater,RWater,B3),
	sumOfList([B1,B2,B3],1).

%% Checks whether or not the elements are compatible.

checkRight(Left,Right):-
    #=(Right,0,B1), % right square is . , left cannot be equal to 'l'
	#\=(Left,1,B2),
	and(B1,B2,First),

	#=(Right,3,B), % right square is r, left can only be l or m
	#\=(Left,0,LnotZero),
	#\=(Left,3,LnotThree),
	#\=(Left,4,LnotFour),
	#\=(Left,5,LnotFive),
	#\=(Left,6,LnotSix),
	and(LnotZero,LnotThree,Ln03),
	and(LnotFour,LnotFive,Ln45),
	and(LnotSix,Ln03,Ln036),
	and(Ln036,Ln45,LTotal),
	and(B,LTotal,Second),

	#=(Right,2,B3), % right square is m, left can be l, m or .
	#<(Left,3,Ls3),
	and(B3,Ls3,Third),

	#=(Right,1,B41), % right square is l, left can only be .
	#=(Left,0,B42),
	and(B41,B42,Fourth),

	#=(Right,5,B51), % right square is b, left can only be .
	#=(Left,0,B52),
	and(B51,B52,Fifth),

	#=(Right,4,B61), % right square is t, left can only be .
	#=(Left,0,B62),
	and(B61,B62,Sixth),

	#=(Right,6,B71), % right square is c, left can only be .
	#=(Left,0,B72),
	and(B71,B72,Seventh),

	sumOfList([First,Second,Third,Fourth, Fifth,Sixth, Seventh],1). % only one of seven cases described can be true
    
%% Checks whether or not the elements are compatible. 
checkLeft(Left,Right):-
	#=(Left,0,B1), % left square is . , right cannot be r
	#\=(Right,3,B2),
	and(B1,B2,First),

	#=(Left,1,B), % left square is l , right can only be m or r
	#\=(Right,0,RnotZero),
	#\=(Right,1,RnotOne),
	#\=(Right,4,RnotFour),
	#\=(Right,5,RnotFive),
	#\=(Right,6,RnotSix),
	and(RnotZero,RnotOne,Rn01),
	and(RnotFour,RnotFive,Rn45),
	and(RnotSix,Rn01,Rn016),
	and(Rn016,Rn45,RTotal),
	and(B,RTotal,Second),

	#=(Left,2,B3), % left square is m, right can only be m, r or .
	#\=(Right,1,Rn1),
	#\=(Right,4,Rn4),
	#\=(Right,5,Rn5),
	#\=(Right,6,Rn6),
	and(Rn1,Rn4,Rn14),
	and(Rn5,Rn6,Rn56),
	and(Rn14,Rn56,RnTotal),
	and(B3,RnTotal,Third),

	#=(Left,3,B41), % left square is r, right can only be .
	#=(Right,0,B42),
	and(B41,B42,Fourth),

	#=(Left,5,B51), % left square is b, right can only be . 
	#=(Right,0,B52),
	and(B51,B52,Fifth),

	#=(Left,4,B61), % left square is t, right can only be .
	#=(Right,0,B62),
	and(B61,B62,Sixth),

	#=(Left,6,B71), % left square is c , right can only be .
	#=(Right,0,B72),
	and(B71,B72,Seventh),

	sumOfList([First,Second,Third,Fourth, Fifth,Sixth, Seventh],1). % only one of seven described cases can be true

% Checks the compatibility of two given elements that are horizontally adjacent
check_aboveEl(Top,Bottom):-
	#=(Top,0,B1), % top square is . , bottom cannot be b
	#\=(Bottom,5,B2),
	and(B1,B2,First),

	#=(Top,4,B), % top square is t, bottom can only be b or m
	#\=(Bottom,0,RnotZero),
	#\=(Bottom,1,RnotOne),
	#\=(Bottom,4,RnotFour),
	#\=(Bottom,3,RnotFive),
	#\=(Bottom,6,RnotSix),
	and(RnotZero,RnotOne,Rn01),
	and(RnotFour,RnotFive,Rn45),
	and(RnotSix,Rn01,Rn016),
	and(Rn016,Rn45,RTotal),
	and(B,RTotal,Second),

	#=(Top,2,B3), % top square is m, bottom can be b, m , or .
	#\=(Bottom,1,Rn1),
	#\=(Bottom,4,Rn4),
	#\=(Bottom,3,Rn5),
	#\=(Bottom,6,Rn6),
	and(Rn1,Rn4,Rn14),
	and(Rn5,Rn6,Rn56),
	and(Rn14,Rn56,RnTotal),
	and(B3,RnTotal,Third),

	#=(Top,3,B41), % top square is r, bottom can only be .
	#=(Bottom,0,B42),
	and(B41,B42,Fourth),

	#=(Top,5,B51), % top square is b, bottom can only be .
	#=(Bottom,0,B52),
	and(B51,B52,Fifth),

	#=(Top,1,B61), % top square is l, bottom can only be .
	#=(Bottom,0,B62),
	and(B61,B62,Sixth),

	#=(Top,6,B71), % top square is c, bottom can only be .
	#=(Bottom,0,B72),
	and(B71,B72,Seventh),

	sumOfList([First,Second,Third,Fourth, Fifth,Sixth, Seventh],1). % only one of 
    
 check_belowEl(Top,Bottom):- % Top element is water, bottom element is not a bottom piece
	#=(Bottom,0,B1), % bottom element is . , top element cannot be t
	#\=(Top,4,B2),
	and(B1,B2,First),

	#=(Bottom,5,B), % bottom element is b , top can only be m or t
	#\=(Top,0,RnotZero),
	#\=(Top,1,RnotOne),
	#\=(Top,3,RnotFour),
	#\=(Top,5,RnotFive),
	#\=(Top,6,RnotSix),
	and(RnotZero,RnotOne,Rn01),
	and(RnotFour,RnotFive,Rn45),
	and(RnotSix,Rn01,Rn016),
	and(Rn016,Rn45,RTotal),
	and(B,RTotal,Second),

	#=(Bottom,2,B3), % bottom element is m, top element can only be m, t or .
	#\=(Top,1,Rn1),
	#\=(Top,3,Rn4),
	#\=(Top,5,Rn5),
	#\=(Top,6,Rn6),
	and(Rn1,Rn4,Rn14),
	and(Rn5,Rn6,Rn56),
	and(Rn14,Rn56,RnTotal),
	and(B3,RnTotal,Third),

	#=(Bottom,3,B41), % bottom element is r, top can only be .
	#=(Top,0,B42),
	and(B41,B42,Fourth),

	#=(Bottom,1,B51), % bottom element is l, top can only be .
	#=(Top,0,B52),
	and(B51,B52,Fifth),

	#=(Bottom,4,B61), % bottom element is t, top can only be .
	#=(Top,0,B62),
	and(B61,B62,Sixth),

	#=(Bottom,6,B71), % bottom element is c, top can only be .
	#=(Top,0,B72),
	and(B71,B72,Seventh),

	sumOfList([First,Second,Third,Fourth, Fifth,Sixth, Seventh],1). % one of seven described cases can be true

% There can only be 4 submarines in the solution
 check_submarines(Solution):-
    occurrences(6,Solution,4).
	

% The amount of non-water pieces on each column should be equal to the given tallies   
check_columns(Columns,Solution):-
    (for(N,1,10),
    param(Solution),
    param(Columns)
    do
        get_element(Columns,N,Tally),
        Column is Solution[1..10,N],
        check_row(Tally,Column)
    ).

% The amount of non-water pieces on each row should be equal to the given tallies   

check_rows(Rows,Solution):-
    (for(N,1,10),
    param(Solution),
    param(Rows)
    do
        get_element(Rows,N,Tally),
        Row is Solution[N,1..10],
        check_row(Tally,Row)
    ).
  

% Elem is the Nth element of List  
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

% Ensures that the amount of non-water pieces on a row is equal to Tally
check_row(Tally,SolutionRow):-
	N is (10-Tally),
	occurrences(0,SolutionRow,N).

% Set the domain for the solution and add all the hints 
initialize_boats(Hints, Solution):-
    dim(Solution,[10,10]),
    Solution::0..6,
  
    (foreach(Hint,Hints),
        param(Solution)
    do
        set_hint(Hint,Solution)
    ).

% Adds the given hint to the solution
set_hint((Row,Column,Boat),Solution):-
    to_int(Int,Boat),
    subscript(Solution,[Row,Column],Int).

% Takes a list of lists and returns the concatenation of the lists into one list.                
createOneList(L,R):-createOneList(L,[],R).
createOneList([],Acc,Acc).
createOneList([H|T],Acc,List):-
    append(Acc,H,R1),
    createOneList(T,R1,List).
	
% counts the amount of times a given pair occurs in the given list, in the same order
count2(_,_,[_],0).
count2(A,B,[X,Y|T],N):- 
	count2(A,B,[Y|T],N1), 
	#=(A,X,B1), 
	#=(B,Y,B2), 
	and(B1,B2,B3),
	N#=B3+N1.

% counts the amount of times a given triple occurs in the given list, in the same order
count3(_,_,_,[_,_],0).
count3(A,B,C,[X,Y,Z|T],N):- 
	count3(A,B,C,[Y,Z|T],N1), 
	#=(A,X,B1), 
	#=(B,Y,B2), 
	and(B1,B2,B3),
	#=(C,Z,B4),
	and(B3,B4,Btotal),
	N#=Btotal+N1.

% counts the amount of times a given quadruple occurs in the given list, in the same order
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
   Sum #= eval(Expr).


to_string(0,".").
to_string(1,"l").
to_string(2,"m").
to_string(3,"r").
to_string(4,"t").
to_string(5,"b").
to_string(6,"c").
to_int(0,water).
to_int(1,left).
to_int(2,middle).
to_int(3,right).
to_int(4,top).
to_int(5,bottom).
to_int(6,circle).

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

