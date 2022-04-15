% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 2 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% _________________________________ test _______________________________________________ %

:-consult(gramatica).
:-consult(draw).
:-consult(oraciones).

% ______________________________________________________________________________________ %

% FUNCIONES AUXILIARES

imprimir(Lista):- imprimirAux(Lista).

imprimirAux([Head|Tail]):- write(Head), write(". "),
                           imprimirAux(Tail), !.
imprimirAux([]):- write("\n").

buscarAnalisis(Palabra, [AsH|AsT]):- member(Palabra, AsH),
                                    [_|Analisis] =  AsH,
                                    imprimir(Analisis);
                                    buscarAnalisis(Palabra, AsT).

buscarAnalisis(_, []).

analisisS([PalabraH|PalabraT], ListaP):-  write(PalabraH), write(": "),
                                        buscarAnalisis(PalabraH, ListaP),
                                        analisisS(PalabraT, ListaP).
analisisS([], _).

% TESTS

test1:- oracion1(O1), oracion(X, O1, []), draw(X), nl.

test2:- oracion2(O2), oracion(X, O2, []), draw(X), nl.

test3:- oracion3(O3), oracion(X, O3, []), draw(X), nl.