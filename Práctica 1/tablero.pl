% ______________________________________________________________________________________%
% ___________________________PRÁCTICA 1 - CRA___________________________________________%
% ______________________________________________________________________________________%

% TABLERO [' ', 1, ' ', 2, ' ', 3, ' ', 4, ' ', 5, ' ', 6, ' ', 7]

tablero_prueba([
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', 'x', '_', '_', '_'],
                ['_', '_', 'x', '_', 'x', '_', '_'],
                ['_', 'x', '_', '_', '_', 'x', '_'],
                ['x', '_', '_', '_', '_', '_', 'x']
                ]).

% ______________________________________________________________________________________%

% GENERADOR TABLERO

length_list(N, List):- length(List, N),
            maplist(=('_'), List).

generador_tablero(Y, X, Out):- % Y = filas, X = columnas, Out = tablero
                            length(Out, Y),
                            maplist(length_list(X), Out).

% prueba_gen_tablero:- generador_tablero(7, 6, Out),
%                     imprimir_tablero(Out).

% GENERADOR Nº COLUMNA VÁLIDOS

gen_lista_columnas(1, [1]).
gen_lista_columnas(Columna, [Columna|Cola]) :- Columna > 1,
                                            Columna2 is Columna-1,
                                            gen_lista_columnas(Columna2, Cola).

% GENERADOR GUIONES

generador_lista_guiones(N, Out):- % N = entero, Out = lista de salidatb
                                length(Out, N), % Genera una lista out, tal que su longitud es N
                                maplist(=(-), Out).

prueba_guiones:- generador_lista_guiones(15,Y), imprimir_lista(Y).

% ______________________________________________________________________________________%

% LISTA VACÍA

is_empty(List):- not(member(_, List)).

% ______________________________________________________________________________________%

% IMPRIMIR LISTA

imprimir_lista([]).
imprimir_lista([X|Y]):- write(X), write(' '), imprimir_lista(Y). % TODO: no imprime bien dos espacios

prueba_impresion:- imprimir_lista([' ', 1, ' ', 2, ' ', 3, ' ', 4, ' ', 5, ' ', 6, ' ', 7]).

% IMPRIMIR LISTA CON BARRA

imprimir_lista_con_barra([]).
imprimir_lista_con_barra([X|Y]):- write(X), write(' | '),
                                imprimir_lista_con_barra(Y).

% IMPRIMIR TABLERO

imprimir_tablero([]):- nl.
imprimir_tablero([X|L]):- write('| '),
              imprimir_lista_con_barra(X), nl,
                        generador_lista_guiones(15,L1), imprimir_lista(L1), nl,
                        imprimir_tablero(L).

% IMPRIMIR MESA

imprimir_mesa([]):- nl.
imprimir_mesa(T):- imprimir_lista([' ', 1, ' ', 2, ' ', 3, ' ', 4, ' ', 5, ' ', 6, ' ', 7]), nl,
          generador_lista_guiones(15, L1), imprimir_lista(L1), nl,
          imprimir_tablero(T).

% ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽

prueba_tablero:- tablero_prueba(Tp), imprimir_mesa(Tp).

% ______________________________________________________________________________________%

% EXTRAER FILA

extraer_fila(N, Tablero, Fila):- nth1(N, Tablero, Fila).

prueba_extraer_fila:- tablero_prueba(Tp),
                    extraer_fila(1, Tp, Fila),
                    imprimir_lista(Fila).

% EXTRAER COLUMNA

extraer_columna(N, Tablero, Col):- extraer_columna_aux(N, Tablero, [], Col).

extraer_columna_aux(_, [], Out, Col):- reverse(Out, Col).
extraer_columna_aux(N, [Cabecera|Cola], Out, Col):- nth1(N, Cabecera, Val),
                                      extraer_columna_aux(N, Cola, [Val|Out], Col).

% prueba_extraer:- tablero_prueba(Tp),
%           extraer_columna(1, Tp, Aux),
%           imprimir_lista(Aux).

% EXTRAER POSICIÓN

