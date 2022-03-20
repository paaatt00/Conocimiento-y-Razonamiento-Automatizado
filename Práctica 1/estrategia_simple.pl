% ______________________________________________________________________________________%

% ESTRATEGIA SIMPLE

% JUGAR (JUGADOR CONTRA JUGADOR)

jugar_maquina_simple:- write('Introduzca el numero de filas con las que quiere jugar: '), nl,
                        read(Filas),
                        write('Introduzca el numero de columnas con las que quiere jugar: '), nl,
                        read(Columnas),
                        generador_tablero(Filas, Columnas, Tablero),
                        imprimir_mesa(Tablero), nl,
                        gen_lista_columnas(Columnas, Lista_columnas),
                        jugando_maquina_simple(Tablero, Lista_columnas, 'x').


jugando_maquina_simple(Tablero, Lista_columnas, Jugador):-  write('Comienza el turno del jugador '), write(Jugador), nl,
                                            (
                                                Jugador == 'x' -> leer_columna(Columna, Lista_columnas, Tablero)

                                                ;

                                                Jugador == 'o' -> respuesta_aleatoria(Lista_columnas, Tablero, Columna)
                                            ),
                                          
                                            extraer_columna(Columna, Tablero, Col),
                                            introducir_ficha(Col, Jugador, Col2),
                                            introducir_col(Col2, Tablero, Columna, Tablero2),

                                            imprimir_mesa(Tablero2),
                                            (
                                                comprobar_victoria(Tablero2) -> write('Ha ganado el jugador '), write(Jugador)
                                            ;
                                                (
                                                    Jugador == 'x' -> Jugador2 = 'o'
                                                ;
                                                    Jugador == 'o' -> Jugador2 = 'x'
                                                ),
                                                jugando_maquina_simple(Tablero2, Lista_columnas, Jugador2)
                                            ).