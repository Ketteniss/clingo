% INSERT NAMES AND EMAIL ADDRESSES OF YOUR GROUP MEMBERS:
% Ketteniss, Vincent; vincent.ketteniss@uni-potsdam.de
% Carnein, Tom; tom.carnein@uni-potsdam.de

% C:\Users\Default.DESKTOP-SBK9Q3H\OneDrive\VSC\clingo\creek\asp>clingo ./instances/ex01.lp creek.lp 0

%*
1.  ->  it must be possible to get from any white cell 
        to any other white cell by moving only horizontally 
        and vertically (never diagonally!), and without 
        having to cross a black cell.

2.  ->  A number in a circle indicates how 
        many of the 4 adjacent cells must be blackened.
*%

plus(0,0). plus(0,1). plus(1,0). plus(1,1).

% Your implementation please...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          Generator            %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % START %
{ black(X,Y) } :- cell(X,Y).
            %  END  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       WHITE without orthogonal WHITE neighbour     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        % START %
    % Conditions: Inner cells 
:-  cell(A,B), not black(A,B), W > 1, 
    W = #count { P,Q : not black(P,Q), cell(P,Q) },
    A != #min { X : cell(X,_) }, 
    A != #max { X : cell(X,_) }, 
    B != #min { Y : cell(_,Y) }, 
    B != #max { Y : cell(_,Y) }, 
    black(A+1,B), black(A-1,B), black(A,B+1), black(A,B-1).

    % Conditions: Leftmost cells on x-axis (excl. corners) 
:-  cell(A,B), not black(A,B), W > 1, 
    W = #count { P,Q : not black(P,Q), cell(P,Q) },
    A = #min { X : cell(X,_) }, 
    B != #min { Y : cell(_,Y) }, 
    B != #max { Y : cell(_,Y) }, 
    black(A+1,B), black(A,B+1), black(A,B-1).

    % Conditions: Rightmost cells on x-axis (excl. corners) 
:-  cell(A,B), not black(A,B), W > 1, 
    W = #count { P,Q : not black(P,Q), cell(P,Q) },
    A = #max { X : cell(X,_) }, 
    B != #min { Y : cell(_,Y) }, 
    B != #max { Y : cell(_,Y) }, 
    black(A-1,B), black(A,B+1), black(A,B-1).
    
    % Conditions: Upper left corner
:-  cell(A,B), not black(A,B), W > 1, 
    W = #count { P,Q : not black(P,Q), cell(P,Q) },
    A = #min { X : cell(X,_) }, 
    B = #min { Y : cell(_,Y) }, 
    black(A+1,B), black(A,B+1).
    
        % Conditions: Upper right corner
:-  cell(A,B), not black(A,B), W > 1, 
    W = #count { P,Q : not black(P,Q), cell(P,Q) },
    A = #max { X : cell(X,_) }, 
    B = #min { Y : cell(_,Y) }, 
   black(A-1,B), black(A,B+1).

    % Conditions: Lower left corner
:-  cell(A,B), not black(A,B), W > 1, 
    W = #count { P,Q : not black(P,Q), cell(P,Q) },
    A = #min { X : cell(X,_) }, 
    B = #max { Y : cell(_,Y) }, 
    black(A+1,B), black(A,B-1).

    % Conditions: Lower right corner
:-  cell(A,B), not black(A,B), W > 1, 
    W = #count { P,Q : not black(P,Q), cell(P,Q) },
    A = #max { X : cell(X,_) }, 
    B = #max { Y : cell(_,Y) }, 
    black(A-1,B), black(A,B-1) .
                        % END %              
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       WHITE without orthogonal WHITE neighbour     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Surrounding BLACK not equal to hint value    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %% START %%
:- hint(X,Y,N), N != C,
    C = #count { P,Q :  black(P,Q), 
                        plus(DX,DY), 
                        P = X+DX, 
                        Q = Y+DY 
                }.
    	        %% END %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       Surrounding BLACK not equal to hint value    %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       MULTIPLE GROUPS OF ORTHG. WHITES             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %% START %%

diff(0,1). diff(0,-1). diff(1,0). diff(-1,0).

NO_GROUP(A,B) :- cell(A,B), not black(A,B).

{ GROUP(A,B); GROUP(P,Q) } :- 
    NO_GROUP(A,B),
    NO_GROUP(P,Q),
    P = A+DX,
    Q = B+DY,
    diff(DX,DY)
    .
:- cell(A,B) not black(A,B), NO_GROUP(A,B), GROUP(A,B).

    	        %% END %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%       MULTIPLE GROUPS OF ORTHG. WHITES             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                
#show black/2.

% Nur für debugging
%*
c(X,Y,C,N) :- hint(X,Y,N), N != C, 
        C = #count { P,Q :  
            plus(DX,DY),
            black(P,Q), 
            P = X+DX, 
            Q = Y+DY 
        }.  
b(X,Y,B,N) :- hint(X,Y, N),
        B = #count { P,Q : 
            plus(DX,DY),
            black(P,Q), 
            P = X+DX, 
            Q = Y+DY 
        }.
*%
%#show b/4.
%#show c/4.