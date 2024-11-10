natural(0).
natural(suc(X)) :- natural(X).

% menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).
% menorOIgual(X,X) :- natural(X).

/* I. Al realizar la consulta menorOIgual(0, X). todo se cuelga.
II. Prolog se puede colgar en las circunstancias en las que vuelve a entrar
en la misma regla sin acercarse a un caso que no lo haga ejecutar su caso recursivo.
En esos casos es analogo a decir que no tiene caso base.
*/

menorOIgual(X,X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).

/*
III. La corrección consiste en asegurarse que primero siempre verifique el caso base
aun así, este programa no termina pero tampoco se cuelga, ya que devuelve infinitos resultados.
*/
