% parteQueSuma(+L, +S, -P)
parteQueSuma(_, 0, []).
parteQueSuma([X|XS], S, P) :- S > 0, S1 is S-X, parteQueSuma(XS, S1, P1), append([X], P1, P).
parteQueSuma([_|XS], S, P) :- S > 0, parteQueSuma(XS, S, P).