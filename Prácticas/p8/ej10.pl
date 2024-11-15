intercalar([], L2, L2).
intercalar(L1, [], L1).
intercalar([X|XS], [Y|YS], L3) :- intercalar(XS, YS, L3R), append([X], [Y], R), append(R, L3R, L3).

/*
En cuanto a la reversibilidad, es posible obtener L3 en base a L1 y L2.
Si sucede que L1 y L2 tienen el mismo tamaño, entonces responde 2 veces
debido a que tiene 2 casos bases.
Dado L1 y L3 se puede obtener L2
Dado L2 y L3 se puede obtener L1
Dado L3 se obtienen las distintas combinanciones posibles que hace L3, pero luego de dar todas se cuelga.
*/

