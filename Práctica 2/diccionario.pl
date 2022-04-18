% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 2 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% ____________________________ diccionario _____________________________________________ %

% ADJETIVOS

adjetivo(adj(X)) --> [X], {adj(X)}.
adj(grande).
adj(roja).
adj(blanca).
adj(lento).

% NOMBRES

nombre(n(X)) --> [X], {n(X)}.
n(hombre).
n(manzana).
n(tenedor).
n(cuchillo).
n(practica).
n(canario).
n(paloma).
n(vuelo).
n(reflejos).
n(feria).
n(comic).

% NOMBRES PROPIOS

nombre_propio(np(X)) --> [X], {np(X)}.
np(juan).
np(maria).
np(madrid).

% PRONOMBRES

pronombre(pr(X)) --> [X], {pr(X)}.
pr(tu).
pr(ella).

% ADVERBIOS

adverbio(adv(X)) --> [X], {adv(X)}.
adv(muy).
adv(rapidamente).
adv(lejos).
adv(manana).

% DETERMINANTES

determinante(det(X)) --> [X], {det(X)}.
det(el).
det(la).
det(un).

% CONJUNCIONES

conjuncion(conj(X)) --> [X], {conj(X)}.
conj(y).

% PREPOSICIONES

preposicion(prep(X)) --> [X], {prep(X)}.
prep(con).
prep(de).
prep(del). % no es una preposición como tal, es unión de de + el
prep(a).

% VERBOS COPULATIVOS

verbo_copulativo(vcop(X)) --> [X], {vcop(X)}.
vcop(esta).
vcop(soy).

% VERBOS PREDICATIVOS

verbo(v(X)) --> [X], {v(X)}.
v(come).
v(comen).
v(hablas).
v(hace).
v(canta).
v(alzo).
v(iremos).
