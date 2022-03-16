 %---------------------------- PRÁCTICA 1 CRA ----------------------------

% TABLERO [' ', 1, ' ', 2, ' ', 3, ' ', 4, ' ', 5, ' ', 6, ' ', 7]
 
tablero_prueba([
                ['x', 'x', 'o', 'x', 'x', 'o', 'x'],
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

prueba_gen_tablero:- generador_tablero(7, 6, Out),
                     imprimir_tablero(Out).

%genera una lista que contendrá los numero de columna validos
gen_lista_columnas(1, [1]).
gen_lista_columnas(Columna, [Columna|Cola]) :- Columna > 1,
                                               Columna2 is Columna-1,
                                               gen_lista_columnas(Columna2, Cola).

% AA

is_empty(List):- not(member(_, List)).

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
    			   generador_lista_guiones(15, L1), imprimir_lista(L1), nl,
    			   imprimir_tablero(T).

% ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽

prueba_tablero:- tablero_prueba(Tp), imprimir_mesa(Tp).

%COMPROBAR SI UNA COLUMNA ESTÁ LLENA

columna_llena(Columna,Tablero):-nth1(Columna,Tablero,Fila),
                                not(nth1(1,Fila,'_')).

% LEER COLUMNA

leer_columna(X, Lista_columnas, Tablero):- write('Introduzca el numero de columna en el que quiere meter su ficha:'),
                                           read(Y),
                                           (   not(member(Y,Lista_columas)) ->  write('Columna fuera de rango, conteste nuevamente.'), nl, 
                                               leer_columna(X,Lista_columnas,Tablero)
                                           ;
                                               columna_llena(Y,Tablero) -> write('Columna llena, conteste nuevamente.'), nl, 
                                               leer_columna(X,Lista_columnas,Tablero)
                                           ;
                                               X = Y
                                           ).

prueba_leer:- gen_lista_columnas(7, Lista_columnas),
              leer_columna(X, Lista_columnas), 
              write(X).

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

introducir_col_aux(_, Tablero, [], Col):- .



% INSERTAR COLUMNA

% insertar_columna(N, Tablero, Col):- insertar_columna_aux(N, Tablero, [], Col).

% COMPROBAR FILA
% llamar con Anterior='_' la primera vez, o cualquier termino uqe no sea una ficha

comprobar_fila([], _, _):- false.  
comprobar_fila([Actual|Resto_fila], Anterior, Contador):- % imprimir_lista([Actual|Resto_fila]), write(Contador), nl,
                                                          (Actual == Anterior, Actual \= '_' -> Contador2 is Contador+1, % si acutal es igual al anterior y distinto de _, es decir, si hay ficha repetida, aumentamos el contador
                                                              (   
                                                                  Contador2 == 4 ->  write('Victoria, has ganado') % si el contador llega a 4, alguien gana
                                                              ;   
                                                                  Contador2 \= 4 ->  comprobar_fila(Resto_fila, Actual, Contador2) % si no es 4, seguimos buscando
                                                              )
                                                          ;
                                                          (Actual \= Anterior ; Actual=='_') -> Contador2 is 1,comprobar_fila(Resto_fila, Actual, Contador2) %caso general, si no hay dos casillas iguales seguidas O la casilla está vacia, reiniciamos el contador
                                                          % |______________________________|<- esto es un Or, creo que es feo pero funciona 
                                                          ).

prueba_comprobar:- tablero_prueba(Tp),
    			   imprimir_tablero(Tp),nl,
    			   nth1(2, Tp, Fila),
    			   imprimir_lista(Fila),nl,nl,
    			   comprobar_fila(Fila, '_', 1).

% Comprobar si algún jugador ha ganado la partida
comprobar_victoria(Tablero):- comprobar_victoria_aux(Tablero), % comprueba filas
                              traspuesta(Tablero, TableroTras),
                              comprobar_victoria_aux(Tablero2) % comprueba Columnas
                            .
                    
comprobar_victoria_aux([]):-false.
comprobar_victoria_aux([Fila|Resto]):-comprobar_fila(Fila,'_',1),comprobar_victoria_aux(Resto).

.
% JUGAR
jugar:- write('Introduzca el numero de filas con las que quiere jugar'),nl
    	read(Filas),
      	write('Introduzca el número de columnas con las que quiere jugar'),nl
      	read(Columnas),
      	generar_tablero(Filas,Columnas,Tablero),
       	imprimir_tablero(Tablero),nl,
    	gen_lista_columnas(Columnas, Lista_columnas)
    	% Ya está el tablero generado, hay que guardarlo y pasarlo a todo,
    	% además de conservar y usar la lista de columnas, falta hacer
    	% jugando que haga todo lo que ha de hacer

    	.

jugando(Tablero,Lista_columnas,Jugador):- write('Comienza el turno del jugador'),write(Jugador),nl,
                                          leer_columna(Columna,Lista_columnas,Tablero),
                                          extraer_columna(Columna, Tablero, Col),
                                          %TRASPUESTA
                                          introducir_ficha(Col, Jugador, Col2),
                                          introducir_col(),
                                          
                                          
                                          
                                          
                                          comprobar_victoria(Tablero),
                                          (
                                            Jugador == 'x' -> Jugador2 is 'o'
                                          ;
                                            Jugador == 'o' -> Jugador2 is 'x'
                                          )
                                          jugando(Tablero,Lista_columas,Jugador2).

