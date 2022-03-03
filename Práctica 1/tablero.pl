% ---------------------------- PRÁCTICA 1 CRA ----------------------------

% pintar un tablero pocho

tablero_prueba([[' ', 1, ' ', 2, ' ', 3, ' ', 4, ' ', 5, ' ', 6, ' ', 7],
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_']
                ]).

length_list(N, List) :- length(List, N), 
    				 maplist(=('_'), List).

generador_tablero(X, Y, Out):- %X=filas, Y=columnas, Out=tablero
                            length(Out, Y),
                            maplist(length_list(X), Out).

prueba_gen_tablero:-generador_tablero(7,6,Out), imprimir_tablero(Out).

imprimir_lista([]).
imprimir_lista([X|Y]):- write(X), write(' '), imprimir_lista(Y). % TODO: no imprime bien dos espacios

prueba_impresion:- imprimir_lista([' ', 1, ' ', 2, ' ', 3, ' ', 4, ' ', 5, ' ', 6, ' ', 7]).


imprimir_lista_con_barra([]).
imprimir_lista_con_barra([X|Y]):- write(X), write(' | '),
                                 imprimir_lista_con_barra(Y). 


generador_lista_guiones(N, Out):- % N = entero, Out = lista de salida
                                length(Out, N), % Genera una lista out, tal que su longitud es N
                                maplist(=(-), Out).

prueba_guiones:- generador_lista_guiones(15,Y), imprimir_lista(Y).

imprimir_tablero([]):- nl.
imprimir_tablero([X|L]):- write('| '),
    					imprimir_lista_con_barra(X), nl,
                        generador_lista_guiones(15,L1), imprimir_lista(L1), nl,
                        imprimir_tablero(L).

imprimir_mesa([]):- nl.
imprimir_mesa([X|L]):- imprimir_lista(X),nl,
    			    generador_lista_guiones(15,L1), imprimir_lista(L1), nl,
    				imprimir_tablero(L).

prueba_tablero:- tablero_prueba(Tp), imprimir_mesa(Tp).

leer_columna(X):- write('Introduzca el numero de columna en el que quiere meter su ficha:'),
    			read(Y),
    			(   Y \= 1,
      				Y \= 2,
                    Y \= 3,
                    Y \= 4,
                    Y \= 5,
                    Y \= 6,
                    Y \= 7 ->  write('Respuesta inválida, conteste nuevamente.'), nl, 
       				leer_columna(X);
                    X = Y
   				).

prueba_leer:- leer_columna(X), write(X).



columnai(N,Tablero,Col):- columnai_aux(N,Tablero,[],Col).

columnai_aux(_, [], Out, Col):- reverse(Out,Col).
columnai_aux(N, [HeadTab|Cola], Out, Col):- nth1(N, HeadTab, Val),
   								 columnai_aux(N, Cola, [Val|Out], Col).

prueba_extraer:- tablero_prueba(Tp),
    			columnai(1,Tp,Aux), 
    			imprimir_lista(Aux).















