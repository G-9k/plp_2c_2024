desde(X,X).
desde(X,Y) :- N is X+1, desde(N,Y).

caminoDesde((PX, PY), [(PX,PY)]).
caminoDesde((PX, PY), [X|XS]) :- X = (PX, PY), desde(1,D), caminoDistancia((PX, PY), D, YS), reverse(YS, XS).

caminoDistancia((PX,PY), 1, [(NPX,PY)]) :- NPX is PX + 1.
caminoDistancia((PX,PY), 1, [(NPX,PY)]) :- NPX is PX - 1.
caminoDistancia((PX,PY), 1, [(PX,NPY)]) :- NPY is PY + 1.
caminoDistancia((PX,PY), 1, [(PX,NPY)]) :- NPY is PY - 1.

caminoDistancia((PX,PY), D, [(NPX,RPY),(RPX,RPY)|YS]) :- D > 1, D1 is D-1, caminoDistancia((PX,PY), D1, [(RPX,RPY)|YS]), NPX is RPX + 1.
caminoDistancia((PX,PY), D, [(NPX,RPY),(RPX,RPY)|YS]) :- D > 1, D1 is D-1, caminoDistancia((PX,PY), D1, [(RPX,RPY)|YS]), NPX is RPX - 1.
caminoDistancia((PX,PY), D, [(RPX,NPY),(RPX,RPY)|YS]) :- D > 1, D1 is D-1, caminoDistancia((PX,PY), D1, [(RPX,RPY)|YS]), NPY is RPY + 1.
caminoDistancia((PX,PY), D, [(RPX,NPY),(RPX,RPY)|YS]) :- D > 1, D1 is D-1, caminoDistancia((PX,PY), D1, [(RPX,RPY)|YS]), NPY is RPY - 1.