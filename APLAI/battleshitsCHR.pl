:- use_module(library(chr)).
:- chr_constraint field/4,field/3,row/4,column/4,battleship/4,cruiser/3,destroyer/2,submarine/1,add/3,nbSub/1,nbBattle/1,nbCruise/1,nbDest/1,taken/2,chosen/2.

row(_,C,T,_) ==> C>T | false.
column(_,C,T,_) ==> C>T | false.
column(_,_,_,C) ==> C>10|false.
row(_,_,_,C) ==> C>10 |false.
taken(R,C) \ taken(R,C) <=> true.

field(R,C,_) \ field(R,C,_,_) <=> true.
field(0,_,_) <=> true.
field(_,0,_) <=> true.
add(0,_,_) <=> true.
add(_,0,_) <=> true.

% Translate
field(R,C,circle) <=> field(R,C,c).
field(R,C,middle) <=> field(R,C,m).
field(R,C,bottom) <=> field(R,C,b).
field(R,C,top) <=> field(R,C,t).
field(R,C,left) <=> field(R,C,l).
field(R,C,right) <=> field(R,C,r).

% Add new field
add(R,C,water), row(R,Nr,Tr,Rc), column(C,Nc,Tc,Cc) <=>
    NewRc is Rc+1, NewCc is Cc+1,row(R,Nr,Tr,NewRc),column(C,Nc,Tc,NewCc),chosen(R,C).
add(R,C,V), row(R,Nr,Tr,Rc), column(C,Nc,Tc,Cc) <=> 
    field(R,C,V), NewNr is Nr+1, NewNc is Nc+1, NewCc is Cc+1, NewRc is Rc+1, row(R,NewNr,Tr,NewRc),column(C,NewNc,Tc,NewCc),taken(R,C),chosen(R,C).
    
