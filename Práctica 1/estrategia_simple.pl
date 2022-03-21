% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 1 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% ____________________________ máquina tonta ___________________________________________ %

jugando_maquina_simple(Tablero, Lista_columnas, Jugador):- write('Comienza el turno del jugador '), write(Jugador), nl,
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
                                                            jugando_maquina_simple(Tablero2, Lista_columnas, Jugador2)
                                                        ).