extraer_posicion(Y, X, Tablero, Elem):- extraer_fila(Y, Tablero, Fila),
                                        nth1(X, Fila, Elem).

prueba_extraer_posicion:- tablero_prueba(Tp),
                         extraer_posicion(1, 3, Tp, Elem),
                         write(Elem).

% ______________________________________________________________________________________%

% COMPROBAR SI UNA COLUMNA ESTÁ LLENA

columna_llena(X, Tablero):- extraer_posicion(1, X, Tablero, Elem),
                            (Elem \= '_') -> write('Columna llena').

% LEER COLUMNA

leer_columna(X, Lista_columnas, Tablero):- write('Introduzca el numero de columna en el que quiere meter su ficha:'), nl,
                                        read(Y),
                                        (
                                            not(member(Y, Lista_columnas)) ->  write('Columna fuera de rango, conteste nuevamente.'), nl,
                                            leer_columna(X, Lista_columnas, Tablero)
                                        ;
                                            columna_llena(Y, Tablero) -> write(', conteste nuevamente.'), nl,
                                            leer_columna(X, Lista_columnas, Tablero)
                                        ;
                                            X = Y
                                        ).

% prueba_leer:- gen_lista_columnas(7, Lista_columnas),
%             leer_columna(X, Lista_columnas),
%             write(X).

% TRASPUESTA

traspuesta([[]|_], []).
traspuesta(Matriz, [Fila|Filas]):- traspuesta_1ra_col(Matriz, Fila, RestMatriz),
                                traspuesta(RestMatriz, Filas).

traspuesta_1ra_col([], [], []).
traspuesta_1ra_col([[H|T]|Filas], [H|Hs], [T|Ts]):- traspuesta_1ra_col(Filas, Hs, Ts).

% prueba_traspuesta:- tablero_prueba(Tp),
%                     traspuesta(Tp, Tp2),
%                     imprimir_mesa(Tp2),
%                     traspuesta(Tp2, Tp3),
%                     imprimir_mesa(Tp3).

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

prueba_introducir_ficha:- tablero_prueba(Tp),
                        traspuesta(Tp, Tp2),
                        extraer_columna(1, Tp2, Aux),
                        introducir(Aux, 'X', Aux1),
                        imprimir_lista(Aux1).

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
prueba_introducir_col:- tablero_prueba(Tp),
              %imprimir_mesa(Tp),nl,
              introducir_col(['o', 'x', 'o', 'x', 'x', 'o'],Tp, 3, TOut),
              imprimir_mesa(TOut).

% COMPROBAR FILA

