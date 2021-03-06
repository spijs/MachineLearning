:- use_module(library(chr)).
:- chr_constraint field/4,field/3,row/3,column/3,add/3,nbSub/1, nbBattle/1,nbCruise/1,nbDest/1,chosen/3,water/2,fillone/1,count/2,new/1,taken/2,print/2,remove_constraints/0.

count(b,I),count(t,J),count(l,K),count(r,L) ==> T is I+J, S is K+L, Tot is S+T, Tot > 12 | false.


% Translate
field(R,C,circle) <=> field(R,C,c).
field(R,C,middle) <=> field(R,C,m).
field(R,C,bottom) <=> field(R,C,b).
field(R,C,top) <=> field(R,C,t).
field(R,C,left) <=> field(R,C,l).
field(R,C,right) <=> field(R,C,r).

% Add new field

field(_,_,V) ==> new(V).

new(t), count(t,I) <=> J is I+1, count(t,J).
new(m) , count(m,I) <=> J is I+1 | J=<4, count(m,J).
new(b) , count(b,I) <=> J is I+1, count(b,J).
new(l) , count(l,I) <=> J is I+1, count(l,J).
new(r) ,count(r,I) <=> J is I+1, count(r,J).
new(water) <=> true.
new(c) <=> true.


field(R,C,V) ==> chosen(R,C,V).
add(R,C,water), field(R,C,_,_) <=> chosen(R,C,'.'),water(R,C).
add(R,C,V), row(R,Tr,Rc), column(C,Tc,Cc),field(R,C,_,L) <=> NewCc is Cc+1, NewRc is Rc+1, NewRc =<Tr, NewCc =<Tc | member(V,L), 
    field(R,C,V), row(R,Tr,NewRc),column(C,Tc,NewCc),taken(R,C).
chosen(R,C,_) \ field(R,C,_,_) <=> true.
%--------------------------------------------------------

% Aantal m en etc.

count(m,I) \ field(R,C,N,L) <=> I =:=4, select(middle,L,LL), N1 is N-1, N1>0 | field(R,C,N1,LL).
count(l,I), count(t,J) \ field(R,C,N,L) <=> K is I+J, K =:=6, subtract(L,[top,left],LL),length(LL,Le), N1 is Le, Le >0, N>N1 | field(R,C,N1,LL).
count(r,I), count(b,J) \ field(R,C,N,L) <=> K is I+J, K =:=6, subtract(L,[bottom,right],LL),length(LL,Le), N1 is Le, Le >0, N>N1 | field(R,C,N1,LL).
count(b,I),count(t,J),count(l,K),count(r,L), field(R,C,N,Li),nbBattle(B),nbCruise(C), nbDest(D) ==> 
    T is I+J, S is K+L, Tot is S+T, Tot =:= 12, subtract(Li,[bottom,top,left,right],LL),length(LL,Le) 
    , N1 is Le, Le> 0,N>N1 | B =:=1,C=:=2,D=:=3, field(R,C,N1,LL).
    
