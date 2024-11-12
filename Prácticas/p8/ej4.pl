
juntar([], L2, L2).
juntar([X|L1], L2, L3) :- juntar(L1, L2, LR), L3 = [X|LR].