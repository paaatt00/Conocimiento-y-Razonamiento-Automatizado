 ---------------------------- PRÁCTICA 1 CRA ----------------------------

% TABLERO [' ', 1, ' ', 2, ' ', 3, ' ', 4, ' ', 5, ' ', 6, ' ', 7]
 
tablero_prueba([
                ['a', '_', '_', '_', '_', '_', '_'],
                ['b', '_', '_', '_', '_', '_', '_'],
                ['c', '_', '_', '_', '_', '_', '_'],
                ['d', '_', '_', '_', '_', '_', '_'],
                ['e', '_', '_', '_', '_', '_', '_'],
                ['f', '_', '_', '_', '_', '_', '_']
                ]).

% GENERADOR TABLERO

length_list(N, List) :- length(List, N), 
    				 maplist(=('_'), List).

generador_tablero(X, Y, Out):- %X=filas, Y=columnas, Out=tablero
                            length(Out, Y),
                            maplist(length_list(X), Out).

prueba_gen_tablero:-generador_tablero(7,6,Out), imprimir_tablero(Out).

% IMPRIMIR LISTA

imprimir_lista([]).
imprimir_lista([X|Y]):- write(X), write(' '), imprimir_lista(Y). % TODO: no imprime bien dos espacios

prueba_impresion:- imprimir_lista([' ', 1, ' ', 2, ' ', 3, ' ', 4, ' ', 5, ' ', 6, ' ', 7]).

% IMPRIMIR LISTA CON BARRA

imprimir_lista_con_barra([]).
imprimir_lista_con_barra([X|Y]):- write(X), write(' | '),
                                 imprimir_lista_con_barra(Y). 

% GENERADOR GUIONES

generador_lista_guiones(N, Out):- % N = entero, Out = lista de salidatb
                                length(Out, N), % Genera una lista out, tal que su longitud es N
                                maplist(=(-), Out).

prueba_guiones:- generador_lista_guiones(15,Y), imprimir_lista(Y).

% IMPRIMIR TABLERO

imprimir_tablero([]):- nl.
imprimir_tablero([X|L]):- write('| '),
    					imprimir_lista_con_barra(X), nl,
                        generador_lista_guiones(15,L1), imprimir_lista(L1), nl,
                        imprimir_tablero(L).

% IMPRIMIR MESA

imprimir_mesa([]):- nl.
imprimir_mesa([X|L]):- imprimir_lista(X),nl,
    			    generador_lista_guiones(15,L1), imprimir_lista(L1), nl,
    				imprimir_tablero(L).

% ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽

prueba_tablero:- tablero_prueba(Tp), imprimir_mesa(Tp).

% LEER COLUMNA

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

% EXTRAER COLUMNA

extraer_columna(N, Tablero, Col):- extraer_columna_aux(N, Tablero, [], Col).

extraer_columna_aux(_, [], Out, Col):- reverse(Out, Col).
extraer_columna_aux(N, [HeadTab|Cola], Out, Col):- nth1(N, HeadTab, Val),
   								                extraer_columna_aux(N, Cola, [Val|Out], Col).

prueba_extraer:- tablero_prueba(Tp),
    			extraer_columna(1, Tp, Aux), 
    			imprimir_lista(Aux).

% INSERTAR COLUMNA

%insertar_columna(N, Tablero, Col):- insertar_columna_aux(N, Tablero, [], Col).

% TRASPUESTA

traspuesta([[]|_], []).
traspuesta(Matriz, [Fila|Filas]) :- traspuesta_1ra_col(Matriz, Fila, RestMatriz),
                                traspuesta(RestMatriz, Filas).
traspuesta_1ra_col([], [], []).
traspuesta_1ra_col([[H|T]|Filas], [H|Hs], [T|Ts]) :- traspuesta_1ra_col(Filas, Hs, Ts).

prueba_traspuesta:- tablero_prueba(Tp),
                    traspuesta(Tp, Tp2),
                    imprimir_mesa(Tp2),
                    traspuesta(Tp2, Tp3),
                    imprimir_mesa(Tp3).

insertar_ficha(N,Tablero, TableroOut).

% MÉTODO PARA SUSTITUIR EN LA LISTA ARG1 LA POSICIÓN ARG2 POR EL ELEMENTO ARG3, RESULTANDO EN LA LISTA ARG4
sustituir([_|T],1,X,[X|T]).
sustituir([H|T],I,X,[H|R]):-I1 is I-1, sustituir(T,I1,X,R).

% INTRODUCE EN LA COLUMNA Columna DEL TABLERO T EL ELEMENTO J, RESULTANDO EN EL TABLERO T2
introducir(T, Columna, J, T2):- nth1(Columna, T, C), primeraColumna(T, C, J, 6, _, L), sustituir(T, Columna, L, T2).

primeraColumna(T, _, J, I, _, _):- J = mf, I is 0).

primeraColumna(T, _, J, I, _, _):- I is 0, write('Esa columna está llena.\n').
primeraColumna(_, C, J, I, X, L):- nth1(I, C, X), X = ' ', !, (J = mf -> sustituir(C,I,'O',L);sustituir(C,I,J,L)).
primeraColumna(T, C, J, I, X, L):- I1 is I-1, primeraColumna(T, C, J, I1, X, L).

prueba_sustituir:- tablero_prueba(TP),
    			   traspuesta(Tp, Tp2),
    			   introducir(Tp2,2,'x',Tp3),
    			   traspuesta(Tp3,Tp4),
    			   imprimir_mesa(Tp4).

