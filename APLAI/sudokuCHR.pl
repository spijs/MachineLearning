:- use_module(library(chr)).
:- chr_constraint field/4,field/3,fase/1,print/2,fillone/1.

%-----------------------------------------------------------------------------------------
% Rules

% same column
same_column @ field(_,B,D) \ field(A,B,N,L) <=> select(D,L,LL) | 
    N1 is N-1, N1>0, field(A,B,N1,LL).
% same row
same_row @ field(A,_,V) \ field(A,B,N,L) <=> select(V,L,LL) | 
    N1 is N-1, N1>0, field(A,B,N1,LL).    
% same block    
same_block @ field(A,B,V) \ field(C,D,N,L) <=> select(V,L,LL), same_block(A,B,C,D) |
    N1 is N-1, N1>0, field(C,D,N1,LL).

% One value left
field(A,B,1,[V]) <=> field(A,B,V).

%-------------------------------------------------------------------------------------------
% Filling

% Fill values by choosing - cfr. https://dtai.cs.kuleuven.be/CHR/old/examples/sudoku_thom.pl

fillone(N), field(A,B,N2,L) <=> N2=:=N | 
    member(V,L), field(A,B,V), fillone(1).
fillone(N) <=> N < 9 | N1 is N+1, fillone(N1).
fillone(_) <=> true.

%----------------------------------------------------------------------------------------------

% solve(Puzzle):-
% solves the sudoku puzzle with Puzzle as id.

solve(Puzzle):-
    puzzles(P,Puzzle),
    write(constraints), time(set_constraints(P)),
    write(filling), time(fillone(2)),
    write(printing),nl, time(print_solutions),
    write(finished).
 
% Prepare 
   
% set_constraints(P):-
% Adds the necessary constraints for the puzzle P to the constraint store.

set_constraints(P):-set_constraints(P,1).
set_constraints([],_).
set_constraints([H|T],I):-
    set_list_constraints(H,I,1),
    J is I+1,
    set_constraints(T,J).
    
    
% set_list_constraints(L,I,J):-
% recursively adds each field of the sudoku puzzle to the constraint store.
% L is a list of 9 integers.
% I is the row.
% J is the current column.

set_list_constraints([],_,_).
set_list_constraints([H|T],I,J):-
    (\+(var(H)) ->
        field(I,J,H)
        ;
        field(I,J,9,[1,2,3,4,5,6,7,8,9])
    ),
    NewJ is J+1,
    set_list_constraints(T,I,NewJ).
    
%---------------------------------------------------------------    
% Print

% print_solutions
% Prints each row of the solved sudoku puzzle.

print_solutions:-
    print_row(1),
    print_row(2),
    print_row(3),
    print_row(4),
    print_row(5),
    print_row(6),
    print_row(7),
    print_row(8),
    print_row(9).    
    
% print_row(X):-
% Prints the solution for the Xth row.
   
print_row(X):-print(X,1),print(X,2),print(X,3),print(X,4),print(X,5),print(X,6),print(X,7),print(X,8),print(X,9).

%----------------------------------------------------
% Print rules
print(R,9),field(R,9,V) <=> M is R mod 3, M == 0 | write(V),nl,write(------------),nl.
print(R,9),field(R,9,V) <=> write(V),nl.
print(R,C),field(R,C,V) <=> M is C mod 3, M == 0 | write(V),write('|').
print(R,C),field(R,C,V) <=> write(V).

%--------------------------------------  

% same_block(X1,Y1,X2,Y2):-
% evaluates to true if (X1,Y1) and (X2,Y2) are in the same sudoku block.
% X1,Y1,X2,Y2 are all integers.

same_block(X1,Y1,X2,Y2):- X1=<3,X2=<3,Y1=<3,Y2=<3. % LB
same_block(X1,Y1,X2,Y2):- X1=<3,X2=<3,Y1>6,Y2>6. % LT
same_block(X1,Y1,X2,Y2):- Y1>3,Y1=<6,Y2>3,Y2=<6,X1=<3,X2=<3. % LM

same_block(X1,Y1,X2,Y2):- X1>6,X2>6,Y1=<3,Y2=<3. % RT
same_block(X1,Y1,X2,Y2):- X1>6,X2>6,Y1>6,Y2>6. % RB
same_block(X1,Y1,X2,Y2):- Y1>3,Y1=<6,Y2>3,Y2=<6,X1>6,X2>6. % RM

same_block(X1,Y1,X2,Y2):- X1>3,X1=<6,X2>3,X2=<6,Y1=<3,Y2=<3. % MT
same_block(X1,Y1,X2,Y2):- Y1>3,Y1=<6,Y2>3,Y2=<6,X1>3,X1=<6,X2>3,X2=<6. % MM
same_block(X1,Y1,X2,Y2):- X1>3,X1=<6,X2>3,X2=<6,Y1>6,Y2>6. % MB