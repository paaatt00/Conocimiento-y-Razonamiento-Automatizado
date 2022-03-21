% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 1 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% __________________________ archivo de pruebas ________________________________________ %

tablero_prueba([
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', '_', '_', '_', '_'],
                ['_', '_', '_', 'x', '_', '_', '_'],
                ['_', '_', 'x', '_', 'x', '_', '_'],
                ['_', 'x', '_', '_', '_', 'x', '_'],
                ['x', '_', '_', '_', '_', '_', 'x']
                ]).

prueba_gen_tablero:- generador_tablero(7, 6, Out),
                    imprimir_tablero(Out).

prueba_guiones:- generador_lista_guiones(15,Y), imprimir_lista(Y).

prueba_impresion:- imprimir_lista([' ', 1, ' ', 2, ' ', 3, ' ', 4, ' ', 5, ' ', 6, ' ', 7]).

prueba_tablero:- tablero_prueba(Tp), imprimir_mesa(Tp).

prueba_extraer_fila:- tablero_prueba(Tp),
                    extraer_fila(1, Tp, Fila),
                    imprimir_lista(Fila).

prueba_extraer:- tablero_prueba(Tp),
                extraer_columna(1, Tp, Aux),
                imprimir_lista(Aux).

prueba_extraer_posicion:- tablero_prueba(Tp),
                        extraer_posicion(1, 3, Tp, Elem),
                        write(Elem).

prueba_leer:- gen_lista_columnas(7, Lista_columnas),
            leer_columna(X, Lista_columnas),
            write(X).

prueba_traspuesta:- tablero_prueba(Tp),
                    traspuesta(Tp, Tp2),
                    imprimir_mesa(Tp2),
                    traspuesta(Tp2, Tp3),
                    imprimir_mesa(Tp3).

prueba_introducir_ficha:- tablero_prueba(Tp),
                        traspuesta(Tp, Tp2),
                        extraer_columna(1, Tp2, Aux),
                        introducir(Aux, 'X', Aux1),
                        imprimir_lista(Aux1).

prueba_introducir_col:- tablero_prueba(Tp),
                        introducir_col(['o', 'x', 'o', 'x', 'x', 'o'],Tp, 3, TOut),
                        imprimir_mesa(TOut).

prueba_comprobar:- tablero_prueba(Tp),
                imprimir_tablero(Tp), nl,
                nth1(2, Tp, Fila),
                imprimir_lista(Fila), nl, nl,
                comprobar_fila(Fila, '_', 1).

prueba_diagonales:- tablero_prueba(Tp),
                    comprobar_diagonal1('x', Tp);
                    comprobar_diagonal2('x', Tp).

prueba_random:- tablero_prueba(Tp),
                gen_lista_columnas(7, Lista_columnas),
                respuesta_aleatoria(Lista_columnas, Tp, Col_rand),
                write(Col_rand).

prueba_mejor_horizontal:- tablero_prueba(Tp),
              imprimir_tablero(Tp), nl,
              nth1(2, Tp, Fila),
              imprimir_lista(Fila), nl, nl,
              mejor_posicion_horizontal_aux(Fila, '_', 0,0,Index_out),
    		  write(Index_out).