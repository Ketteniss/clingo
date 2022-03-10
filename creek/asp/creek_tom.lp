plus(0,0). plus(0,1). plus(1,0). plus(1,1).
diff(0,1). diff(0,-1). diff(1,0). diff(-1,0).

{ black(X+DX,Y+DY) : plus(DX,DY), hint(X,Y,N), cell(X+DX,Y+DY) }.
{ black(X,Y) } :- cell(X,Y).

:- hint(A,B,N), C = #count { X,Y : black(X,Y), plus(DX,DY), X=A+DX, Y=B+DY }, C!=N.

#show black/2.