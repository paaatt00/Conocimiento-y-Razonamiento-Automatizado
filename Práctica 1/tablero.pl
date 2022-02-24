% ---------------------------- PRÁCTICA 1 CRA ----------------------------

% pintar un tablero pocho

escribir_lista([]).
escribir_lista([X|Y]):- write(X),write(''), escribir_lista(Y). % escribir_lista([1,' ',2,' ',3,' ',4,' ',5,' ',6,' ',7])

escribir_lista_con_barra([]).
escribir_lista_con_barra([X|Y]):- write(X), write('|'), escribir_lista_con_barra(Y). % escribir_lista_con_barra([1,' ',2,' ',3,' ',4,' ',5,' ',6,' ',7]).

lista_repe(1,X,[X]).
lista_repe(N,X,[X|L]):-
                      N1 is N-1,
                      lista_repe(N1,X,L).
                      
escribir_tablero([]):- nl.
escribir_tablero([X|L]):- escribir_lista(X), nl,
                          lista_repe(15,'-',L1), escribir_lista(L1) nl,
                          escribir_tablero(L).
                          
prueba1:- lista_repe(15,'-',L1), escribir_lista(L1).

prueba2:- escribir_lista([1,2,3,4,5,6,7]).

prueba3:-

