/*Isaac Montes Jiménez*/
/*Viernes 12 de Noviembre 2018*/
/*Método de búsqueda por profundidad con un límite 8 puzzle*/

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

printTab([]).
printTab([A,B,C]):-write(A),write(B),write(C),nl,nl,!.
printTab([A,B,C|R]):-write(A),write(B),write(C),nl,printTab(R).

/*Dos metodos de profundidad para dar formato de imprimir en pantalla el recorrido con las direcciones de los tableros*/
/*profundidad(Tinicial,Tmeta,LimiteProfundidad)*/
profundidad([],_,_).
profundidad(Tmeta,Tmeta,_):-write(inicio),nl,printTab(Tmeta).
profundidad(Tin,Tmeta,Limite):-write(inicio),nl,printTab(Tin),profundidadR(Tin,Tmeta,Limite).

profundidadR(Tmeta,Tmeta,_).

profundidadR(Tin,Tmeta,Limite):-Limite>0,izq(Tin,Tab),Tab\=[],write(izquierda),nl,printTab(Tab),
    Lim is Limite-1,profundidadR(Tab,Tmeta,Lim).

profundidadR(Tin,Tmeta,Limite):-Limite>0,arr(Tin,Tab),Tab\=[],write(arriba),nl,printTab(Tab),
    Lim is Limite-1,profundidadR(Tab,Tmeta,Lim).

profundidadR(Tin,Tmeta,Limite):-Limite>0,der(Tin,Tab),Tab\=[],write(derecha),nl,printTab(Tab),
    Lim is Limite-1,profundidadR(Tab,Tmeta,Lim).

profundidadR(Tin,Tmeta,Limite):-Limite>0,aba(Tin,Tab),Tab\=[],write(abajo),nl,printTab(Tab),
   Lim is Limite-1,profundidadR(Tab,Tmeta,Lim).
