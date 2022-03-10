a(0,1). a(0,2). a(0,3).
b(0,4). b(0,5). b(0,6).
c(0,7). c(0,8). c(0,9).
%d(0,10). d(0,11). d(0,12).
%e(0,13). e(0,14). e(0,15).

%counter(A,B) :- A = X*Y, B=P**Q, a(_,X), a(_,X), a(_,Y), a(_,P), a(_,Q), c(0,A), c(0,B).
%counter(A,B) :- A = X*Y, B=X**Y, a(_,X), a(_,Y), c(0,B).
%test(A,0) :- A = #count{ X,Y : counter(X,Y) } .

%#show test/2.
%#show counter/2.

d(5,6) :- a(X,Y).
d(1,2); e(4,3) :- a(X,Y).

#show d/2.
#show e/2.