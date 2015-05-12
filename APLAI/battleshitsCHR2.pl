:- use_module(library(chr)).
:- chr_constraint field/4,row/5,column/5,add/3,add1/3,chosen/3,water/2, trow/2,tcol/2,
 fill_battle/0,fill_cruiser/1,fill_destroyer/1, fill_submarine/1,taken/2,print/2, water2/2,boat/2,boat2/2.

% Remove doubles
chosen(R,C,V)\chosen(R,C,V) <=> true.
taken(R,C) \ taken(R,C) <=> true.

% If position is taken by a boat -> fill in boat.
taken(R,C) ==> boat(R,C),boat2(R,C).

%---------------------------------------------
% Add a field.

% There need to be enough spaces left not taken by a ship to fulfill the tally
add1(_,C,water),column(C,T,Co,F,_) ==> 10-F-1 < T-Co | false.
add1(R,_,water),row(R,T,Co,F,_) ==> 10-F-1 < T-Co | false.
add(_,C,water),column(C,T,Co,F,_) ==> 10-F-1< T-Co | false.
add(R,_,water),row(R,T,Co,F,_) ==> 10-F-1 < T-Co | false.


% If the only possibility is water -> pick the water
field(R,C,1,[water]) <=> chosen(R,C,'.'),water(R,C),water2(R,C).

% If only one possibility.
field(R,C,1,[V]) ==> chosen(R,C,V),taken(R,C).

% Add a boat piece.
add(R,C,V), row(R,Tr,Rc,Fr,Br), column(C,Tc,Cc,Fc,Bc),field(R,C,_,L) <=> NewCc is Cc+1, NewFc is Fc+1, NewFr is Fr+1, NewRc is Rc+1, NewRc =<Tr, NewCc =<Tc | member(V,L), row(R,Tr,NewRc,NewFr,Br),column(C,Tc,NewCc,NewFc,Bc),taken(R,C),chosen(R,C,V).
    
% Add a field because you know it must be there.
add1(R,C,water), field(R,C,_,L) <=> member(water,L), chosen(R,C,'.'),water(R,C),water2(R,C).
add1(R,C,V), field(R,C,_,L) <=> member(V,L), field(R,C,1,[V]).

