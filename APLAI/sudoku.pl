:- lib(lists).
:- lib(ic_global).
:- lib(ic).

solve(Name,Search):- 
                puzzles(P,Name),
                transpose(P,Puzzle),
                rowConstraint(P),
                columnConstraint(Puzzle),
                blockConstraint(Puzzle),
                createOneList(Puzzle,R),
                search(Search,R,B),
                pretty_print(P,B,Search).

%Takes a list of lists and returns the concatenation of the lists into one list.                
createOneList(L,R):-createOneList(L,[],R).
createOneList([],Acc,Acc).
createOneList([H|T],Acc,List):-
    append(Acc,H,R1),
    createOneList(T,R1,List).

%Each list in the list of lists contains all number from 1 to 9.
rowConstraint(Puzzle):-
    (foreach(Row,Puzzle)
     do
        Row::1..9,
        ic_global:alldifferent(Row) 
    ).
    
/* Pretty Print L */
pretty_print(List,B,Search) :-
    (foreach(Row,List)
    do 
        write(Row),nl
	),
    write(search - Search),nl,    
    write(backtracks-B),nl,
    write(-----------------------),nl.
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
    
        
% Each column contains all numbers between 1 and 9.    
columnConstraint(Columns):-
     rowConstraint(Columns).

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
        

% Constraints for all blocks - http://programmablelife.blogspot.co.at/2012/07/adventures-in-declarative-programming.html
blockConstraint([]).
blockConstraint([A,B,C|Rest]):-
    blocks(A,B,C),
    blockConstraint(Rest).
    
blocks([], [], []).      
blocks([A,B,C|Bs1], [D,E,F|Bs2], [G,H,I|Bs3]) :-
  [A,B,C,D,E,F,G,H,I]::1..9,
  ic_global:(alldifferent([A,B,C,D,E,F,G,H,I])),     
  blocks(Bs1, Bs2, Bs3).
  
%  
%OTHER VIEWPOINT
%

solve_2(Name,Search):-
    puzzles(Puzzle,Name),
    create_numbers(Numbers),
    fill_in_numbers(Puzzle,Numbers),    
    collection_to_list(Numbers,LList),
    createOneList2(LList,List),
    List::1..9,
    is_in_each_block(Numbers),
    check_doubles(Numbers), 
    search(Search,List,B),
    write(search-Search),nl,
    write(backtracks-B),nl,
    write(Numbers),nl.        
        
%Takes a list of lists and returns the concatenation of the lists into one list.                
createOneList2(L,R):-createOneList2(L,[],R).
createOneList2([],Acc,Acc).
createOneList2([H|T],Acc,List):-
    append(Acc,[H],R1),
    createOneList2(T,R1,List).
            
    
check_doubles(Numbers):-
    (for(I,1,8),
    param(Numbers)
    do
        Number is Numbers[I,2],
        L is I+1,
        (for(K,L,9),
        param(Number),
        param(Numbers)
            do
                CheckN is Numbers[K,2],
                (for(J,1,9),
                param(Number),
                param(CheckN)
                    do
                     Value is Number[J,1],
                     Check is CheckN[J,1],
                     Value #\= Check
               )     
        )       
    ).
    
% Initializes an array representing each number from 1 to 9 and its positions in the sudoku puzzle.
create_numbers(Numbers):-
    dim(Numbers,[9,2]),
    (for(N,1,9),
    param(Numbers)
    do
        dim(Positions,[9,1]),
        (for(I,1,9),
        param(Positions)
        do
            A::1..9, 
            subscript(Positions,[I,1],A)
        ),
        Row is Positions[1..9,1],
        ic_global:alldifferent(Row),
    subscript(Numbers,[N,1],N),
    subscript(Numbers,[N,2],Positions)
    ).

 fill_in_numbers(Puzzle,Numbers):-
    (for(Row,1,9),
    param(Numbers),
    param(Puzzle)
    do
        (for(Column,1,9),
        param(Row),
        param(Numbers),
        param(Puzzle)
        do  
            get_sudoku_element(Puzzle,Row,Column,Element),
            (\+(var(Element)) ->
                            Positions is Numbers[Element,2],
                            subscript(Positions,[Row,1],Column)         
                            ;
                            true)
        )                   
    ).          
    
