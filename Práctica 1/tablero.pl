 %---------------------------- PRÁCTICA 1 CRA ----------------------------

% TABLERO [' ', 1, ' ', 2, ' ', 3, ' ', 4, ' ', 5, ' ', 6, ' ', 7]
 
tablero_prueba([
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_']
                ]).

% GENERADOR TABLERO

length_list(N, List):- length(List, N), 
    				 maplist(=('_'), List).

generador_tablero(X, Y, Out):- % X = filas, Y = columnas, Out = tablero
                            length(Out, Y),
                            maplist(length_list(X), Out).

prueba_gen_tablero:-generador_tablero(7,6,Out), imprimir_tablero(Out).

% AA

is_empty(List):- not(member(_,List)).

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
imprimir_mesa(T):- imprimir_lista([' ', 1, ' ', 2, ' ', 3, ' ', 4, ' ', 5, ' ', 6, ' ', 7]), nl,
    			generador_lista_guiones(15,L1), imprimir_lista(L1), nl,
    			imprimir_tablero(T).

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

% TRASPUESTA

traspuesta([[]|_], []).
traspuesta(Matriz, [Fila|Filas]):- traspuesta_1ra_col(Matriz, Fila, RestMatriz),
                                traspuesta(RestMatriz, Filas).
traspuesta_1ra_col([], [], []).
traspuesta_1ra_col([[H|T]|Filas], [H|Hs], [T|Ts]):- traspuesta_1ra_col(Filas, Hs, Ts).

prueba_traspuesta:- tablero_prueba(Tp),
                    traspuesta(Tp, Tp2),
                    imprimir_mesa(Tp2),
                    traspuesta(Tp2, Tp3),
                    imprimir_mesa(Tp3).

% EXTRAER COLUMNA

extraer_columna(N, Tablero, Col):- extraer_columna_aux(N, Tablero, [], Col).

extraer_columna_aux(_, [], Out, Col):- reverse(Out, Col).
extraer_columna_aux(N, [Cabecera|Cola], Out, Col):- nth1(N, Cabecera, Val),
   								                    extraer_columna_aux(N, Cola, [Val|Out], Col).

prueba_extraer:- tablero_prueba(Tp),
    			extraer_columna(1, Tp, Aux), 
    			imprimir_lista(Aux).

% INSERTAR FICHA

introducir_ficha(Col, F, Col2):- introducir_ficha_aux(Col, F, [], Col2).

introducir_ficha_aux([], _, Out, Col2):- reverse(Out, Col2).
introducir_ficha_aux([Cabecera|Cola], F, Out, Col2):- (
                                                    Cabecera == '_',
                                                    is_empty(Cola) -> introducir_ficha_aux(Cola, F, [F|Out], Col2)
                                                ;
                                                    is_empty(Cola) -> introducir_ficha_aux(Cola, F, [Cabecera|Out], Col2)
                                                ;
                                                    nth1(1, Cola, Siguiente),
                                                    (
                                                        Cabecera == '_',
                                                        Siguiente \= '_' -> introducir_ficha_aux(Cola, F, [F|Out], Col2)
                                                    ;   
                                                        Cabecera == '_',
                                                        Siguiente == '_' -> introducir_ficha_aux(Cola, F, [Cabecera|Out], Col2)
                                                    ;   
                                                        Cabecera \= '_' -> introducir_ficha_aux(Cola, F, [Cabecera|Out], Col2)   
                                                    )
                                                ).

prueba_introducir_ficha:- tablero_prueba(Tp),
                    traspuesta(Tp, Tp2),
                    extraer_columna(1, Tp, Aux), 
                    introducir(Aux, 'X', Aux1),
                    imprimir_lista(Aux1).

% INTRODUCIR COLUMNA

introducir_col(N, Tablero, Col):- introducir_col_aux(N, Tablero, [], Col).

introducir_col_aux(_, Tablero, [], Col):- 



% INSERTAR COLUMNA

% insertar_columna(N, Tablero, Col):- insertar_columna_aux(N, Tablero, [], Col).



