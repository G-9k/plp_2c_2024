% I

desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

/*
Tiene que estar instanciado el primero si, y el segundo no.
Esto ocurre porque si el primero no está instanciado, luego de
dar true por la primera regla, al ir a la segunda debe resolver
la cuenta X+1 el cual debe dar un numero, pero al no estar instanciado
X, no sabe que tiene que ser N, entonces falla.

Si estan ambos instanciados, va a sumarse 1 a la primera componente hasta ser
igual a la segunda componente. Cuando eso suceda dará true, luego seguira 
sumandose hasta el infinito y se quedará colgada. Si la primera componente es
mas grande que la segunda entonces se queda colgado de primera.
*/

% II

desde2(X, X).
desde2(X, Y) :- nonvar(X), nonvar(Y), X < Y, N is X+1, desde2(N,Y).
desde2(X, Y) :- nonvar(X), var(Y), N is X+1, desde2(N,Y).