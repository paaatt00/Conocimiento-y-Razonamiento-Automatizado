% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 1 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% __________________________ archivo de pruebas ________________________________________ %

% GENERADOR TABLERO

length_list(N, List):- length(List, N),
            maplist(=('_'), List).

generador_tablero(Y, X, Out):- % Y = filas, X = columnas, Out = tablero
                            length(Out, Y),
                            maplist(length_list(X), Out).

% GENERADOR Nº COLUMNA VÁLIDOS

gen_lista_columnas(1, [1]).
gen_lista_columnas(Columna, [Columna|Cola]) :- Columna > 1,
                                            Columna2 is Columna-1,
                                            gen_lista_columnas(Columna2, Cola).

% GENERADOR GUIONES

generador_lista_guiones(N, Out):- % N = entero, Out = lista de salidatb
                                length(Out, N), % Genera una lista out, tal que su longitud es N
                                maplist(=(-), Out).

% ______________________________________________________________________________________%

% LISTA VACÍA

is_empty(List):- not(member(_, List)).

% ______________________________________________________________________________________%

% IMPRIMIR LISTA

imprimir_lista([]).
imprimir_lista([X|Y]):- write(X), write(' '), imprimir_lista(Y). % TODO: no imprime bien dos espacios

% IMPRIMIR LISTA CON BARRA

imprimir_lista_con_barra([]).
imprimir_lista_con_barra([X|Y]):- write(X), write(' | '),
                                imprimir_lista_con_barra(Y).
%Imprimir lista con espaciones
imprimir_lista_espacios([]).
imprimir_lista_espacios([X|Y]):- write(' '), write(X), write(' '), imprimir_lista_espacios(Y).

% IMPRIMIR TABLERO

imprimir_tablero([]):- nl.
imprimir_tablero([X|L]):- write('| '),
              imprimir_lista_con_barra(X), nl,
                        generador_lista_guiones(15,L1), imprimir_lista(L1), nl,
                        imprimir_tablero(L).

% IMPRIMIR MESA

imprimir_mesa([]):- nl.
imprimir_mesa(T,Lista_columnas):- imprimir_lista_espacios(Lista_columnas), nl,
          generador_lista_guiones(15, L1), imprimir_lista(L1), nl,
          imprimir_tablero(T).

% ______________________________________________________________________________________%

% EXTRAER FILA

extraer_fila(N, Tablero, Fila):- nth1(N, Tablero, Fila).

% EXTRAER COLUMNA

extraer_columna(N, Tablero, Col):- extraer_columna_aux(N, Tablero, [], Col).

extraer_columna_aux(_, [], Out, Col):- reverse(Out, Col).
extraer_columna_aux(N, [Cabecera|Cola], Out, Col):- nth1(N, Cabecera, Val),
                                      extraer_columna_aux(N, Cola, [Val|Out], Col).

% EXTRAER POSICIÓN

extraer_posicion(Y, X, Tablero, Elem):- extraer_fila(Y, Tablero, Fila),
                                        nth1(X, Fila, Elem).

% ______________________________________________________________________________________%

% COMPROBAR SI UNA COLUMNA ESTÁ LLENA

columna_llena(X, Tablero):- extraer_posicion(1, X, Tablero, Elem),
                            (Elem \= '_') -> true.

% LEER COLUMNA

leer_columna(X, Lista_columnas, Tablero):- write('Introduzca el numero de columna en el que quiere meter su ficha:'), nl,
                                        read(Y),
                                        (
                                            not(member(Y, Lista_columnas)) ->  write('Columna fuera de rango, conteste nuevamente.'), nl,
                                            leer_columna(X, Lista_columnas, Tablero)
                                        ;
                                            columna_llena(Y, Tablero) -> write('Columna llena, conteste nuevamente.'), nl,
                                            leer_columna(X, Lista_columnas, Tablero)
                                        ;
                                            X = Y
                                        ).

% TRASPUESTA

traspuesta([[]|_], []).
traspuesta(Matriz, [Fila|Filas]):- traspuesta_1ra_col(Matriz, Fila, RestMatriz),
                                traspuesta(RestMatriz, Filas).

traspuesta_1ra_col([], [], []).
traspuesta_1ra_col([[H|T]|Filas], [H|Hs], [T|Ts]):- traspuesta_1ra_col(Filas, Hs, Ts).

% ______________________________________________________________________________________%

% INSERTAR FICHA

introducir_ficha(Col, F, Col2):- introducir_ficha_aux(Col, F, [], Col2).

