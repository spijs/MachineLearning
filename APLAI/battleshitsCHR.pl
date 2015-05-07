:- use_module(library(chr)).
:- chr_constraint field/4,field/3,row/3,column/3,add/3,nbSub/1, nbBattle/1,nbCruise/1,nbDest/1,taken/2,chosen/2,fillone/1.

nbBattle(I) ==> I>1 | false.
nbCruise(I) ==> I>2 | false.
nbDest(I) ==> I>3 | false.
nbSub(I) ==> I>4 | false.

field(_,_,0,[]) ==> false.
row(_,T,C) ==> C>T | false.
column(_,T,C) ==> C>T | false.
column(_,_,C) ==> C>10|false.
row(_,_,C) ==> C>10 |false.
taken(R,C) \ taken(R,C) <=> true.

field(R,C,_) \ field(R,C,_,_) <=> true.
field(0,_,_) <=> true.
field(_,0,_) <=> true.
add(0,_,_) <=> true.
add(_,0,_) <=> true.
add(I,_,_) <=> I>10 | true.
add(_,I,_) <=> I>10 | true.

% Translate
field(R,C,circle) <=> field(R,C,c).
field(R,C,middle) <=> field(R,C,m).
field(R,C,bottom) <=> field(R,C,b).
field(R,C,top) <=> field(R,C,t).
field(R,C,left) <=> field(R,C,l).
field(R,C,right) <=> field(R,C,r).

% Add new field
add(R,C,water) <=> chosen(R,C).
add(R,C,V), row(R,Tr,Rc), column(C,Tc,Cc),field(R,C,_,L) <=> member(V,L), 
    field(R,C,V), NewCc is Cc+1, NewRc is Rc+1, row(R,Tr,NewRc),column(C,Tc,NewCc),taken(R,C),chosen(R,C).
    
taken(R,C) \ field(R,C,_,_) <=> true.

%--------------------------------------------------------
    
