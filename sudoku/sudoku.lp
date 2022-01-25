initial(5,1,9).
initial(6,2,4).
initial(6,1,5).
initial(7,1,4).
initial(7,2,5).
initial(8,2,7).
initial(8,1,8).
initial(9,2,3).
initial(9,1,6).
initial(1,3,4).
initial(2,3,8).
initial(3,3,5).
initial(4,3,3).
initial(5,3,6).
initial(6,3,7).
initial(7,3,2).
initial(8,3,1).
initial(9,3,9).
initial(1,4,5).
initial(2,4,7).
initial(3,4,8).
initial(4,4,9).
initial(5,4,3).
initial(6,4,1).
initial(7,4,6).
initial(8,4,4).
initial(9,4,2).
initial(1,5,2).
initial(2,5,3).
initial(3,5,6).
initial(4,5,7).
initial(5,5,4).
initial(6,5,8).
initial(7,5,1).
initial(8,5,9).
initial(9,5,5).
initial(1,6,9).
initial(2,6,1).
initial(3,6,4).
initial(4,6,2).
initial(5,6,5).
initial(6,6,6).
initial(7,6,7).
initial(8,6,3).
initial(9,6,8).
initial(1,7,3).
initial(2,7,9).
initial(3,7,7).
initial(4,7,6).
initial(5,7,1).
initial(6,7,2).

val(1..9).
subgrid_size(3).

sudoku(X,Y,N)  :- initial(X,Y,N).
1{ sudoku(X,Y,N) : N = 1..9 }1 :- X=1..9, Y=1..9.

% Feld definieren
:- S = #count { X,Y,N : sudoku(X,Y,N) }, S != K*K*K*K, subgrid_size(K).

% Jede Zelle nur maximal eine Belegung:
:- sudoku(X,Y,N), sudoku(X,Y,N'), N != N'. 

% Eindeutige Wertevergabe in Reihe:
:- sudoku(X,Y,N), sudoku(X',Y,N), X != X'.

% Eindeutige Wertevergabe in Spalte:
:- sudoku(X,Y,N), sudoku(X,Y',N), Y!= Y'.

% Eindeutige Wertevergabe im Subgrid
:-  sudoku(X,Y,N), sudoku(X',Y',N),
    g = (((X-1)/S)*S + (Y-1)/S), g' = (((X'-1)/S)*S + (Y'-1)/S), g == g', 
    subgrid_size(S).




#show sudoku/3.