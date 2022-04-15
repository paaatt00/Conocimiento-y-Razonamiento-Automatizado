% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 2 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% ____________________________ diccionario _____________________________________________ %


% ADJETIVOS

adjetivo(adj(X)) --> [X], {adj(X)}.
adj(grande).
adj(roja).

% NOMBRES

nombre(n(X)) --> [X], {n(X)}.
n(hombre)
n(manzana)
n(tenedor)
n(cuchillo)

% NOMBRES PROPIOS

nombre_propio(np(X)) --> [X], {np(X)}.
np(juan)
np(maria)

% PRONOMBRES

pronombre(pr(X)) --> [X], {pr(X)}.
pr(tu)

% ADVERBIOS

advervio(adv(X)) --> [X], {adv(X)}.
adv(muy)
adv(rapidamente)

% DETERMINANTES

determinante(det(X)) --> [X], {det(X)}.
det(el)
det(la)
det(un)

% CONJUNCIONES

conjunciones(conj(X)) --> [X], {conj(X)}.
conj(y)

% PREPOSICIONES

preposiciones(prep(X)) --> [X], {prep(X)}.
prep(con)

% VERBOS COPULATIVOS

verbos_copulativos(vcop(X)) --> [X], {vcop(X)}.

% VERBOS PREDICATIVOS

verbo(v(X)) --> [X], {v(X)}.
v(come)
v(comen)
v(hablas)



