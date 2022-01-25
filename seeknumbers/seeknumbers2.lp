% Set of Facts: Allowed differences between cordinate pairs in path/4 
diff(0,1). diff(0,-1). diff(1,0). diff(-1,0).

% First path (starting from white circle)

    % for x-axis direction
    {path(X,Y,X,Q)} :- first(X,Y), cell(X,Q), diff(0,Y-Q), hint(X,R,_), cell(X,Q'), |Q-R|<|Q'-R|.
    % for y-axis direction
    {path(X,Y,P,Y)} :- first(X,Y), cell(P,Y), diff(X-P,0), hint(R,Y,_), cell(P',Y), |P-R|<|P'-R|.
    
% Generator
length(L) :- L = (N*N)-1, N = #max { M : cell(_,M) }.
{ path(X,Y,P,Q) } :- path(_,_,X,Y), cell(P,Q), diff(P-X,Q-Y).
:- { path(X,Y,P,Q) } != L , length(L).
:- final(A,B), path(A,B,_,_).
:- final(X,Y), not path(_,_,X,Y).


% Prune empty set
:- #count { A,B,C,D : path(A,B,C,D) } = 0.

% Testing for path crossings/intersections (= every pair of cordinates in path/4 unique to its side)
    
    % All pairs of ending cordinates unique
    :- path(X,_,P,Q), path(X',_,P,Q), X != X'.
    :- path(_,Y,P,Q), path(_,Y',P,Q), Y != Y'.
    
    % All pairs of starting cordinates unique
    :- path(X,Y,P,_), path(X,Y,P',_), P != P'.
    :- path(X,Y,_,Q), path(X,Y,_,Q'), Q != Q'.


subpath(cell(A,B), ID, N, 0) :- 
    hint(A,B,N),
    ID=(A*(L+1) + B)*(L+1), 
    length(L).

subpath(cell(X,Y), ID, N, 1) :- 
    subpath(cell(A,B), ID, N, 0),
    path(A,B,X,Y).


subpath(cell(P,Q), ID, N, M) :-
    M=2..L, length(L),
    subpath(cell(A,B), ID, _, M-2),
    subpath(cell(X,Y), ID, N, M-1),
    not hint(X,Y,_),
    path(A,B,X,Y),
    path(X,Y,P,Q),
    (|A-X|,|B-Y|) == (|X-P|,|Y-Q|).


subpath(cell(P,Q), ID, N-1, M) :-
    M=2..L, length(L),
    subpath(cell(A,B), ID, _, M-2),
    subpath(cell(X,Y), ID, N, M-1),
    not hint(X,Y,_),
    path(A,B,X,Y),
    path(X,Y,P,Q),
    (|A-X|,|B-Y|) != (|X-P|,|Y-Q|).




#show path/4.
#show subpath/4.