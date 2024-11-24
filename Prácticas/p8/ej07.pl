% I
% intersección(+L1,+L2,-L3)
interseccion(_, [], []).
interseccion([], _, []).
interseccion([X|XS], [X|YS], R) :- interseccion(XS, YS, Rec), append([X], Rec, R).
interseccion([X|XS], [Y|YS], R) :- X \= Y, interseccion(XS, [Y|YS], R).

% partir(+N, ?L, ?L1, ?L2)
partir(0, L, [], L).
partir(N, L, L1, L2) :- N \= 0, M is N-1, partir(M, L, L1R, [X|L2]), append(L1R, [X], L1).

/*
Mi implementación necesita el numero ya que en el caso recursivo lo usa para comparar y
operar, luego, la lista puede o no estar instanciada, y ahí el predicado te dirá si puede 
construir la lista original dado esos parametros. Si nada está instanciado salvo el numero,
te dará listas instanciadas con variables desconocidas lo cual no es muy util, pero es verdad.
Si L está instanciada y L1 y L2 no, entonces realizará la partición tal y como sugiere el enunciado.
*/

% II
% borrar(+LO, +X, -LS).
borrar(_, [], []).
borrar(E, [X|Xs], R) :- E \= X, borrar(E, Xs, Rec), append([X], Rec, R).
borrar(E, [E|Xs], R) :- borrar(E, Xs, R).

% III
% sacarDuplicados(+L1, -L2)
sacarDuplicados([], []).
sacarDuplicados([X|XS], [X|LR]) :- borrar(X, XS, L), sacarDuplicados(L, LR).

% IV
% permutacion(+L1, -L2)
permutacion([X], [X]).
permutacion([X|L1], L2) :- permutacion(L1, LR), agregar(X, LR, L2).

agregar(X, L1, L2) :- length(L1, N), between(0, N, A), partir(A, L1, LR1, LR2), append(LR1, [X], LRR1), append(LRR1, LR2, L2).

% V
% reparto(+L, +N, -LR)
reparto(L, 1, [L]).
reparto(L, N, LR) :- N > 1, M is N-1, length(L, LE), between(0, LE, A), partir(A, L, L1, L2), reparto(L2, M, Rec), append([L1], Rec, LR).

% VI
% repartoSinVacias(+L, -LS).
repartoSinVacias(L, LS) :- length(L, LE), between(1, LE, X), repartoAux(L, X, LS).

repartoAux(L, 1, [L]).
repartoAux(L, N, LR) :- N > 1, M is N-1, length(L, LE), LE1 is LE - 1, between(1, LE1, A), partir(A, L, L1, L2), repartoAux(L2, M, Rec), append([L1], Rec, LR).
