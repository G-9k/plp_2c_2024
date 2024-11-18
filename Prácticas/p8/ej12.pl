% I
% inorder(+AB, -L)
inorder(nil, []).
inorder(bin(I, R, D), L) :- inorder(I, LI), inorder(D, LD), 
                            append(LI, [R], LR), append(LR, LD, L).

% II
% arbolConInorder(+L, -AB)
arbolConInorder([], nil).
arbolConInorder(L, bin(I, R, D)) :- length(L, NL), between(0, NL, N), 
                                    partir(N, L, L1, [R|L2]), arbolConInorder(L1, I), 
                                    arbolConInorder(L2, D). 

partir(0, L, [], L).
partir(N, L, L1, L2) :- N \= 0, M is N-1, partir(M, L, L1R, [X|L2]), append(L1R, [X], L1).

% III
% aBB(+T)
aBB(nil).
aBB(bin(nil, _, nil)).
aBB(bin(nil, R, D)) :- aBB(D), raiz(D, RD), menor(D, MD), R < RD, MD > R.
aBB(bin(I, R, nil)) :- aBB(I), raiz(I,RI), mayor(I, MI), R > RI, MI =< R.
aBB(bin(I, R, D)) :- aBB(I), aBB(D), raiz(I,RI), raiz(D, RD), mayor(I, MI), menor(D, MD), R > RI, R < RD, MI =< R, MD > R.

raiz(bin(_, R, _), R).

mayor(A, M) :- A \= nil, inorder(A, L), maxLista(L, M).
menor(A, M) :- A \= nil, inorder(A, L), minLista(L, M).

maxLista([X], X).
maxLista([X|L], M) :- maxLista(L, Rec), M is max(X,Rec).

minLista([X], X).
minLista([X|L], M) :- minLista(L, Rec), M is min(X,Rec).

% IV
% aBBInsertar(+X,+T1,-T2)
aBBInsertar(X, T1, T2) :- inorder(T1, L1), agregar(X, L1, L2), arbolConInorder(L2, T2), aBB(T2), raiz(T1, R1), raiz(T2, R1).

agregar(X, [E|L1], L2) :- X < E, append([X], [E|L1], L2).
agregar(X, [E|L1], L2) :- X > E, agregar(X, L1, L2R), append([E], L2R, L2).

% Funciona mas o menos, a veces genera arboles con el mismo contenido, con el X insertado, pero de forma distinta al original.
% Es solo reversible en ?T2, dado que en agregar chequeo que lo que quiero agregar sea mayor o menor al primer elemento de la 
% lista inorder del primer arbol, estos necesitan estar instanciados.