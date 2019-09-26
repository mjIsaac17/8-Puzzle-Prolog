/*quitarRepetidos(TableroParaVerSiEstaEnLosFueraFrontera,ElementosFueraFrontera,Salida)*/
quitarRepetidos([],_,[]).
quitarRepetidos(Tablero,[Tablero|_],[]).
quitarRepetidos(Tablero,[FueraFrontera],Tablero).
quitarRepetidos(Tablero,[_|Resto],Elemento):-quitarRepetidos(Tablero,Resto,Elemento).

/*Insertar los Hijos al final de la frontera*/
/*Insertar los hijos al fin de la frontera y frontera vacía*/
insertar(Frontera,Hijos,Hijos):-Frontera==[].

/*[H|Q] es la frontera, [H|Q2] es la frontera modificada
Hijos, los tableros que se introducen a la frontera*/
insertar([H|Q],Hijos,[H|Q2]):-insertar(Q,Hijos,Q2).

/*Remover el primer tablero de la frontera*/
remover([H|Q],H,Q).

/*Verificar la meta*/
sucesor1Meta(TabPadre,_,Tmeta):-izq(TabPadre,Tizq),Tizq==Tmeta;der(TabPadre,Tder),Tder==Tmeta;arr(TabPadre,Tarr),Tarr==Tmeta;
aba(TabPadre,Taba),Taba==Tmeta.
sucesor1(TabPadre,Hijos):-izq(TabPadre,Tizq),der(TabPadre,Tder),arr(TabPadre,Tarr),
aba(TabPadre,Taba),concatenarTab([Tizq,Tder,Tarr,Taba],Hijos).


sucesor2Meta(TabPadre,_,_,Tmeta):-izq(TabPadre,Tizq),Tizq==Tmeta;der(TabPadre,Tder),Tder==Tmeta;arr(TabPadre,Tarr),Tarr==Tmeta;
aba(TabPadre,Taba),Taba==Tmeta.
sucesor2(TabPadre,HijosSinRepetidos,FueraFrontera):-izq(TabPadre,Tizq),quitarRepetidos(Tizq,FueraFrontera,HijoIzq),
    der(TabPadre,Tder),quitarRepetidos(Tder,FueraFrontera,HijoDer),arr(TabPadre,Tarr),quitarRepetidos(Tarr,FueraFrontera,HijoArr)
,aba(TabPadre,Taba),quitarRepetidos(Taba,FueraFrontera,HijoAba),concatenarTab([HijoIzq,HijoDer,HijoArr,HijoAba],HijosSinRepetidos).

izq([Q,W,0|R],[Q,0,W|R]).
izq([Q,0|R],[0,Q|R]).
izq([0|_],[]).
izq([Q,W,E,A,S,0|R],[Q,W,E,A,0,S|R]).
izq([Q,W,E,A,0|R],[Q,W,E,0,A|R]).
izq([_,_,_,0|_],[]).
izq([Q,W,E,A,S,D,Z,X,0],[Q,W,E,A,S,D,Z,0,X]).
izq([Q,W,E,A,S,D,Z,0,C],[Q,W,E,A,S,D,0,Z,C]).
izq([_,_,_,_,_,_,0|_],[]).

der([_,_,0|_],[]).
der([Q,0,E|R],[Q,E,0|R]).
der([0,W|R],[W,0|R]).
der([_,_,_,_,_,0|_],[]).
der([Q,W,E,A,0,D|R],[Q,W,E,A,D,0|R]).
der([Q,W,E,0,S|R],[Q,W,E,S,0|R]).
der([_,_,_,_,_,_,_,_,0],[]).
der([Q,W,E,A,S,D,Z,0,C],[Q,W,E,A,S,D,Z,C,0]).
der([Q,W,E,A,S,D,0,X,C],[Q,W,E,A,S,D,X,0,C]).

arr([0|_],[]).
arr([_,0|_],[]).
arr([_,_,0|_],[]).
arr([Q,W,E,0|R],[0,W,E,Q|R]).
arr([Q,W,E,A,0|R],[Q,0,E,A,W|R]).
arr([Q,W,E,A,S,0|R],[Q,W,0,A,S,E|R]).
arr([Q,W,E,A,S,D,0|R],[Q,W,E,0,S,D,A|R]).
arr([Q,W,E,A,S,D,Z,0,C],[Q,W,E,A,0,D,Z,S,C]).
arr([Q,W,E,A,S,D,Z,X,0],[Q,W,E,A,S,0,Z,X,D]).

aba([0,W,E,A|R],[A,W,E,0|R]).
aba([Q,0,E,A,S|R],[Q,S,E,A,0|R]).
aba([Q,W,0,A,S,D|R],[Q,W,D,A,S,0|R]).
aba([Q,W,E,0,S,D,Z|R],[Q,W,E,Z,S,D,0|R]).
aba([Q,W,E,A,0,D,Z,X,C],[Q,W,E,A,X,D,Z,0,C]).
aba([Q,W,E,A,S,0,Z,X,C],[Q,W,E,A,S,C,Z,X,0]).
aba([_,_,_,_,_,_,0|_],[]).
aba([_,_,_,_,_,_,_,0,_],[]).
aba([_,_,_,_,_,_,_,_,0],[]).

concatenarTab([Tab],[Tab]):-Tab\=[].
concatenarTab([Tab],[]).
concatenarTab([Tab|Tableros],[Tab|Resto]):-Tab\=[],concatenarTab(Tableros,Resto).
concatenarTab([Tab|Tableros],Resto):-concatenarTab(Tableros,Resto).

printTab([]).
printTab([A,B,C]):-write(A),write(B),write(C),nl,nl.
printTab([A,B,C|R]):-write(A),write(B),write(C),nl,printTab(R).

/*Tin, tablero inicial, Tmeta, tablero meta, Recorrido un intento para guardar
los tableros que se recorren*/
amplitud(Tin,Tmeta,Recorrido):-amplitud1(Tin,Tmeta,[Tin],Recorrido).

/*amplitud1 es cuando no hay frontera, solo el nodo raiz
FueraFrontera almacena los elemetos fuera de la frontera,
comparandose con los nuevos tableros para que no se repita
alguno*/
amplitud1([],_,_,[]).
amplitud1(Tmeta,Tmeta,_,Tmeta).
amplitud1(Tin,Tmeta,_,_):-sucesor1Meta(Tin,_,Tmeta).
amplitud1(Tin,Tmeta,FueraFrontera,[Elemento|Recorrido]):-sucesor1(Tin,Frontera),remover(Frontera,Elemento,FronteraRemove),
    printTab(Elemento),amplitud2(Elemento,Tmeta,Recorrido,FronteraRemove,[Elemento|FueraFrontera]).

/*amplitud2 ya contiene la frontera*/
amplitud2(Tin,Tmeta,_,_,_):- sucesor2Meta(Tin,_,_,Tmeta).
amplitud2(Tin,Tmeta,[Elemento|Recorrido],Frontera,FueraFrontera):-
    sucesor2(Tin,Hijos,FueraFrontera),insertar(Frontera,Hijos,FronteraInsertada),
    remover(FronteraInsertada,Elemento,FronteraRemove),printTab(Elemento),
    amplitud2(Elemento,Tmeta,Recorrido,FronteraRemove,[Elemento|FueraFrontera]).













