% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 2 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% ____________________________ diccionario _____________________________________________ %

% ADJETIVOS

adjetivo(adj(X)) --> [X], {adj(X)}.
adj(alegres).
adj(alta).
adj(blanca).
adj(delicado).
adj(fritas).
adj(grande).
adj(lento).
adj(moreno).
adj(negros).
adj(potente).
adj(roja).
adj(rojas).

% NOMBRES

nombre(n(X)) --> [X], {n(X)}.
n(ayuda).
n(cafe).
n(canario).
n(cerveza).
n(comic).
n(corbata).
n(cuchillo).
n(documentos).
n(escribir).
n(esperanza).
n(feria).
n(herramienta).
n(hombre).
n(lugar).
n(manzana).
n(manzanas).
n(mesa).
n(nacimiento).
n(nino).
n(ninos).
n(noche).
n(paloma).
n(pantalon).
n(patatas).
n(practica).
n(procesador).
n(profesional).
n(profesor).
n(reflejos).
n(senor).
n(tenedor).
n(textos).
n(universidad).
n(vida).
n(vuelo).

% NOMBRES PROPIOS

nombre_propio(np(X)) --> [X], {np(X)}.
np(juan).
np(hector).
np(maria).
np(madrid).

% PRONOMBRES

pronombre(pr(X)) --> [X], {pr(X)}.
pr(tu).
pr(ella).

% PRONOMBRES RELATIVOS

pronombre_relativo(prel(X)) --> [X], {prel(X)}.
prel(que).

% ADVERBIOS

adverbio(adv(X)) --> [X], {adv(X)}.
adv(bastante).
adv(lejos).
adv(manana).
adv(muy).
adv(rapidamente).
adv(solamente).

% ADVERBIOS (que funcionan como nexos)

adverbio_nexo(advn(X)) --> [X], {advn(X)}.
advn(mientras).

% DETERMINANTES

determinante(det(X)) --> [X], {det(X)}.
det(el).
det(esos).
det(la).
det(toda).
det(un).
det(una).
det(su).
det(mi).

% CONJUNCIONES

conjuncion(conj(X)) --> [X], {conj(X)}.
conj(pero).
conj(y).

% PREPOSICIONES

preposicion(prep(X)) --> [X], {prep(X)}.
prep(a).
prep(con).
prep(de).
prep(del). % no es una preposición como tal, es unión de de + el
prep(en).
prep(para).

% VERBOS COPULATIVOS

verbo_copulativo(vcop(X)) --> [X], {vcop(X)}.
vcop(esta).
vcop(soy).
vcop(es).
vcop(era).

% VERBOS PREDICATIVOS

verbo(v(X)) --> [X], {v(X)}.
v(alzo).
v(bailamos).
v(beben).
v(bebimos).
v(canta).
v(cantan).
v(come).
v(comen).
v(compre).
v(creo).
v(depende).
v(estudiabas).
v(hablas).
v(hace).
v(iremos).
v(necesitais).
v(recoge).
v(toma).
v(saltan).
v(sirve).
v(sonrien).
v(vimos).