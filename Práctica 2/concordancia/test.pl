% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 2 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% _________________________________ test _______________________________________________ %

:- consult(gramatica).
:- consult(draw).
:- consult(oraciones).

% ______________________________________________________________________________________ %

% TESTS
test1:- oracion1(Or1), oracion(X, Or1, []), draw(X), nl, !.
test2:- oracion2(Or2), oracion(X, Or2, []), draw(X), nl, !.
test3:- oracion3(Or3), oracion(X, Or3, []), draw(X), nl, !.
test4:- oracion4(Or4), oracion(X, Or4, []), draw(X), nl, !.
test5:- oracion5(Or5), oracion(X, Or5, []), draw(X), nl, !.
test6:- oracion6(Or6), oracion(X, Or6, []), draw(X), nl, !.
test7:- oracion7(Or7), oracion(X, Or7, []), draw(X), nl, !.
test8:- oracion8(Or8), oracion(X, Or8, []), draw(X), nl, !.
test9:- oracion9(Or9), oracion(X, Or9, []), draw(X), nl, !.
test10:- oracion10(Or10), oracion(X, Or10, []), draw(X), nl, !.
test11:- oracion11(Or11), oracion(X, Or11, []), draw(X), nl, !.
test12:- oracion12(Or12), oracion(X, Or12, []), draw(X), nl, !.
test13:- oracion13(Or13), oracion(X, Or13, []), draw(X), nl, !.
test14:- oracion14(Or14), oracion(X, Or14, []), draw(X), nl, !.
test15:- oracion15(Or15), oracion(X, Or15, []), draw(X), nl, !.
test16:- oracion16(Or16), oracion(X, Or16, []), draw(X), nl, !.
test17:- oracion17(Or17), oracion(X, Or17, []), draw(X), nl, !.
test18:- oracion18(Or18), oracion(X, Or18, []), draw(X), nl, !.
test19:- oracion19(Or19), oracion(X, Or19, []), draw(X), nl, !.
test20:- oracion20(Or20), oracion(X, Or20, []), draw(X), nl, !.
test21:- oracion21(Or21), oracion(X, Or21, []), draw(X), nl, !.
test22:- oracion22(Or22), oracion(X, Or22, []), draw(X), nl, !.

testTest:- oracionTest(OrTest),oracion(X,OrTest,[]),draw(X),nl,!.

tests1_11:- write('Oracion 1'), nl,
            test1,
            write('Oracion 2'), nl,
            test2,
            write('Oracion 3'), nl,
            test3,
            write('Oracion 4'), nl,
            test4,
            write('Oracion 5'), nl,
            test5,
            write('Oracion 6'), nl,
            test6,
            write('Oracion 7'), nl,
            test7,
            write('Oracion 8'), nl,
            test8,
            write('Oracion 9'), nl,
            test9,
            write('Oracion 10'), nl,
            test10,
            write('Oracion 11'), nl,
            test11, !.
            
tests11_22:- write('Oracion 12'), nl,
            test12,
            write('Oracion 13'), nl,
            test13,
            write('Oracion 14'), nl,
            test14,
            write('Oracion 15'), nl,
            test15,
            write('Oracion 16'), nl,
            test16,
            write('Oracion 17'), nl,
            test17,
            write('Oracion 18'), nl,
            test18,
            write('Oracion 19'), nl,
            test19,
            write('Oracion 20'), nl,
            test20,
            write('Oracion 21'), nl,
            test21,
            write('Oracion 22'), nl,
            test22, !.