introducir_ficha_aux([], _, Out, Col2):- reverse(Out, Col2).
introducir_ficha_aux([Cabecera|Cola], F, Out, Col2):- (
                                                        Cabecera == '_', is_empty(Cola) -> introducir_ficha_aux(Cola, F, [F|Out], Col2)
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
% ______________________________________________________________________________________%

% INTRODUCIR COLUMNA

introducir_col(Col, Tablero_in, N, Tablero_out):- traspuesta(Tablero_in, Tablero2),
                                            introducir_col_aux(Tablero2, Col, N, 1, Tablero_aux, []),
                        traspuesta(Tablero_aux, Tablero_out).

introducir_col_aux([],_, _, _, Tablero_out, Tablero_acumulado):- reverse(Tablero_acumulado, Tablero_out).
introducir_col_aux([Fila|Resto], Col, N, Contador, Tablero_out, Tablero_acumulado):- (
                                                                                        N == Contador -> Contador2 is Contador+1,
                                                                                        introducir_col_aux(Resto, Col, N, Contador2, Tablero_out, [Col|Tablero_acumulado])
                                                                                    ;
                                                                                        N \= Contador->Contador2 is Contador+1,
                                                                                        introducir_col_aux(Resto, Col, N, Contador2, Tablero_out, [Fila|Tablero_acumulado])
                                                                                    ).

% COMPROBAR FILA

comprobar_fila([], _, _):- false.
comprobar_fila([Actual|Resto_fila], Anterior, Contador):- % imprimir_lista([Actual|Resto_fila]), write(Contador), nl,
                                                        (
                                                            Actual == Anterior, Actual \= '_' -> Contador2 is Contador+1, % si acutal es igual al anterior y distinto de _, es decir, si hay ficha repetida, aumentamos el contador
                                                            (
                                                                Contador2 == 4 -> true % si el contador llega a 4, alguien gana
                                                            ;
                                                                Contador2 =< 4 -> comprobar_fila(Resto_fila, Actual, Contador2) % si no es 4, seguimos buscando
                                                            )
                                                        ;
                                                            (Actual \= Anterior ; Actual == '_') -> Contador2 is 1, comprobar_fila(Resto_fila, Actual, Contador2) %caso general, si no hay dos casillas iguales seguidas O la casilla está vacia, reiniciamos el contador
                                                            % |______________________________|<- esto es un Or, creo que es feo pero funciona
                                                        ).

% diagonal tipo \
comprobar_diagonal1(X, Tablero):- append(_, [C1,C2,C3,C4|_], Tablero), 
                                append(I1, [X|_], C1), 
                                append(I2, [X|_], C2),
                                append(I3, [X|_], C3),
                                append(I4, [X|_], C4),
                                length(I1, M1), length(I2, M2), length(I3, M3), length(I4, M4),
                                M2 is M1+1, M3 is M2+1, M4 is M3+1.

% diagonal tipo / 
comprobar_diagonal2(X, Tablero):- append(_, [C1,C2,C3,C4|_], Tablero),
                                append(I1, [X|_], C1),
                                append(I2, [X|_], C2),
                                append(I3, [X|_], C3),
                                append(I4, [X|_], C4),
                                length(I1, M1), length(I2, M2), length(I3, M3), length(I4, M4),
                                M2 is M1-1, M3 is M2-1, M4 is M3-1.

% RESPUESTA_ALEATORIA: función que escoge una columna aleatoria para la máquina.

respuesta_aleatoria(Lista_columnas, Tablero, Col_rand):- random_member(Col, Lista_columnas),
                                                        (
                                                            columna_llena(Col, Tablero) -> respuesta_aleatoria(Lista_columnas, Tablero, Col_rand)  
                                                        ;
                                                            Col_rand = Col
                                                        ).                                                       

% COMPROBAR VICTORIA: comprobar si algún jugador ha ganado la partida

comprobar_victoria(Jugador, Tablero):- comprobar_diagonal1(Jugador, Tablero);
                            comprobar_diagonal2(Jugador, Tablero);
                            comprobar_victoria_aux(Tablero); % comprueba filas
                            traspuesta(Tablero, TableroTras),
                            comprobar_victoria_aux(TableroTras). % comprueba Columnas

comprobar_victoria_aux([]):- false.
comprobar_victoria_aux([Fila|Resto]):- comprobar_fila(Fila, '_', 1); comprobar_victoria_aux(Resto). % se pone OR para que devuelva true en caso de que encuentre victoria y no recorra los demas


% JUGAR (JUGADOR CONTRA JUGADOR)

jugar:- write('Introduzca el modo de juego deseado: '), nl,
        write('     1. Jugador contra jugador'), nl,
        write('     2. Jugador contra maquina tonta'), nl,
        write('     3. Jugador contra maquina menos tonta'), nl,
        write('     4. Visualizar partida (tienes que ser publico enloquecido)'), nl,
        write('        Estrategia simple -> jugardor x'), nl,
        write('        Estrategia avanzada -> jugador o'), nl,
        read(Modo_juego),
        write('Introduzca el numero de filas con las que quiere jugar: '), nl,
        read(Filas),
        write('Introduzca el numero de columnas con las que quiere jugar: '), nl,
        read(Columnas),
        generador_tablero(Filas, Columnas, Tablero),
        imprimir_mesa(Tablero,Lista_columnas), nl,
        gen_lista_columnas(Columnas, Lista_columnas),
        (
            Modo_juego == 1 -> jugando_JcJ(Tablero, Lista_columnas, 'x')
        ;
            Modo_juego == 2 -> jugando_maquina_simple(Tablero, Lista_columnas, 'x')
        ;
            Modo_juego == 3 -> jugando_maquina_avanzada(Tablero, Lista_columnas, 'x')
        ;
            Modo_juego == 4 -> jugando_maquinaVSmaquina(Tablero, Lista_columnas, 'x')
        ).