is_in_each_block(Numbers):-
    (for(N,1,9), %Elk getal afgaan
    param(Numbers)
    do
        Number is Numbers[N,2],
        (for(BlockRow,1,3), %Elk rij van blokken
        param(Number),
        param(Numbers)
            do
                Start is 1+((BlockRow-1)*3),
                Stop is BlockRow*3,
                RelevantRows is Number[Start..Stop,1],
                sorted(RelevantRows,Sorted),
                check_correct(Sorted)
         )
    ).
    
check_correct([A,B,C]):-
        A#>=1,
        A#=<3,
        B#>=4,
        B#=<6,
        C#>=7,
        C#=<9.
           
 %Retrieves the element at given Row and given Column.
 get_sudoku_element(Puzzle,Row,Column,Element):-get_sudoku_element(Puzzle,1,Row,Column,Element).
 
 get_sudoku_element([_|RestOfPuzzle],CurrentRow,Row,Column,Element):-
    CurrentRow<Row,
    NewRow is CurrentRow+1,
    get_sudoku_element(RestOfPuzzle,NewRow,Row,Column,Element).
    
 get_sudoku_element([PuzzleRow|_],CurrentRow,Row,Column,Element):-
    CurrentRow=:=Row,
    get_element(PuzzleRow,Column,Element).
    
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
 
 %
 % Channeling
 %
 
 channeling(Name, Search):-
    puzzles(P,Name),
    transpose(P,Puzzle),
    rowConstraint(Puzzle),
    columnConstraint(Puzzle),
    blockConstraint(Puzzle),
    create_numbers(Numbers),
    channel(P,Numbers),
    is_in_each_block(Numbers),
    check_doubles(Numbers),
    collection_to_list(Numbers,LList),
    createOneList2(LList,List),
    search(Search,List,B),
    pretty_print(P,B,Search).  
 
    
    
    channel(P,Numbers):-
        (for(R,1,9),
        param(Numbers),
        param(P)
        do
            (for(C,1,9),
            param(Numbers),
            param(P),
            param(R)
                do
                get_sudoku_element(P,R,C,E),
                channel_element(E,R,C,Numbers)
               
            )
        ).
    channel_element(E,R,C,Numbers):-
        Positions1 is Numbers[1,2],  
        subscript(Positions1,[R,1],Nb1),
        #=(E,1,P11),
        #=(C,Nb1,P12),
        and(P11,P12,C1),
        
        Positions2 is Numbers[2,2], 
        subscript(Positions2,[R,1],Nb2),
        #=(E,2,P21),
        #=(C,Nb2,P22),
        and(P21,P22,C2),
        
        Positions3 is Numbers[3,2], 
        subscript(Positions3,[R,1],Nb3),
        #=(E,3,P31),
        #=(C,Nb3,P32),
        and(P31,P32,C3),
        
        Positions4 is Numbers[4,2], 
        subscript(Positions4,[R,1],Nb4),
        #=(E,4,P41),
        #=(C,Nb4,P42),
        and(P41,P42,C4),
        
        Positions5 is Numbers[5,2], 
        subscript(Positions5,[R,1],Nb5),
        #=(E,5,P51),
        #=(C,Nb5,P52),
        and(P51,P52,C5),
        
        Positions6 is Numbers[6,2], 
        subscript(Positions6,[R,1],Nb6),
        #=(E,6,P61),
        #=(C,Nb6,P62),
        and(P61,P62,C6),   
        
        Positions7 is Numbers[7,2], 
        subscript(Positions7,[R,1],Nb7),
        #=(E,7,P71),
        #=(C,Nb7,P72),
        and(P71,P72,C7),
        
        Positions8 is Numbers[8,2], 
        subscript(Positions8,[R,1],Nb8),
        #=(E,8,P81),
        #=(C,Nb8,P82),
        and(P81,P82,C8),
        
        Positions9 is Numbers[9,2], 
        subscript(Positions9,[R,1],Nb9),
        #=(E,9,P91),
        #=(C,Nb9,P92),
        and(P91,P92,C9),
        
        sumOfList([C1,C2,C3,C4,C5,C6,C7,C8,C9],1).
        
 
%% Calculates the sum of all variables in list
sumOfList(List,Sum):-
    (
	foreach(X,List),
   fromto(Expr,S1,S2,0)
   do
   S1 = X + S2
   ),
   Sum #= eval(Expr). 