% Please insert the names and email addresses of the group members:
%   Ketteniss, Vincent; ketteniss@up-mail.de
%   Carnein, Tom; 

% Set of Facts: 
    % Allowed differences between cordinate pairs in path/4 
    diff(0,1). diff(0,-1). diff(1,0). diff(-1,0).
    % Path length, side length
    plength(L)  :- L =  (M*M)-1, M = #max { N : cell(N,_) }.
    length(M)   :- M = #max { N : cell(N,_) }.
    % Hint count
    hcnt(C)    :- C =  #count { X,Y,N : hint(X,Y,N) }.

% First path (starting from white circle)
    % for x-axis direction
    { path(X,Y,X,Q) } :- first(X,Y), cell(X,Q), diff(0,Y-Q), hint(X,R,_), cell(X,Q'), |Q-R|<|Q'-R|.
    % for y-axis direction
    { path(X,Y,P,Y) } :- first(X,Y), cell(P,Y), diff(X-P,0), hint(R,Y,_), cell(P',Y), |P-R|<|P'-R|.
    
% Generator
    % Generate paths
    { path(X,Y,P,Q) } :- path(_,_,X,Y), cell(P,Q), diff(P-X,Q-Y).
    % Generate path-subsets (= one for each hint)
    { subset(cell(X,Y), N, Id) }   :-  hint(X,Y,N), Id=(X*(L+1) + Y)*(L+1)+N, length(L).
    % Fill sub-sets with paths
    { subset(cell(Q,P), N, Id) }   :-  path(X,Y,Q,P), subset(cell(X,Y), N, Id).

%Testing/Pruning

    % Correct length/count
    :- { path(X,Y,P,Q) } != L , plength(L).
    :- hcnt(C), C != #count { Id : subset(cell(X,Y), N, Id) }.
    %:- hcnt(C), C != #count { Id : bending(B, Id) }.

    % Correct ending (= no path begins with final)
    :- final(X,Y), path(A,B,X,Y), path(X,Y,_,_). 
    % Correct start (= no path ends with first)
    :- first(X,Y), path(A,B,X,Y), path(_,_,X,Y). 

    % Prune if paths intersect between sub-sets
    :-  subset(cell(X,Y), _, Id), subset(cell(X,Y), _, Id'), Id != Id'.
    % Prune incomplete subsets 
    :-  path(X,Y,Q,P), subset(cell(X,Y), _, _), not subset(cell(Q,P), _, _). 

    % Prune path crossings/intersections (= every pair of cordinates in path/4 unique to its side) 
        % All paths start in unique cells 
        :- path(X,_,P,Q), path(X',_,P,Q), X != X'.
        :- path(_,Y,P,Q), path(_,Y',P,Q), Y != Y'.

        % All paths end in unique cells
        :- path(X,Y,P,_), path(X,Y,P',_), P != P'.
        :- path(X,Y,_,Q), path(X,Y,_,Q'), Q != Q'.

    % Prune empty sets
    :-  #count { A,B,C,D : path(A,B,C,D) } = 0.
    :-  #count { Id : subset(cell(X,Y), N, Id) } = 0.
    :-  #count { Id : bending(B, Id) } = 0.

    % Test bending
    bending(B, Id) :- hint(_,_,B).
    %*{ bending(B, Id) } :- 
        subset(cell(X,Y), B, Id) ;
        path(P,Q,X,Y);
        path(X,Y,R,S); 
        B = #sum { 1 :  |P-X| + |X-R| = 1,
                        |Q-Y| + |Y-S| = 1   }.*%
    
    :- N != B, subset(cell(X,Y), N, Id), bending(B, Id). 
    
#show path/4.
#show subset/3.
#show bending/2.