taken(R,C) \ field(R,C,_,_) <=> true.

    
% Verminder mogelijke stukken boot

 % diagonaal niet mogelijk
 taken(R,C) ==> Ru is R+1, Rd is R-1, Cu is C+1, Cd is C-1, add(Rd,Cd,water), add(Rd,Cu,water), add(Rd,Cd,water), add(Ru,Cd,water). 
 % Links en rechts van submarine niet mogelijk
 field(R,C,c) ==> Rd is R-1, Ru is R+1, Cl is C-1, Cr is C+1, add(R,Cl,water), add(R,Cr,water), add(Ru,C,water), add(Rd,C,water).
 % Links van links stuk niet mogelijk
 field(R,C,l) ==> Cl is C-1, add(R,Cl,water).
 % Rechts van rechts stuk niet mogelijk
 field(R,C,r) ==> Cr is C+1, add(R,Cr,water).
 % Boven top stuk niet mogelijk
 field(R,C,t) ==> Rt is R-1, add(Rt,C,water).
 % Onder bottom stuk niet mogelijk
 field(R,C,b) ==> Rb is R+1, add(Rb,C,water).
 % Als bottom of top eronder of erboven geen bottom mogelijk
 field(R1,C,b) \ field(R2,C,N,L) <=> R2 is R1+1, subtract(L,[bottom,left,middle,right,top,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 | field(R2,C,N1,LL).
 field(R1,C,b) \ field(R2,C,N,L) <=> R2 is R1-1, subtract(L,[bottom,left,right,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
 field(R1,C,t) \ field(R2,C,N,L) <=> R2 is R1+1, subtract(L,[left,right,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
 field(R1,C,t) \ field(R2,C,N,L) <=> R2 is R1-1, subtract(L,[top,bottom,left,right,middle,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
 % Als right of left ernaast geen left of right mogelijk.
 field(R,C1,r) \ field(R,C2,N,L) <=> C2 is C1+1, subtract(L,[bottom,left,right,middle,circle,top],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 field(R,C1,r) \ field(R,C2,N,L) <=> C2 is C1-1, subtract(L,[bottom,right,circle,top],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 field(R,C1,l) \ field(R,C2,N,L) <=> C2 is C1+1, subtract(L,[bottom,left,circle,top],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 | field(R,C2,N1,LL).
 field(R,C1,l) \ field(R,C2,N,L) <=> C2 is C1-1, subtract(L,[bottom,top,left,right,middle,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 % Als midden, ernaast of erboven geen sub
 field(R,C1,m) \ field(R,C2,_,L) <=> C2 is C1+1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0 | field(R,C2,N1,LL).
 field(R,C1,m) \ field(R,C2,_,L) <=> C2 is C1-1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0 |  field(R,C2,N1,LL).
 field(R,C1,m) \ field(R,C2,_,L) <=> C2 is C1+1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0 | field(R,C2,N1,LL).
 field(R,C1,m) \ field(R,C2,_,L) <=> C2 is C1-1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0 |  field(R,C2,N1,LL).
  
% Boten zijn klaar
    
% Submarine
field(R,C,c) , nbSub(I) <=>  submarine(field(R,C,c)), NewI is I+1, nbSub(NewI).  
% Horizontal destroyer
field(R,C1,l),field(R,C2,r) ,nbDest(I) <=> C is C1+1, C2 =:= C | NewI is I+1, nbDest(NewI).
% Vertical destroyer
field(R1,C,b),field(R2,C,t) ,nbDest(I) <=> R is R1+1, R2 =:= R | NewI is I+1, nbDest(NewI).
% Horizontal cruiser
field(R,C1,l),field(R,C2,m),field(R,C3,r) ,nbDest(I) <=> C is C1+1, C2 =:= C, C4 is C2+1, C3=:=C4 | NewI is I+1, nbDest(NewI).
% Vertical cruiser
field(R1,C,b),field(R2,C,m),field(R3,C,t) ,nbDest(I) <=> R is R1+1, R2 =:= R, R4 is R2+1, R3=:=R4 | NewI is I+1, nbDest(NewI).
% Horizontal cruiser
field(R,C1,l),field(R,C2,m),field(R,C3,r) ,nbDest(I) <=> C is C1+1, C2 =:= C, C4 is C2+1, C3=:=C4 | NewI is I+1, nbDest(NewI).
% Vertical battleship
field(R1,C,b),field(R2,C,m),field(R3,C,m),field(R4,C,t) ,nbDest(I) <=> 
    R is R1+1, R2 =:= R, R6 is R2+1, R3=:=R6, R5 is R3+1, R4=:=R5 | NewI is I+1, nbDest(NewI).    
% Horizontal battleship
field(R,C1,l),field(R,C2,m), field(R,C3,m), field(R,C4,r) ,nbDest(I) <=> 
    C is C1+1, C2 =:= C, C5 is C2+1, C3=:=C5,C6 is C3+1,C4=:=C6 | NewI is I+1, nbDest(NewI).
       
    
solve(Id):-
    problem(Id, Hints, RowTallies,ColumnTallies ),
    set_numbers,
    set_column_tallies(ColumnTallies),
    set_row_tallies(RowTallies),
    set_other_fields,
    set_hints(Hints).


set_other_fields:- set_other_fields(1).
set_other_fields(I):-I>10.
set_other_fields(I):-
    I=<10,
    set_other_rows(I,1),
    NewI is I+1,
    set_other_fields(NewI).
    
set_other_rows(_,I):-I>10.
set_other_rows(I,J):-
    J=<10,
    field(I,J,7,[water,circle,middle,top,bottom,left,right]),
    NewJ is J+1,
    set_other_rows(I,NewJ).

set_numbers:-
    nbSub(0),nbCruise(0),nbBattle(0),nbDest(0).
    
set_column_tallies(T):- set_column_tallies(T,1).

set_column_tallies([],_).
set_column_tallies([H|T],I):-
        column(I,0,H,0),
        I1 is I+1,
        set_column_tallies(T,I1).
        
set_row_tallies(T):- set_row_tallies(T,1).
set_row_tallies([],_).
set_row_tallies([H|T],I):-
    row(I,0,H,0),
    I1 is I+1,
    set_row_tallies(T,I1).
    
set_hints([]).

set_hints([(R,C,V)|T]):-
    add(R,C,V),
    set_hints(T).

    