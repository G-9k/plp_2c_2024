padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).

% I. El resultado de la consulta de abuelo(x, manuel). es juan

hijo(X,Y) :- padre(Y, X).
hermano(X,Y) :- padre(Z, X), padre(Z, Y), X \= Y.

descendiente(X,Y) :- hijo(X,Y).
descendiente(X,Y) :- hijo(Z,Y), descendiente(X, Z).


% IV. La consulta que hay que hacer para encontrar a los nietos de juan es: abuelo(juan, X).

% V. Para conocer a todos los hermanos de pablo hermano(pablo, X).

ancestro(X, Y) :- padre(X, Y).
ancestro(X, Y) :- padre(X, Z), ancestro(Z, Y).

/*
VII. La primera respuesta es que juan es su propio ancestro, luego a medida que
le pedis mas respuestas, se queda trabado al final.

VIII. Para corregirlo, le cambie la primera regla para que verifique que es ancestro
solo si X es padre de Y. Luego le cambie de orden los predicados que llama en la segunda regla.
*/