comprobar_fila([], _, _):- false.
comprobar_fila([Actual|Resto_fila], Anterior, Contador):- % imprimir_lista([Actual|Resto_fila]), write(Contador), nl,
                                                        (
                                                            Actual == Anterior, Actual \= '_' -> Contador2 is Contador+1, % si acutal es igual al anterior y distinto de _, es decir, si hay ficha repetida, aumentamos el contador
                                                            (
                                                                Contador2 == 4 ->  write('              ██╗░░░██╗██╗░█████╗░████████╗░█████╗░██████╗░██╗░█████╗░'), nl, % si el contador llega a 4, alguien gana
                                                                                   write('              ██║░░░██║██║██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██║██╔══██╗'), nl,
                                                                                   write('              ╚██╗░██╔╝██║██║░░╚═╝░░░██║░░░██║░░██║██████╔╝██║███████║'), nl,
                                                                                   write('              ░╚████╔╝░██║██║░░██╗░░░██║░░░██║░░██║██╔══██╗██║██╔══██║'), nl,
                                                                                   write('              ░░╚██╔╝░░██║╚█████╔╝░░░██║░░░╚█████╔╝██║░░██║██║██║░░██║'), nl,
                                                                                   write('              ░░░╚═╝░░░╚═╝░╚════╝░░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░╚═╝'), nl, nl,
                                                                                   write('         ▄  █ ██      ▄▄▄▄▄         ▄▀  ██      ▄   ██   ██▄   ████▄   ▄   ▄   ▄   ▄ '), nl,
                                                                                   write('        █   █ █ █    █     ▀▄     ▄▀    █ █      █  █ █  █  █  █   █  █   █   █   █  '), nl,
                                                                                   write('        ██▀▀█ █▄▄█ ▄  ▀▀▀▀▄       █ ▀▄  █▄▄█ ██   █ █▄▄█ █   █ █   █ █   █   █   █   '), nl,
                                                                                   write('        █   █ █  █  ▀▄▄▄▄▀        █   █ █  █ █ █  █ █  █ █  █  ▀████ █   █   █   █   '), nl,
                                                                                   write('           █     █                 ███     █ █  █ █    █ ███▀                        '), nl,
                                                                                   write('          ▀     █                         █  █   ██   █              ▀   ▀   ▀   ▀   '), nl,
                                                                                   write('               ▀                         ▀           ▀                               '), nl, nl,
                                                                                   write('                              EL PUBLICO ENLOQUECE!!!                            '), nl, nl,
                                                                                   write('༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽'), nl,
                                                                                   write('༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽'), nl,
                                                                                   write('༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽'), nl,
                                                                                   write('༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽'), nl
                                                            ;
                                                                Contador2 =< 4 ->  comprobar_fila(Resto_fila, Actual, Contador2) % si no es 4, seguimos buscando
                                                            )
                                                        ;
                                                            (Actual \= Anterior ; Actual == '_') -> Contador2 is 1, comprobar_fila(Resto_fila, Actual, Contador2) %caso general, si no hay dos casillas iguales seguidas O la casilla está vacia, reiniciamos el contador
                                                            % |______________________________|<- esto es un Or, creo que es feo pero funciona
                                                        ).

% prueba_comprobar:- tablero_prueba(Tp),
%              imprimir_tablero(Tp), nl,
%              nth1(2, Tp, Fila),
%              imprimir_lista(Fila), nl, nl,
%              comprobar_fila(Fila, '_', 1).

% comprobar_diagonal([Actual|Resto], Anterior, Contador, Lista_columnas):- 
%                                                 (
%                                                     extraer_posicion()
%                                                     comprobar_diagonal(Resto)
%                                                     Contador == 4 -> write('ganas')
%                                                 ;

                                                    
%                                                 ).

% comprobar_diagonal_aux(Tablero, Contador, Col):-

% diagonal tipo \
comprobar_diagonal1(X, Tablero):- append(_, [C1,C2,C3,C4|_], Tablero), % check if 4 connected columns exists in board...
                                append(I1, [X|_], C1), % ...such that all of them contain a piece of player X...
                                append(I2, [X|_], C2),
                                append(I3, [X|_], C3),
                                append(I4, [X|_], C4),
                                length(I1, M1), length(I2, M2), length(I3, M3), length(I4, M4),
                                M2 is M1+1, M3 is M2+1, M4 is M3+1.

% diagonal tipo / 
comprobar_diagonal2(X, Tablero):- append(_, [C1,C2,C3,C4|_], Tablero), % check if 4 connected columns exists in board...
                                append(I1, [X|_], C1), % ...such that all of them contain a piece of player X...
                                append(I2, [X|_], C2),
                                append(I3, [X|_], C3),
                                append(I4, [X|_], C4),
                                length(I1, M1), length(I2, M2), length(I3, M3), length(I4, M4),
                                M2 is M1-1, M3 is M2-1, M4 is M3-1.

prueba_diagonales:- tablero_prueba(Tp),
            comprobar_diagonal1('x', Tp),
            comprobar_diagonal2('x', Tp).



% RESPUESTA_ALEATORIA: función que escoge una columna aleatoria para la máquina.

respuesta_aleatoria(Lista_columnas, Tablero, Col_rand):- random_member(Col, Lista_columnas),
                                                    (
                                                        columna_llena(Col, Tablero) -> respuesta_aleatoria(Lista_columnas, Tablero, Col_rand)  
                                                    ;
                                                        Col_rand = Col
                                                    ). 

