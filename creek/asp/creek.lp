% INSERT NAMES AND EMAIL ADDRESSES OF YOUR GROUP MEMBERS:
%
%

% gringo ./instances/ex01.lp creek.lp | clasp 0
%* 
cell(1..3,1..4).

hint(0,2,1).
hint(2,1,0).
hint(2,3,4).
*%

plus(0,0). plus(0,1). plus(1,0). plus(1,1).

% Your implementation please...
{ black(X,Y) } = 1 :- cell(X,Y).
:-  .

#show black/2.
