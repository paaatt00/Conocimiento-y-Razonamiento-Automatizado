% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 1 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% ____________________________ máquina lista ___________________________________________ %

% basado punto a punto en el metodo de comprobar fila de tablero.pl
mejor_posicion_horizontal_aux([], _, _, _, Index, Index_out):- Index_out = Index. % asigna la salida al indice de la columna en la que acaba la sucesion de fichas enemigas
mejor_posicion_horizontal_aux([Actual|Resto_fila], Jugador, Anterior, Contador, Index, Index_out):- Index2 is Index+1,
                                                                                        (
                                                                                            Actual == Jugador, Actual == Anterior, Actual \= '_' -> Contador2 is Contador+1, % actualizamos contador
                                                                                            (
                                                                                                Contador2 == 3 -> mejor_posicion_horizontal_aux([], _, _, _, Index2,  Index_out) % llamada al caso base para que acabe la recursividad ya que ya ha encontrado un sitio en que ha de defenderse
                                                                                            ;
                                                                                                Contador2 =< 3 ->  mejor_posicion_horizontal_aux(Resto_fila, Jugador, Actual, Contador2, Index2, Index_out) %en caso contrario sigue buscando en la fila
                                                                                            )
                                                                                        ;
                                                                                            (Actual \= Anterior ; Actual == '_') -> Contador2 is 1, mejor_posicion_horizontal_aux(Resto_fila, Jugador, Actual, Contador2, Index2, Index_out)
                                                                                            
                                                                                        ).

% basado punto a punto en el metodo de comprobar fila de tablero.pl
mejor_posicion_vertical_aux([], _, _, _):- false. %si la columna no tiene ninguna sucesion de 3 elementos enemigos, devuelve false
mejor_posicion_vertical_aux([Actual|Resto_fila], Jugador, Anterior, Contador):- (
                                                                            Actual == Jugador, Actual == Anterior, Actual \= '_' -> Contador2 is Contador+1, 
                                                                        (
                                                                                Contador2 == 3 -> true % si sí hay tres elementos enemigos seguidos, los defiende 
                                                                        ;
                                                                                Contador2 =< 3 ->  mejor_posicion_vertical_aux(Resto_fila, Jugador, Actual, Contador2) %en caso contrario sigue buscando
                                                                            )
                                                                        ;
                                                                            (Actual \= Anterior ; Actual == '_') -> Contador2 is 1, mejor_posicion_vertical_aux(Resto_fila, Jugador, Actual, Contador2)
                                                                            
                                                                        ).

% Devuelve la "mejor" posición en horizonal 
mejor_posicion_horizontal([], Lista_columnas, _, Posicion_out):- length(Lista_columnas,N), Posicion_out is N+1.
mejor_posicion_horizontal([Fila_actual|Resto], Lista_columnas, Jugador, Posicion_out):- mejor_posicion_horizontal_aux(Fila_actual, Jugador, '_', 0, 0, Columna),% columna es el indice de la ultima ficha que forma una cadena de 3 para el oponente
                                                                                        Columna2 is Columna+1,% como se meterá en la siguiente columna, sumamos 1
                                                                                        (
                                                                                            member(Columna2, Lista_columnas) -> Posicion_out = Columna2 %si la columna es valida termina la recursividad y devuelve columna2
                                                                                        ;
                                                                                            mejor_posicion_horizontal(Resto, Lista_columnas, Jugador, Posicion_out)
                                                                                        ).

mejor_posicion_vertical([], Lista_columnas, _, _, Contador_out):- length(Lista_columnas, N), Contador_out is N+1.
mejor_posicion_vertical([Columna_actual|Resto], Lista_columnas, Jugador, Contador, Contador_out):-(
                                                                                            mejor_posicion_vertical_aux(Columna_actual, Jugador, '_', 0) -> Contador_out = Contador %si ha encontrado algo que ha de defender en la columna, lo defiende
                                                                                        ;
                                                                                            Contador2 is Contador+1,
                                                                                            mejor_posicion_vertical(Resto, Lista_columnas, Jugador, Contador2, Contador_out)
                                                                                        ).

mejor_posicion(Tablero, Lista_columnas, Posicion):- (   
                                                        mejor_posicion_horizontal(Tablero, Lista_columnas, 'o', Posicion_horizontal), % ataca en horizontal
                                                        member(Posicion_horizontal, Lista_columnas) -> Posicion = Posicion_horizontal % comprobamos por si ha devuelto false
                                                    ;
                                                        traspuesta(Tablero, TableroTras),
                                                        mejor_posicion_vertical(TableroTras, Lista_columnas, 'o', 1, Posicion_vertical), % ataca en vertical
                                                        (
                                                            member(Posicion_vertical, Lista_columnas) -> Posicion = Posicion_vertical
                                                        ;
                                                            (   
                                                                mejor_posicion_horizontal(Tablero, Lista_columnas, 'x', Posicion_horizontal), % defiende en horizontal
                                                                member(Posicion_horizontal, Lista_columnas) -> Posicion = Posicion_horizontal % comprobamos por si ha devuelto false
                                                            ;
                                                                mejor_posicion_vertical(TableroTras, Lista_columnas, 'x', 1, Posicion_vertical), % defiende en vertical
                                                                (
                                                                    member(Posicion_vertical, Lista_columnas) -> Posicion = Posicion_vertical
                                                                ;
                                                                    respuesta_aleatoria(Lista_columnas, Tablero, Col_rand),
                                                                    Posicion = Col_rand
                                                                )
                                                            )
                                                        )
                                                    ).

jugando_maquina_avanzada(Tablero, Lista_columnas, Jugador):-  write('Comienza el turno del jugador '), write(Jugador), nl,
                                            (
                                                Jugador == 'x' -> leer_columna(Columna, Lista_columnas, Tablero)

                                                ;
												
                                                Jugador == 'o' -> mejor_posicion(Tablero, Lista_columnas, Columna)
                                            ),
                                          
                                            extraer_columna(Columna, Tablero, Col),
                                            introducir_ficha(Col, Jugador, Col2),
                                            introducir_col(Col2, Tablero, Columna, Tablero2),

                                            imprimir_mesa(Tablero2),
                                            (
                                                comprobar_victoria(Jugador, Tablero2) -> write('              ██╗░░░██╗██╗░█████╗░████████╗░█████╗░██████╗░██╗░█████╗░'), nl, 
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
                                                                                         write('                              Ha ganado el jugador '), write(Jugador), nl, nl,
                                                                                         write('                              EL PUBLICO ENLOQUECE!!!                                '), nl, nl,
                                                                                         write('༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽'), nl,
                                                                                         write('༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽'), nl,
                                                                                         write('༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽'), nl,
                                                                                         write('༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽ ༼ ºل͟º ༼ ºل͟º ༼ ºل͟º ༽ ºل͟º ༽ ºل͟º ༽'), nl, nl
                                            ;
                                                (
                                                    Jugador == 'x' -> Jugador2 = 'o'
                                                ;
                                                    Jugador == 'o' -> Jugador2 = 'x'
                                                ),
                                                jugando_maquina_avanzada(Tablero2, Lista_columnas, Jugador2)
                                            ).

