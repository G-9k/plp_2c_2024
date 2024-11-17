vacio(nil).

raiz(bin(_, R, _), R).

altura(nil, 0).
altura(bin(I, _, D), A) :- altura(I, AI), altura(D, AD), max(AI, AD, AM), A is AM+1. 

max(N1, N2, M) :- N1 > N2, M = N1.
max(N1, N2, M) :- N1 =< N2, M = N2.

cantidadDeNodos(nil, 0).
cantidadDeNodos(bin(I, _, D), C) :- cantidadDeNodos(I, CI), cantidadDeNodos(D, CD), C is CI+CD+1.