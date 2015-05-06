:- use_module(library(chr)).
:- chr_constraint number_row/4,number_row/3, add/3, fillone/1,print/2.

% number in a row must have a column
number_row(_,_,0,[]) <=> false.

%add
add(V,R,C), number_row(V,R,_,_)  <=> number_row(V,R,C).
number_row(V,R,C) \ add(V,R,C) <=>true.
 
% same number and column
same_column @ number_row(V,_,D) \ number_row(V,R,N,L) <=>  select(D,L,LL) | 
    N1 is N-1, N1>0, number_row(V,R,N1,LL).
    
%same row and column
same_row @ number_row(_,R,D) \ number_row(V,R,N,L) <=> select(D,L,LL) | 
    N1 is N-1, N1>0, number_row(V,R,N1,LL).
    
% same block    
same_block @ number_row(A,R,C) \ number_row(A,R2,N,L) <=> findall(El,(member(El,L), same_block(R,C,R2,El)),Els), subtract(L,Els,LL), length(Els,N2),
    N1 is N-N2, N2>0 | number_row(A,R2,N1,LL).


% Fill values by choosing - cfr. 
fillone(N), number_row(A,B,N2,L) <=> N2=N | 
    member(V,L), number_row(A,B,V), fillone(1).
fillone(N) <=> N < 9 | N1 is N+1, fillone(N1).
fillone(_) <=> true.


solve(Puzzle):-
    puzzles(P,Puzzle),
    write(setconstraints), time(set_constraints(P)),
    write(fillingin), time(fillone(1)).
    write(printing),nl, time(print_solutions).
 
% Prepare 
   
set_totals(N):-N>9.
set_totals(I):-
    I =< 9,
    set_rows(I,1),
    I1 is I+1,
    set_totals(I1).

set_rows(_,N):-N>9.
set_rows(N,R):- 
    R =< 9,
    number_row(N,R,9,[1,2,3,4,5,6,7,8,9]),
    NewR is R+1,
    set_rows(N,NewR).


set_constraints(P):-set_totals(1),set_constraints(P,1).
set_constraints([],_).
set_constraints([H|T],I):-
    set_list_constraints(H,I,1),
    J is I+1,
    set_constraints(T,J).
    
set_list_constraints([],_,_).
set_list_constraints([H|T],I,J):-
    (\+(var(H)) ->
        add(H,I,J)
        ;
        true
    ),
    
    NewJ is J+1,
    set_list_constraints(T,I,NewJ).
 
  
% Print

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
    
print_row(X):-print(X,1),print(X,2),print(X,3),print(X,4),print(X,5),print(X,6),print(X,7),print(X,8),print(X,9).
print(R,9),number_row(V,R,9) <=> M is R mod 3, M == 0 | write(V),nl,write(------------),nl.
print(R,9),number_row(V,R,9) <=> write(V),nl.
print(R,C),number_row(V,R,C) <=> M is C mod 3, M == 0 | write(V),write('|').
print(R,C),number_row(V,R,C) <=> write(V).
    
    
same_block(X1,Y1,X2,Y2):- X1=<3,X2=<3,Y1=<3,Y2=<3. % LL
same_block(X1,Y1,X2,Y2):- X1=<3,X2=<3,Y1>6,Y2>6. % LB
same_block(X1,Y1,X2,Y2):- Y1>3,Y1=<6,Y2>3,Y2=<6,X1=<3,X2=<3. % LM

same_block(X1,Y1,X2,Y2):- X1>6,X2>6,Y1=<3,Y2=<3. % Rechtsboven
same_block(X1,Y1,X2,Y2):- X1>6,X2>6,Y1>6,Y2>6. % Rechtsonder
same_block(X1,Y1,X2,Y2):- Y1>3,Y1=<6,Y2>3,Y2=<6,X1>6,X2>6. % Rechtsmidden

same_block(X1,Y1,X2,Y2):- X1>3,X1=<6,X2>3,X2=<6,Y1=<3,Y2=<3. % Middenboven
same_block(X1,Y1,X2,Y2):- Y1>3,Y1=<6,Y2>3,Y2=<6,X1>3,X1=<6,X2>3,X2=<6. % Middenmidden
same_block(X1,Y1,X2,Y2):- X1>3,X1=<6,X2>3,X2=<6,Y1>6,Y2>6. % MiddenOnder