% Verminder mogelijke stukken boot

 nbSub(S), nbBattle(B), nbCruise(C), nbDest(D) , field(R,Co,_,_) ==> S=:=4,D=:=3,C=:=2,B=:=1 | add(R,Co,water).
 nbSub(I) \ field(R,C,N,L) <=> I =:= 4, select(L,circle,LL), N1 is N-1, N1>0 | field(R,C,N1,LL).
 
 % rij of kolom zijn gevuld
 column(C,N,N) , field(R,C,_,_) ==> add(R,C,water).
 row(R,N,N) , field(R,C,_,_) ==> add(R,C,water).
 column(_,N,N) <=> true.
 row(_,N,N) <=> true.
 
 % bovenste rij
 field(R,C,N,L) <=> R=:=1, subtract(L,[bottom],LL), length(LL,Le),N1 is Le, Le>0, N>N1 | field(R,C,N1,LL).
 % onderste rij
 field(R,C,N,L) <=> R=:=10, subtract(L,[top],LL), length(LL,Le),N1 is Le, Le>0, N>N1 | field(R,C,N1,LL).
 % linke kolom
 field(R,C,N,L) <=> C=:=1, subtract(L,[right],LL), length(LL,Le),N1 is Le, Le>0, N>N1 | field(R,C,N1,LL).
 % rechtse kolom
 field(R,C,N,L) <=> C=:=10, subtract(L,[left],LL), length(LL,Le),N1 is Le, Le>0, N>N1 | field(R,C,N1,LL).

 % diagonaal niet mogelijk
 taken(R,C) ==> Ru is R+1, Rd is R-1, Cu is C+1, Cd is C-1, add(Rd,Cd,water), add(Rd,Cu,water), add(Rd,Cd,water), add(Ru,Cd,water). 
 % Links,rechts,boven,onder van submarine niet mogelijk
 field(R,C,c) ==> Rd is R-1, Ru is R+1, Cl is C-1, Cr is C+1, add(R,Cl,water), add(R,Cr,water), add(Ru,C,water), add(Rd,C,water).
 
 % Als bottom of top
 field(R1,C,b) \ field(R2,C,N,L) <=> R2 is R1+1, subtract(L,[bottom,left,middle,right,top,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 | field(R2,C,N1,LL).
 field(R1,C,b) \ field(R2,C,N,L) <=> R2 is R1-1, subtract(L,[bottom,left,right,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
 field(R1,C,t) \ field(R2,C,N,L) <=> R2 is R1+1, subtract(L,[left,right,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
 field(R1,C,t) \ field(R2,C,N,L) <=> R2 is R1-1, subtract(L,[top,bottom,left,right,middle,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
 field(R,C1,t), field(R,C2,_,_) ==> C is C1+1, C2=:=C | add(R,C2,water).
 field(R,C1,t), field(R,C2,_,_) ==> C is C1-1, C2=:=C | add(R,C2,water).
 field(R,C1,b), field(R,C2,_,_) ==> C is C1+1, C2=:=C | add(R,C2,water).
 field(R,C1,b), field(R,C2,_,_) ==> C is C1-1, C2=:=C | add(R,C2,water).
 
 % Als right of left
 field(R,C1,r) \ field(R,C2,N,L) <=> C2 is C1+1, subtract(L,[bottom,left,right,middle,circle,top],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 field(R,C1,r) \ field(R,C2,N,L) <=> C2 is C1-1, subtract(L,[bottom,right,circle,top],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 field(R,C1,l) \ field(R,C2,N,L) <=> C2 is C1+1, subtract(L,[bottom,left,circle,top],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 | field(R,C2,N1,LL).
 field(R,C1,l) \ field(R,C2,N,L) <=> C2 is C1-1, subtract(L,[bottom,top,left,right,middle,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 field(R1,C,r), field(R2,C,_,_) ==> R is R1+1, R2=:=R | add(R,R2,water).
 field(R1,C,r), field(R2,C,_,_) ==> R is R1-1, R2=:=R | add(R,R2,water).
 field(R1,C,l), field(R2,C,_,_) ==> R is R1+1, R2=:=R | add(R,R2,water).
 field(R1,C,l), field(R2,C,_,_) ==> R is R1-1, R2=:=R | add(R,R2,water).
 
 
 % Als midden, ernaast of erboven geen sub
 field(R,C1,m) \ field(R,C2,N,L) <=> C2 is C1+1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0 ,N>N1| field(R,C2,N1,LL).
 field(R,C1,m) \ field(R,C2,N,L) <=> C2 is C1-1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 field(R1,C,m) \ field(R2,C,N,L) <=> R2 is R1+1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 | field(R2,C,N1,LL).
 field(R1,C,m) \ field(R2,C,N,L) <=> R2 is R1-1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
  
%-------------------------------------------       
% Boten zijn klaar
    
% Submarine
field(_,_,c) , nbSub(I) <=>  NewI is I+1, nbSub(NewI).  
% Horizontal destroyer
field(R,C1,l),field(R,C2,r) ,nbDest(I) <=> C is C1+1, C2 =:= C | NewI is I+1, nbDest(NewI).
% Vertical destroyer
field(R2,C,b),field(R1,C,t) ,nbDest(I) <=> R is R1+1, R2 =:= R | NewI is I+1, nbDest(NewI).
% Horizontal cruiser
field(R,C1,l),field(R,C2,m),field(R,C3,r) ,nbDest(I) <=> C is C1+1, C2 =:= C, C4 is C2+1, C3=:=C4 | NewI is I+1, nbDest(NewI).
% Vertical cruiser
field(R3,C,b),field(R2,C,m),field(R1,C,t) ,nbDest(I) <=> R is R1+1, R2 =:= R, R4 is R2+1, R3=:=R4 | NewI is I+1, nbDest(NewI).
% Horizontal cruiser
field(R,C1,l),field(R,C2,m),field(R,C3,r) ,nbDest(I) <=> C is C1+1, C2 =:= C, C4 is C2+1, C3=:=C4 | NewI is I+1, nbDest(NewI).
% Vertical battleship
field(R4,C,b),field(R3,C,m),field(R2,C,m),field(R1,C,t) ,nbDest(I) <=> 
    R is R1+1, R2 =:= R, R6 is R2+1, R3=:=R6, R5 is R3+1, R4=:=R5 | NewI is I+1, nbDest(NewI).    
% Horizontal battleship
field(R,C1,l),field(R,C2,m), field(R,C3,m), field(R,C4,r) ,nbDest(I) <=> 
    C is C1+1, C2 =:= C, C5 is C2+1, C3=:=C5,C6 is C3+1,C4=:=C6 | NewI is I+1, nbDest(NewI).
    
%-------------------------------------------       
% Vervolledig boten 

  %vervolledig battleships
  
  %  l _ m -> l m m
  field(R,C1,l), field(R,C2,m) ==> C is C1+2, C=:=C2, Cnew is C1+1 | add(R,Cnew,middle).
  % m _ r -> m m r
  field(R,C1,m), field(R,C2,r) ==> C is C1+2, C=:=C2, Cnew is C1+1 | add(R,Cnew,middle).
  % t _ m -> t m m
  field(R1,C,t), field(R2,C,m) ==> R is R1+2, R=:=R2, Rnew is R1+1 | add(Rnew,C,middle).
  % m _ b -> m m b
  field(R1,C,l), field(R2,C,m) ==> R is R1+2, R=:=R2, Rnew is R1+1 | add(Rnew,C,middle).  
  % l m m _ -> l m m r
  field(R,C1,l),field(R,C2,m),field(R,C3,m) ==> C7 is C1+1, C2=:=C7, C5 is C2+1, C3=:=C5,C4 is C3+1 | add(R,C4,right).
  % _ m m r -> l m m r
  field(R,C2,m),field(R,C3,m),field(R,C4,r) ==> C5 is C3+1, C5=:=C4,C6 is C2+1, C6=:=C3,C1 is C2-1 | add(R,C1,left).
  % t m m _ -> t m m b
  field(R1,C,t),field(R2,C,m),field(R3,C,m) ==> R7 is R1+1, R2=:=R7, R5 is R2+1, R3=:=R5,R4 is R3+1 | add(R4,C,bottom).
  % _ m m b -> l m m b
  field(R2,C,m),field(R3,C,m),field(R4,C,b) ==> R5 is R3+1, R5=:=R4,R6 is R2+1, R6=:=R3,R1 is R2-1 | add(R1,C,top).
  % t _ _ b -> t m m b 
  field(R,C1,t),field(R,C4,b) ==> C is C1+3, C4=:=C, C2 is C1+1, C3 is C1+2 | add(R,C2,middle) , add(R,C3,middle).
  % l _ _ r -> l m m r
  field(R1,C,l),field(R4,C,r) ==> R is R1+3, R4=:=R, R2 is R1+1, R3 is R1+2 | add(R2,C,middle) ,add(R3,C,middle).

  % vervolledig cruisers
  % l _ r -> l m r
  field(R,C1,l), field(R,C3,r) ==> C is C1+2, C3=:=C, C2 is C1+1 | add(R,C2,middle).
  % t _ b -> t m b
  field(R1,C,t), field(R3,C,b) ==> R is R1+2, R3=:=R, R2 is R1+1 | add(R2,C,middle).
  
  % Vervolledig destroyers als nog maar één plaats over
  column(C,T,Co), field(R,C,t) ==> T1 is T-1, Co=:=T1 | R1 is R+1, add(R1,C,bottom).
  row(R,T,Co), field(R,C,l) ==> T1 is T-1, Co=:=T1 | C1 is C+1, add(R,C1,right).
  column(C,T,Co), field(R,C,b) ==> T1 is T-1, Co=:=T1 | R1 is R-1, add(R1,C,top).
  row(R,T,Co), field(R,C,r) ==> T1 is T-1, Co=:=T1 | C1 is C-1, add(R,C1,left).
  
  %--------------------------------------------------------------
  % Start filling
  
  fillone(N), field(A,B,N2,L) <=> N2=:=N | 
    member(V,L), field(A,B,V), fillone(1).
    
 % Fill if column has little possilibities
fillone(N), column(C,T,Co),field(R,C,_,L) <=> D is T-Co, D=:=N | member(V,L), field(R,C,V), fillone(1).
% Fill if row has small amount of possibilities.
fillone(N), column(R,T,Co),field(R,C,_,L) <=> D is T-Co, D=:=N | member(V,L), field(R,C,V), fillone(1).

  fillone(N) <=> N < 10 | N1 is N+1, fillone(N1).
  
  %---------------------------------------------------------------
  % stopvoorwaarden
  
fillone(_) , nbBattle(I) ==> I\==1 | false.
fillone(_) , nbCruise(I) ==> I\==2 | false.
fillone(_) , nbDest(I) ==> I\==3 | false.
nbSub(I),fillone(_) ==> I\==4 | false.
fillone(_) <=> true.
  
  %---------------------------------------------------------------
  
solve(Id):-
    problem(Id, Hints, RowTallies,ColumnTallies ),
    set_numbers,
    set_other_fields,
    set_column_tallies(ColumnTallies),
    set_row_tallies(RowTallies),
    set_hints(Hints).
   % fillone(1).


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
    field(I,J,7,[circle,middle,top,bottom,left,right,water]),
    NewJ is J+1,
    set_other_rows(I,NewJ).

set_numbers:-
    nbSub(0),nbCruise(0),nbBattle(0),nbDest(0).
    
set_column_tallies(T):- set_column_tallies(T,1).

set_column_tallies([],_).
set_column_tallies([H|T],I):-
        column(I,H,0),
        I1 is I+1,
        set_column_tallies(T,I1).
        
set_row_tallies(T):- set_row_tallies(T,1).
set_row_tallies([],_).
set_row_tallies([H|T],I):-
    row(I,H,0),
    I1 is I+1,
    set_row_tallies(T,I1).
    
set_hints([]).

set_hints([(R,C,V)|T]):-
    add(R,C,V),
    set_hints(T).

    