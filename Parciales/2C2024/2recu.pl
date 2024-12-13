desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

caminoDesde((PX, PY), XS) :- desde(0,D), caminoDistancia((PX, PY), D, YS), reverse(YS, XS).

caminoDistancia((PX,PY), 0, [(PX,PY)]).

caminoDistancia((PX,PY), D, [(NPX,RPY),(RPX,RPY)|YS]) :- D > 0, D1 is D-1, caminoDistancia((PX,PY), D1, [(RPX,RPY)|YS]), NPX is RPX + 1.
caminoDistancia((PX,PY), D, [(NPX,RPY),(RPX,RPY)|YS]) :- D > 0, D1 is D-1, caminoDistancia((PX,PY), D1, [(RPX,RPY)|YS]), NPX is RPX - 1.
caminoDistancia((PX,PY), D, [(RPX,NPY),(RPX,RPY)|YS]) :- D > 0, D1 is D-1, caminoDistancia((PX,PY), D1, [(RPX,RPY)|YS]), NPY is RPY + 1.
caminoDistancia((PX,PY), D, [(RPX,NPY),(RPX,RPY)|YS]) :- D > 0, D1 is D-1, caminoDistancia((PX,PY), D1, [(RPX,RPY)|YS]), NPY is RPY - 1.


% caminoDesde((PX,PY), [(PX,PY)]).
% caminoDesde((PX,PY), C) :- caminoDesde((PX,PY), Z), append(_, [Ult], Z), camino(Ult, D), append(Z, [D], C).

% camino((X,Y), (NX,Y)) :- NX is X + 1.
% camino((X,Y), (NX,Y)) :- NX is X - 1.
% camino((X,Y), (X,NY)) :- NY is Y + 1.
% camino((X,Y), (X,NY)) :- NY is Y - 1.