% Verminder mogelijke stukken boot

 nbSub(S), nbBattle(B), nbCruise(C), nbDest(D) , field(R,Co,_,_) ==> S=:=4,D=:=3,C=:=2,B=:=1 | add(R,Co,water).
 nbSub(I) \ field(R,C,N,L) <=> I =:= 4, select(circle,L,LL), N1 is N-1, N1>0 | field(R,C,N1,LL).
 
  
 % rekening houden met water.
 water(R,C) \ field(R,C1,N,L) <=> C1 =:=C+1, select(right,L,LL), N1 is N-1 | field(R,C1,N1,LL).
 water(R,C) \ field(R,C1,N,L) <=> C1 =:=C-1, select(left,L,LL), N1 is N-1 | field(R,C1,N1,LL).
 water(R,C) \ field(R1,C,N,L) <=> R1 =:=R+1, select(bottom,L,LL),N1 is N-1 | field(R1,C,N1,LL).
 water(R,C) \ field(R1,C,N,L) <=> R1 =:=R-1, select(top,L,LL), N1 is N-1 | field(R1,C,N1,LL).
 water(R,C) <=> true.
 
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
 % Hoeken
 field(1,1,N,L) <=> subtract(L,[middle],LL), length(LL,Le), N1 is Le, Le >0, N>N1 | field(1,1,N1,LL).
 field(1,10,N,L) <=> subtract(L,[middle],LL), length(LL,Le), N1 is Le, Le >0, N>N1 | field(1,10,N1,LL).
 field(10,1,N,L) <=> subtract(L,[middle],LL), length(LL,Le), N1 is Le, Le >0, N>N1 | field(10,1,N1,LL).
 field(10,10,N,L) <=> subtract(L,[middle],LL), length(LL,Le), N1 is Le, Le >0, N>N1 | field(10,10,N1,LL).

 % diagonaal niet mogelijk
 taken(R,C),field(Rd,Cd,_,_) ==> Rd =:= R-1, Cd =:= C-1  | add(Rd,Cd,water). 
 taken(R,C), field(Rd,Cu,_,_) ==> Rd =:= R-1, Cu =:= C+1  | add(Rd,Cu,water).
 taken(R,C), field(Ru,Cu,_,_) ==> Ru =:= R+1,Cu =:= C+1 | add(Ru,Cu,water).
 taken(R,C), field(Ru,Cd,_,_) ==> Ru =:= R+1, Cd =:= C-1 | add(Ru,Cd,water).
 
 % Links,rechts,boven,onder van submarine niet mogelijk
 field(R,C,c), field(R,Cl,_,_) ==> Cl =:= C-1, field(R,Cl,_,_) | add(R,Cl,water).
 field(R,C,c), field(R,Cr,_,_) ==> Cr =:=C+1 |add(R,Cr,water).
 field(R,C,c), field(Ru,C,_,_)  ==> Ru =:= R+1|add(Ru,C,water).
 field(R,C,c), field(Rd,C,_,_) ==> Rd =:= R-1 |add(Rd,C,water).
 
 % Als bottom of top
 field(R1,C,b) \ field(R2,C,N,L) <=> R2 =:= R1+1, subtract(L,[bottom,left,middle,right,top,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 | field(R2,C,N1,LL).
 field(R1,C,b) \ field(R2,C,N,L) <=> R2 =:= R1-1, subtract(L,[bottom,left,right,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
 field(R1,C,t) \ field(R2,C,N,L) <=> R2 =:= R1+1, subtract(L,[top,left,right,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
 field(R1,C,t) \ field(R2,C,N,L) <=> R2 =:= R1-1, subtract(L,[top,bottom,left,right,middle,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
 field(R,C1,t), field(R,C2,_,_) ==> C2=:=C1+1 | add(R,C2,water).
 field(R,C1,t), field(R,C2,_,_) ==> C2=:=C1-1 | add(R,C2,water).
 field(R,C1,b), field(R,C2,_,_) ==> C2=:=C1+1 | add(R,C2,water).
 field(R,C1,b), field(R,C2,_,_) ==> C2=:=C1-1 | add(R,C2,water).
 
 % Als right of left
 field(R,C1,r) \ field(R,C2,N,L) <=> C2 =:= C1+1, subtract(L,[bottom,left,right,middle,circle,top],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 field(R,C1,r) \ field(R,C2,N,L) <=> C2 =:= C1-1, subtract(L,[bottom,right,circle,top],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 field(R,C1,l) \ field(R,C2,N,L) <=> C2 =:= C1+1, subtract(L,[bottom,left,circle,top],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 | field(R,C2,N1,LL).
 field(R,C1,l) \ field(R,C2,N,L) <=> C2=:=C1-1, subtract(L,[bottom,top,left,right,middle,circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 field(R1,C,r), field(R2,C,_,_) ==> R is R1+1, R2=:=R | add(R,R2,water).
 field(R1,C,r), field(R2,C,_,_) ==> R is R1-1, R2=:=R | add(R,R2,water).
 field(R1,C,l), field(R2,C,_,_) ==> R is R1+1, R2=:=R | add(R,R2,water).
 field(R1,C,l), field(R2,C,_,_) ==> R is R1-1, R2=:=R | add(R,R2,water).
 
 
 % Als midden, ernaast of erboven geen sub
 field(R,C1,m) \ field(R,C2,N,L) <=> C2 =:= C1+1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0 ,N>N1| field(R,C2,N1,LL).
 field(R,C1,m) \ field(R,C2,N,L) <=> C2 =:=C1-1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R,C2,N1,LL).
 field(R1,C,m) \ field(R2,C,N,L) <=> R2 =:= R1+1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 | field(R2,C,N1,LL).
 field(R1,C,m) \ field(R2,C,N,L) <=> R2 =:= R1-1, subtract(L,[circle],LL), length(LL,Le) , N1 is Le, Le> 0,N>N1 |  field(R2,C,N1,LL).
  
%-------------------------------------------       
% Boten zijn klaar
    
% Submarine
field(_,_,c) , nbSub(I) <=>  NewI is I+1, nbSub(NewI).  
% Horizontal destroyer
field(R,C1,l),field(R,C2,r) ,nbDest(I) <=> C is C1+1, C2 =:= C | NewI is I+1, NewI =< 3, nbDest(NewI).
% Vertical destroyer
field(R2,C,b),field(R1,C,t) ,nbDest(I) <=> R is R1+1, R2 =:= R | NewI is I+1, NewI =<3, nbDest(NewI).
% Horizontal cruiser
field(R,C1,l),field(R,C2,m),field(R,C3,r) ,nbCruise(I) <=> C is C1+1, C2 =:= C, C4 is C2+1, C3=:=C4 | NewI is I+1, NewI =<2, nbCruise(NewI).
% Vertical cruiser
field(R3,C,b),field(R2,C,m),field(R1,C,t) ,nbCruise(I) <=> R is R1+1, R2 =:= R, R4 is R2+1, R3=:=R4 | NewI is I+1, NewI =<2, nbCruise(NewI).
% Horizontal cruiser
field(R,C1,l),field(R,C2,m),field(R,C3,r) ,nbCruise(I) <=> C is C1+1, C2 =:= C, C4 is C2+1, C3=:=C4 | NewI is I+1, NewI=<2, nbCruise(NewI).
% Vertical battleship
field(R4,C,b),field(R3,C,m),field(R2,C,m),field(R1,C,t) ,nbBattle(I) <=> 
    R is R1+1, R2 =:= R, R6 is R2+1, R3=:=R6, R5 is R3+1, R4=:=R5 | NewI is I+1, NewI=<1, nbBattle(NewI).    
% Horizontal battleship
field(R,C1,l),field(R,C2,m), field(R,C3,m), field(R,C4,r) ,nbBattle(I) <=> 
    C is C1+1, C2 =:= C, C5 is C2+1, C3=:=C5,C6 is C3+1,C4=:=C6 | NewI is I+1, NewI=<1, nbBattle(NewI).
    
%-------------------------------------------       
% Vervolledig boten 

  %vervolledig battleships
  
  %  l _ m -> l m m
  field(R,C1,l), field(R,C2,m),field(R,Cnew,_,_) ==> C is C1+2, C=:=C2, Cnew is C1+1 | add(R,Cnew,middle).
  % m _ r -> m m r
  field(R,C1,m), field(R,C2,r),field(R,Cnew,_,_) ==> C is C1+2, C=:=C2, Cnew is C1+1 | add(R,Cnew,middle).
  % t _ m -> t m m
  field(R1,C,t), field(R2,C,m),field(Rnew,C,_,_) ==> R is R1+2, R=:=R2, Rnew is R1+1 | add(Rnew,C,middle).
  % m _ b -> m m b
  field(R1,C,l), field(R2,C,m), field(Rnew,C,_,_) ==> R is R1+2, R=:=R2, Rnew is R1+1 | add(Rnew,C,middle).  
  % l m m _ -> l m m r
  field(R,C1,l),field(R,C2,m),field(R,C3,m), field(R,C4,_,_) ==> C7 is C1+1, C2=:=C7, C5 is C2+1, C3=:=C5,C4 is C3+1 | add(R,C4,right).
  % _ m m r -> l m m r
  field(R,C2,m),field(R,C3,m),field(R,C4,r), field(R,C1,_,_) ==> C5 is C3+1, C5=:=C4,C6 is C2+1, C6=:=C3,C1 is C2-1 | add(R,C1,left).
  % t m m _ -> t m m b
  field(R1,C,t),field(R2,C,m),field(R3,C,m), field(R4,C,_,_) ==> R7 is R1+1, R2=:=R7, R5 is R2+1, R3=:=R5,R4 is R3+1 | add(R4,C,bottom).
  % _ m m b -> l m m b
  field(R2,C,m),field(R3,C,m),field(R4,C,b), field(R1,C,_,_) ==> R5 is R3+1, R5=:=R4,R6 is R2+1, R6=:=R3,R1 is R2-1 | add(R1,C,top).
  % t _ _ b -> t m m b 
  field(R,C1,t),field(R,C4,b), field(R,C2,_,_), field(R,C3,_,_) ==> C is C1+3, C4=:=C, C2 is C1+1, C3 is C1+2  | add(R,C2,middle) , add(R,C3,middle).
  % l _ _ r -> l m m r
  field(R1,C,l),field(R4,C,r), field(R2,C,_,_), field(R3,C,_,_) ==> R is R1+3, R4=:=R, R2 is R1+1, R3 is R1+2 | add(R2,C,middle) ,add(R3,C,middle).
  % _ m m _ -> l m m r
  field(R,C2,m), field(R,C3,m), field(R,C1,_,_), field(R,C4,_,_) ==> C1 is C2-1,C4 is C3+1, C3 =:=C2+1 | add(R,C1,left), add(R,C4,right).
  % _ m m _ -> t m m b
  field(R2,C,m), field(R3,C,m), field(R1,C,_,_), field(R4,C,_,_) ==> R1 is R2-1,R4 is R3+1, R3 =:=R2+1 | add(R1,C,top), add(R4,C,bottom).
  
  % vervolledig cruisers
  % l _ r -> l m r
  field(R,C1,l), field(R,C3,r), field(R,C2,_,_) ==> C is C1+2, C3=:=C, C2 is C1+1 | add(R,C2,middle).
  % t _ b -> t m b
  field(R1,C,t), field(R3,C,b), field(R2,C,_,_) ==> R is R1+2, R3=:=R, R2 is R1+1 | add(R2,C,middle).
  % l m en battleship al geplaatst.
  field(R,C1,l),field(R,C2,m),nbBattle(1),field(R,C3,_,L) ==> member(right,L),C2 =:= C1+1,C3 is C2+1 | add(R,C3,right).
  % _ m r en battleship al geplaatst.
  field(R,C2,m),field(R,C3,r),nbBattle(1),field(R,C3,_,L) ==> member(left,L),C3 =:= C2+1,C1 is C2-1 | add(R,C1,left).
  % t m en battleship al geplaatst.
  field(R1,C,t),field(R2,C,m),nbBattle(1),field(R3,C,_,L) ==> member(bottom,L),R2 =:= R1+1,R3 is R2+1 | add(R3,C,bottom).
  % _ m b en battleship al geplaatst.
  field(R2,C,m),field(R3,C,b),nbBattle(1),field(R3,C,_,L) ==> member(top,L),R3 =:= R2+1,R1 is R2-1 | add(R1,C,left).
  
  % Vervolledig destroyers als nog maar één plaats over
  column(C,T,Co), field(R,C,t), field(R1,C,_,_) ==> T1 is T-1, Co=:=T1, R1 is R+1  | add(R1,C,bottom).
  row(R,T,Co), field(R,C,l), field(R,C1,_,_) ==> T1 is T-1, Co=:=T1,  C1 is C+1 | add(R,C1,right).
  column(C,T,Co), field(R,C,b), field(R1,C,_,_) ==> T1 is T-1, Co=:=T1 , R1 is R-1 | add(R1,C,top).
  row(R,T,Co), field(R,C,r), field(R,C1,_,_) ==> T1 is T-1, Co=:=T1 , C1 is C-1| add(R,C1,left).
  
  %vervolledig destroyers als cruisers en battleships al geplaatst.
  field(R,C,l), nbBattle(1), nbCruise(2), field(R,C2,_,L) ==> member(right,L),C2 is C+1 | add(R,C2,right).
  field(R,C,r), nbBattle(1), nbCruise(2), field(R,C2,_,L) ==> member(left,L),C2 is C-1 | add(R,C2,left).
  field(R,C,t), nbBattle(1), nbCruise(2), field(R2,C,_,L) ==> member(bottom,L),R2 is R+1 | add(R2,C,bottom).
  field(R,C,b), nbBattle(1), nbCruise(2), field(R2,C,_,L) ==> member(top,L),R2 is R-1 | add(R2,C,top).
  
  %--------------------------------------------------------------
  % Start filling
  
  field(A,B,N2,L)\ fillone(N) <=> N2=:=N | 
    member(V,L), add(A,B,V), fillone(1).

  fillone(N) <=> N < 7 | N1 is N+1, fillone(N1).
  
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
    set_hints(Hints),
    fillone(1),
    print_solutions,
    remove_constraints.


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
    field(I,J,7,[middle,top,bottom,left,right,circle,water]),
    NewJ is J+1,
    set_other_rows(I,NewJ).

set_numbers:-
    nbSub(0),nbCruise(0),nbBattle(0),nbDest(0),count(m,0),count(t,0),count(b,0),count(r,0),count(l,0).
    
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
    print_row(9),
    print_row(10).       
    
print_row(X):-print(X,1),print(X,2),print(X,3),print(X,4),print(X,5),print(X,6),print(X,7),print(X,8),print(X,9),print(X,10).
print(R,10),chosen(R,10,V) <=> write(V),nl.
print(R,C),chosen(R,C,V) <=> write(V).

% remove unnecessary constraints when finished.

remove_constraints \ count(_,_) <=> true.
remove_constraints \ nbSub(_) <=> true.
remove_constraints \ nbCruise(_) <=> true.
remove_constraints \ nbDest(_) <=> true.
remove_constraints \ nbBattle(_) <=> true.
remove_constraints \ taken(_,_) <=> true.
remove_constraints \ water(_,_) <=> true.
remove_constraints <=> true.