% prueba_random:- tablero_prueba(Tp),
%                 gen_lista_columnas(7, Lista_columnas),
%                 respuesta_aleatoria(Lista_columnas, Tp, Col_rand),
%                 write(Col_rand).


% ESTRATEGIA AVANZADA
% estrategia_maquina_avanzada([Actual|Resto_fila], Anterior, Contador):- % imprimir_lista([Actual|Resto_fila]), write(Contador), nl,
%                                                         (
%                                                             Actual == Anterior, Actual == 'o' -> Contador2 is Contador+1, % si acutal es igual al anterior y distinto de _, es decir, si hay ficha repetida, aumentamos el contador
%                                                             (
%                                                                 Contador2 == 4 ->  write('')
%                                                             ;
%                                                                 Contador2 =< 4 ->  comprobar_fila(Resto_fila, Actual, Contador2) % si no es 4, seguimos buscando
%                                                             )
%                                                         ;
%                                                             (Actual \= Anterior ; Actual == '_') -> Contador2 is 1, comprobar_fila(Resto_fila, Actual, Contador2) %caso general, si no hay dos casillas iguales seguidas O la casilla está vacia, reiniciamos el contador
                                                            
% estrategia_maquina_columnas([Actual|Resto_fila], Tablero, Contador, [Contadores]):-  
%                         (
%                             Actual == Anterior, Actual == 'o'  -> Contador2 is Contador+1
%                             (
%                                 1 < Contador2, Contador2 < 4 -> estrategia_maquina_columnas(Resto_fila, Actual, Contador2)
%                                 ;
%                                 Contador2 =< 4 ->  

%                             )
%                         ;
%                             (Actual \= Anterior ; Actual == '_') -> Contador2 is 1, estrategia_maquina_columnas(Resto_fila, Actual, Contador2)

%                         ).                                                          

% COMPROBAR VICTORIA: comprobar si algún jugador ha ganado la partida

comprobar_victoria(Jugador, Tablero):- comprobar_diagonal1(Jugador, Tablero);
                            comprobar_diagonal2(Jugador, Tablero);
                            comprobar_victoria_aux(Tablero); % comprueba filas
                            traspuesta(Tablero, TableroTras),
                            comprobar_victoria_aux(TableroTras). % comprueba Columnas

comprobar_victoria_aux([]):- false.
comprobar_victoria_aux([Fila|Resto]):- comprobar_fila(Fila, '_', 1); comprobar_victoria_aux(Resto). % se pone OR para que devuelva true en caso de que encuentre victoria y no recorra los demas


% JUGAR (JUGADOR CONTRA JUGADOR)

jugar:- write('Introduzca el numero de filas con las que quiere jugar: '), nl,
        read(Filas),
        write('Introduzca el numero de columnas con las que quiere jugar: '), nl,
        read(Columnas),
        generador_tablero(Filas, Columnas, Tablero),
        imprimir_mesa(Tablero), nl,
        gen_lista_columnas(Columnas, Lista_columnas),
        jugando(Tablero, Lista_columnas, 'x').

% JUGANDO (JUGADOR CONTRA JUGADOR)

jugando(Tablero, Lista_columnas, Jugador):- write('Comienza el turno del jugador '), write(Jugador), nl,
                                            leer_columna(Columna, Lista_columnas, Tablero),
                                            extraer_columna(Columna, Tablero, Col),
                                            introducir_ficha(Col, Jugador, Col2),
                                            introducir_col(Col2, Tablero, Columna, Tablero2),

                                            imprimir_mesa(Tablero2),
                                            (
                                                comprobar_victoria(Jugador, Tablero2) -> nl, write('                              Ha ganado el jugador '), write(Jugador), nl
                                            ;
                                                (
                                                    Jugador == 'x' -> Jugador2 = 'o'
                                                ;
                                                    Jugador == 'o' -> Jugador2 = 'x'
                                                ),
                                                jugando(Tablero2, Lista_columnas, Jugador2)
                                            ).