%--------------------------------------------------------
% Rekening houden met boten
 
 % Als bootstuk is toegevoegd wijzig aantal velden met boot in bij zowel rij als kolom
  boat(_,C),  column(C,Tc,Cc,Fc,Bc) <=>  NewBc is Bc+1,column(C,Tc,Cc,Fc,NewBc).
  boat2(R,_), row(R,Tr,Cr,Fr,Br)<=>  NewBr is Br+1,row(R,Tr,Cr,Fr,NewBr).
  
 %-----------------------------------------------------------
 % rekening houden met water.
  
 % rij of kolom zijn gevuld ofwel door geplaatste boten ofwel door velden met nog maar een mogelijkheid.
 column(C,N,N,_,_) , field(R,C,_,L) ==> member(water,L) | add1(R,C,water).
 row(R,N,N,_,_) , field(R,C,_,L) ==> member(water,L) | add1(R,C,water).
 column(C,N,_,_,N) , field(R,C,_,L) ==> member(water,L) | add1(R,C,water).
 row(R,N,_,_,N) , field(R,C,_,L) ==> member(water,L) | add1(R,C,water).

 % Als water verminder mogelijkheden van naast gelegen velden.
 water(R,C) \ field(R,C1,N,L) <=> C1 =:=C+1, select(right,L,LL), N1 is N-1 | field(R,C1,N1,LL).
 water(R,C) \ field(R,C1,N,L) <=> C1 =:=C-1, select(left,L,LL), N1 is N-1 | field(R,C1,N1,LL).
 water(R,C) \ field(R1,C,N,L) <=> R1 =:=R+1, select(bottom,L,LL),N1 is N-1 | field(R1,C,N1,LL).
 water(R,C) \ field(R1,C,N,L) <=> R1 =:=R-1, select(top,L,LL), N1 is N-1 | field(R1,C,N1,LL).
 
 % Verhoog het aantal watervelden in kolommen en rijen.
 water(_,C),  column(C,Tc,Cc,Fc,B)<=>  NewFc is Fc+1,column(C,Tc,Cc,NewFc,B).
 water2(R,_), row(R,Tr,Cr,Fr,B)<=>  NewFr is Fr+1,row(R,Tr,Cr,NewFr,B).
 
 % Verwijder kolom of rij als volledig gevuld.
 column(_,N,N,_,_) <=> true.
 row(_,N,N,_,_) <=> true.
 
 %-------------------------------------------------------------
 % Verminder mogelijkheden
 
 % bovenste rij
 field(R,C,N,L) <=> R=:=1, subtract(L,[bottom],LL), length(LL,Le),N1 is Le, Le>0, N>N1 | field(R,C,N1,LL).
 % onderste rij
 field(R,C,N,L) <=> R=:=10, subtract(L,[top],LL), length(LL,Le),N1 is Le, Le>0, N>N1 | field(R,C,N1,LL).
 % linke kolom
 field(R,C,N,L) <=> C=:=1, subtract(L,[right],LL), length(LL,Le),N1 is Le, Le>0, N>N1 | field(R,C,N1,LL).
 % rechtse kolom
 field(R,C,N,L) <=> C=:=10, subtract(L,[left],LL), length(LL,Le),N1 is Le, Le>0, N>N1 | field(R,C,N1,LL).
 % Hoeken
 field(1,1,N,L) <=> subtract(L,[middle],LL), length(LL,Le), N1 is Le, Le >0, N>N1 | field(1,1,N1,LL).
 field(1,10,N,L) <=> subtract(L,[middle],LL), length(LL,Le), N1 is Le, Le >0, N>N1 | field(1,10,N1,LL).
 field(10,1,N,L) <=> subtract(L,[middle],LL), length(LL,Le), N1 is Le, Le >0, N>N1 | field(10,1,N1,LL).
 field(10,10,N,L) <=> subtract(L,[middle],LL), length(LL,Le), N1 is Le, Le >0, N>N1 | field(10,10,N1,LL).

 % diagonaal niet mogelijk
 taken(R,C), field(Rd,Cd,_,L) ==> Rd =:= R-1, Cd =:= C-1 | member(water,L),add1(Rd,Cd,water). 
 taken(R,C), field(Rd,Cu,_,L) ==> Rd =:= R-1, Cu =:= C+1 | member(water,L),add1(Rd,Cu,water).
 taken(R,C), field(Ru,Cu,_,L) ==> Ru =:= R+1, Cu =:= C+1 | member(water,L),add1(Ru,Cu,water).
 taken(R,C), field(Ru,Cd,_,L) ==> Ru =:= R+1, Cd =:= C-1 | member(water,L),add1(Ru,Cd,water).
 
 % Links,rechts,boven,onder van submarine niet mogelijk
 chosen(R,C,circle), field(R,Cl,_,L) ==> Cl =:= C-1 | member(water,L), add1(R,Cl,water).
 chosen(R,C,circle), field(R,Cr,_,L) ==> Cr =:=C+1 |member(water,L), add1(R,Cr,water).
 chosen(R,C,circle), field(Ru,C,_,L)  ==> Ru =:= R+1|member(water,L), add1(Ru,C,water).
 chosen(R,C,circle), field(Rd,C,_,L) ==> Rd =:= R-1 |member(water,L), add1(Rd,C,water).
 
 % Als bottom of top
 chosen(R1,C,bottom) , field(R2,C,_,_) ==> R2 =:= R1+1 | add1(R2,C,water).
 chosen(R1,C,bottom)\ field(R2,C,N,L) <=> R2 =:= R1-1, subtract(L,[bottom,left,right,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
 chosen(R1,C,top) \ field(R2,C,N,L) <=> R2 =:= R1+1, subtract(L,[top,left,right,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
 chosen(R1,C,top) , field(R2,C,_,_) ==> R2 =:= R1-1 | add1(R2,C,water).
 chosen(R,C1,top), field(R,C2,_,_) ==> C2=:=C1+1 | add1(R,C2,water).
 chosen(R,C1,top), field(R,C2,_,_) ==> C2=:=C1-1 | add1(R,C2,water).
 chosen(R,C1,bot), field(R,C2,_,_) ==> C2=:=C1+1 | add1(R,C2,water).
 chosen(R,C1,bot), field(R,C2,_,_) ==> C2=:=C1-1 | add1(R,C2,water).
 
 % Als right of left
 chosen(R,C1,right), field(R,C2,_,_) ==> C2 =:= C1+1 | add1(R,C2,water).
 chosen(R,C1,right) \ field(R,C2,N,L) <=> C2 =:= C1-1, subtract(L,[bottom,right,circle,top],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 chosen(R,C1,left) \ field(R,C2,N,L) <=> C2 =:= C1+1, subtract(L,[bottom,left,circle,top],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 | field(R,C2,N1,LL).
 chosen(R,C1,left) , field(R,C2,_,_) ==> C2=:=C1-1 | add1(R,C2,water).
 chosen(R1,C,right), field(R2,C,_,_) ==> R is R1+1, R2=:=R | add1(R2,C,water).
 chosen(R1,C,right), field(R2,C,_,_) ==> R is R1-1, R2=:=R | add1(R2,C,water).
 chosen(R1,C,left), field(R2,C,_,_) ==> R is R1+1, R2=:=R | add1(R2,C,water).
 chosen(R1,C,left), field(R2,C,_,_) ==> R is R1-1, R2=:=R | add1(R2,C,water).
 
 
 % Als midden, ernaast of erboven geen sub
 chosen(R,C1,middle) \ field(R,C2,N,L) <=> C2 =:= C1+1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0 ,N>N1| field(R,C2,N1,LL).
 chosen(R,C1,middle) \ field(R,C2,N,L) <=> C2 =:=C1-1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 chosen(R1,C,middle) \ field(R2,C,N,L) <=> R2 =:= R1+1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 | field(R2,C,N1,LL).
 chosen(R1,C,middle) \ field(R2,C,N,L) <=> R2 =:= R1-1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
  
%------------------------------------------------------------
  % Start filling

  
 %make battleship horizontal
 
  field(R,C1,_,L1), field(R,C2,_,L2), field(R,C3,_,L3), field(R,C4,_,L4),row(R,T,F,Nbtaken,_) \ fill_battle 
    <=> T-F>=4,10-Nbtaken >= 4, C2=:=C1+1, C3=:=C2+1, C4=:=C3+1, member(left,L1), member(middle,L2), member(middle,L3), member(right,L4) ,
        add(R,C1,left), add(R,C2,middle), add(R,C3,middle), add(R,C4,right), fill_cruiser(2) | true.     
        
 %make battleship vertical
  field(R1,C,_,L1), field(R2,C,_,L2), field(R3,C,_,L3), field(R4,C,_,L4),column(C,T,F,Nbtaken,_) \ fill_battle 
    <=> T-F>=4,10-Nbtaken >= 4, R2=:=R1+1, R3=:=R2+1, R4=:=R3+1, member(top,L1), member(middle,L2), member(middle,L3), member(bottom,L4) ,
        add(R1,C,top), add(R2,C,middle), add(R3,C,middle), add(R4,C,bottom), fill_cruiser(2) | true.  
        
 %make cruisers horizontal
  field(R,C1,_,L1), field(R,C2,_,L2), field(R,C3,_,L3),row(R,T,F,Nbtaken,_)\ fill_cruiser(I) <=> NewI is I-1, NewI >=0,
    T-F>=3,10-Nbtaken >= 3,C2=:=C1+1, C3=:=C2+1, member(left,L1), member(middle,L2), member(right,L3) ,
        add(R,C1,left), add(R,C2,middle),add(R,C3,right),fill_cruiser(NewI) | true.
    % make cruisers vertical
  field(R1,C,_,L1), field(R2,C,_,L2), field(R3,C,_,L3),column(C,T,F,Nbtaken,_)\ fill_cruiser(I)  <=> NewI is I-1, NewI >=0,
    T-F>=3,10-Nbtaken >= 3, R2=:=R1+1, R3=:=R2+1, member(top,L1), member(middle,L2),member(bottom,L3) ,
        add(R1,C,top), add(R2,C,middle), add(R3,C,bottom),fill_cruiser(NewI) | true. 
        
  fill_cruiser(0) <=> fill_destroyer(3).
        
 %make destroyers horizontal
  field(R,C1,_,L1), field(R,C2,_,L2),row(R,T,F,Nbtaken,_) \ fill_destroyer(I) <=> NewI is I-1, NewI >=0,
    T-F>=2,10-Nbtaken >= 2,C2=:=C1+1,member(left,L1),member(right,L2) ,
        add(R,C1,left), add(R,C2,right),fill_destroyer(NewI) | true.
    % make destroyers vertical
  field(R1,C,_,L1), field(R2,C,_,L2),column(C,T,F,Nbtaken,_)  \ fill_destroyer(I) <=> NewI is I-1, NewI >=0,
    T-F>=2,10-Nbtaken >= 2,R2=:=R1+1, member(top,L1), member(bottom,L2) ,
        add(R1,C,top),add(R2,C,bottom),fill_destroyer(NewI) | true.      
        
  fill_destroyer(0) <=> fill_submarine(4).
 % make submarines
  field(R,C,_,L)\ fill_submarine(I) <=> NewI is I-1, NewI >=0,member(circle,L) ,  add(R,C,circle),fill_submarine(NewI) | true.      
        
        
        
 %---------------------------------------------------------------
  % stopvoorwaarden
  
  fill_submarine(0)   <=> true.
  fill_submarine(_) <=> false.
  fill_destroyer(_) <=> false.
  fill_cruiser(_) <=> false.
  fill_battle <=> false.

%--------------------------------------------------------------
 % Translate
 
chosen(R,C,circle) <=> chosen(R,C,c).
chosen(R,C,middle) <=> chosen(R,C,m).
chosen(R,C,bottom) <=> chosen(R,C,b).
chosen(R,C,top) <=> chosen(R,C,t).
chosen(R,C,left) <=> chosen(R,C,l).
chosen(R,C,right) <=> chosen(R,C,r).
  
%-----------------------------------------------------------------
% Print 

% writes the chosen constraint according to the print constraint.    
print(R,C),chosen(R,C,V) <=> write(V).
print(R,11),trow(R,T) <=> write(' '),write(T),nl.
print(11,C),tcol(C,T) <=> write(T).
%---------------------------------------------------------------
 
 
 % solve_all:-
 % finds and prints the solution of all the battleship problems currently loaded.
 
 solve_all:-
    findall(_,solve(_),_).
  
% solve(Id):-
%   finds and prints the solutions of the battleship problem with the given Id

solve(Id):-
    problem(Id, Hints, RowTallies,ColumnTallies ),
    write(puzzle),write(Id),nl,
    set_other_fields,
    set_column_tallies(ColumnTallies),
    set_row_tallies(RowTallies),
    time(solve_together(Hints)),nl,
    print_solutions,nl,nl.

 % solve_together(Hints):-
 %   Hints is a list of clues in the format (row,column,value)
 %   this predicate is responsible for setting the hints and filling the values.
    
 solve_together(Hints):-
    set_hints(Hints),
    fill_battle.
    
    
% set_other_fields
% Sets the domains of every field in the battleship board .

set_other_fields:- set_other_fields(1).


% set_other_fields(I):-
% I is an integer.
% Sets the domains of each field in the given row I.

set_other_fields(I):-I>10.
set_other_fields(I):-
    I=<10,
    set_other_rows(I,1),
    NewI is I+1,
    set_other_fields(NewI).
 
 
% set_other_fields(I,J):-
% I and J are integers
% adds each field at row I, column J with a full domain to the constraint store.

set_other_rows(_,I):-I>10.
set_other_rows(I,J):-
    J=<10,
    field(I,J,7,[middle,top,bottom,left,right,circle,water]),
    NewJ is J+1,
    set_other_rows(I,NewJ).

% set_collumn_tallies(T)
% T is a list of ten integers    
% adds all the columns according to their tally to the constraint store.

set_column_tallies(T):- set_column_tallies(T,1).
set_column_tallies([],_).
set_column_tallies([H|T],I):-
        tcol(I,H),
        column(I,H,0,0,0),
        I1 is I+1,
        set_column_tallies(T,I1).
        
        
% set_row_tallies(T)
% T is a list of ten integers    
% adds all the row according to their tally to the constraint store.
        
set_row_tallies(T):- set_row_tallies(T,1).
set_row_tallies([],_).
set_row_tallies([H|T],I):-
    trow(I,H),
    row(I,H,0,0,0),
    I1 is I+1,
    set_row_tallies(T,I1).
    
    
% set_hints(L):-
% L is a list of hints in the format (row,column,value)
% adds each hint to the CHR constraint store.
    
set_hints([]).
set_hints([(R,C,V)|T]):-
    add1(R,C,V),
    set_hints(T).

    
% Print_solutions
% Prints all the rows of the battleship solution

print_solutions:-
    print_row(1),
    print_row(2),
    print_row(3),
    print_row(4),
    print_row(5),
    print_row(6),
    print_row(7),
    print_row(8),
    print_row(9),
    print_row(10),
    print_tallies.       
    
% print_row(X):-
% X is an integer representing a row.
% Prints the Xth row of the battleship solution.

print_row(X):-
    print(X,1),print(X,2),print(X,3),print(X,4),print(X,5),print(X,6),print(X,7),print(X,8),print(X,9),print(X,10),print(X,11).

    
% print_tallies:-
% Prints the column tallies

print_tallies:-
    nl,
    print(11,1),print(11,2),print(11,3),print(11,4),print(11,5),print(11,6),print(11,7),print(11,8),print(11,9),print(11,10).