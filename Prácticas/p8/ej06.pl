%aplanar(+Xs, -Ys)
aplanar([], []).
%aplanar([X], [X]) :- not(is_list(X)).
aplanar([X|Xs], Ys) :- not(is_list(X)), aplanar(Xs, Rs), append([X], Rs, Ys).
aplanar([X|Xs], Ys) :- is_list(X), aplanar(X, Ls), aplanar(Xs, Rs), append(Ls, Rs, Ys).