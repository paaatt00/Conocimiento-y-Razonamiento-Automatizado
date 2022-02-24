% ---------------------------- PRÁCTICA 1 CRA ----------------------------

% pintar un tablero pocho

tablero_prueba([[1,2,3,4,5,6,7],
                [0,0,0,0,0,0,0]]).

escribir_lista([]).
escribir_lista([X|Y]):- write(X),write(' '), escribir_lista(Y). % escribir_lista([1,' ',2,' ',3,' ',4,' ',5,' ',6,' ',7])

escribir_lista_con_barra([]).
escribir_lista_con_barra([X|Y]):- write(X), write('|'), escribir_lista_con_barra(Y). % escribir_lista_con_barra([1,' ',2,' ',3,' ',4,' ',5,' ',6,' ',7]).


lista_repe(N, Out) :-
   length(Out, N),
   maplist(=(-), Out).
                      
escribir_tablero([]):- nl.
escribir_tablero([X|L]):- escribir_lista(X), nl,
                          lista_repe(15,L1), escribir_lista(L1), nl,
                          escribir_tablero(L).


prueba1:- lista_repe(15,Y),escribir_lista(Y).

prueba2:- escribir_lista([1,2,3,4,5,6,7]).

prueba3:- tablero_prueba(Tp), escribir_tablero(Tp).

s