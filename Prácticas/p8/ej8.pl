interseccion(_, [], []).
interseccion([], _, []).
interseccion([X|L1], [Y|L2], R) :- member(A, [X|L1]), member(A, [Y|L2]), interseccion(L1, L2, LR), append([A], LR, R).