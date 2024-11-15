% I
% last(?L, ?U)
last(L, U) :- append(_, [U], L).

% II
% reverse(+L, -L1)
reverse([], []).
reverse([X|L], L1) :- reverse(L, LR), append(LR, [X], L1).

% III
% prefijo(?P, +L)
prefijo(P, L) :- append(P, _, L).

% IV
% sufijo(?S, +L)
sufijo(S, L) :- append(_, S, L).

% V
% sublista(?S, +L)
sublista(S, L) :- prefijo(P, L), sufijo(S, P).

% VI
% pertenece(?X, +L)
pertenece(X, [X|_]).
pertenece(X, [_|L]) :- pertenece(X, L).
