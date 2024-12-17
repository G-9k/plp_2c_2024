% cantidadApar(_, [], 0).
% cantidadApar(E, [E|XS], N) :- cantidadApar(E, XS, N1), N is N1+1.
% cantidadApar(E, [Z|XS], N) :- Z \= E, cantidadApar(E, XS, N).

% mayorCA(XS, E) :- member(E, XS), cantidadApar(E, XS, N), not((member(E1, XS), E1 \= E, cantidadApar(E1, XS, N1), N1 > N)).

% File: most_frequent.pl

% Base case: Empty list produces an empty frequency list.
count_elements([], []).

% Count occurrences of the head element in the list, remove all its occurrences, and recurse.
count_elements([H|T], [(H,Count)|FreqList]) :-
    cantidadApar(H, [H|T], Count),
    delete(T, H, NewList),
    count_elements(NewList, FreqList).

cantidadApar(_, [], 0).
cantidadApar(E, [E|XS], N) :- cantidadApar(E, XS, N1), N is N1+1.
cantidadApar(E, [Z|XS], N) :- Z \= E, cantidadApar(E, XS, N).

% Find the element with the maximum count, allowing for multiple solutions.
masRepetidos(List, Element) :-
    count_elements(List, FreqList),
    max_count(FreqList, MaxCount),
    member((Element, MaxCount), FreqList).

% Find the maximum count in the frequency list.
max_count([(_,Count)|T], MaxCount) :-
    max_count(T, Count, MaxCount).

% Base case for finding the maximum count: single element.
max_count([], CurrentMax, CurrentMax).

% If the current count is greater, update the maximum.
max_count([(_,Count)|T], CurrentMax, MaxCount) :-
    Count > CurrentMax,
    max_count(T, Count, MaxCount).

% If the current count is not greater, continue with the current maximum.
max_count([(_,Count)|T], CurrentMax, MaxCount) :-
    Count =< CurrentMax,
    max_count(T, CurrentMax, MaxCount).




% Find the element with the maximum count.
% most_frequent(List, Element) :-
%     count_elements(List, FreqList),
%     max_frequency(FreqList, Element).

% % Base case for max_frequency: single element in the frequency list.
% max_frequency([(Element,_)|[]], Element).

% % If the current element's count is greater, update the maximum.
% max_frequency([(E1,C1), (_,C2)|T], MaxElement) :-
%     C1 > C2,
%     max_frequency([(E1,C1)|T], MaxElement).

% % If the next element's count is greater, move to it.
% max_frequency([(_,C1), (E2,C2)|T], MaxElement) :-
%     C1 < C2,
%     max_frequency([(E2,C2)|T], MaxElement).


% Base case for remove_all: empty list remains empty.
% remove_all(_, [], []).

% % If the element matches the head, skip it.
% remove_all(X, [X|T], Result) :-
%     remove_all(X, T, Result).

% % If the element doesn't match, keep it.
% remove_all(X, [H|T], [H|Result]) :-
%     X \= H,
%     remove_all(X, T, Result).


