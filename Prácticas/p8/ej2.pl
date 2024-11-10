% vecino(X, Y, [X|[Y|Ls]]).
% vecino(X, Y, [W|Ls]) :- vecino(X, Y, Ls).

vecino(X, Y, [W|Ls]) :- vecino(X, Y, Ls).
vecino(X, Y, [X|[Y|Ls]]).

/*
II. Si se invierte el orden de las reglas los resultados son los mismos.
tan solo que el orden de los resultados cambian.
*/

