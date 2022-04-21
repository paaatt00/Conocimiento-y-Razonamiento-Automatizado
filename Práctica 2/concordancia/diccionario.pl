% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 2 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% ____________________________ diccionario _____________________________________________ %

% ADJETIVOS

adjetivo(adj(X), G, N) --> [X],  {adj(X, G, N)}.
adj(alegres, _, pl).
adj(alta, f, sg).
adj(blanca, f, sg).
adj(delicado, m, sg).
adj(fritas, f, pl).
adj(grande, _, sg).
adj(lento, m, sg).
adj(moreno, m, sg).
adj(negros, m, pl).
adj(potente, _, sg).
adj(roja, f, sg).
adj(rojas, f, pl).

% NOMBRES

nombre(n(X), G, N) --> [X],  {n(X, G, N)}.
n(ayuda, f, sg).
n(cafe, m, sg).
n(canario, m, sg).
n(cerveza, f, sg).
n(comic, m, sg).
n(corbata, f, sg).
n(cuchillo, m, sg).
n(documentos, m, pl).
n(escribir, m, sg).
n(esperanza, f, sg).
n(feria, f, sg).
n(herramienta, f, sg).
n(hombre, m, sg).
n(lugar, m, sg).
n(manzana, f, sg).
n(manzanas, f, pl).
n(mesa, f, sg).
n(nacimiento, m, sg).
n(nino, m, sg).
n(ninos, m, pl).
n(noche, f, sg).
n(paloma, f, sg).
n(pantalon, m, sg).
n(patatas, f, pl).
n(practica, f, sg).
n(procesador, m, sg).
n(profesional, m, sg).
n(profesor, m, sg).
n(reflejos, m, pl).
n(senor, m, sg).
n(tenedor, m, sg).
n(textos, m, pl).
n(universidad, f, sg).
n(vida, f, sg).
n(vuelo, m, sg).

% NOMBRES PROPIOS
nombre_propio(np(X), G, N) --> [X],  {np(X, G, N)}.
np(juan, m, sg).
np(hector, m, sg).
np(maria, f, sg).
np(madrid, m, sg).

% PRONOMBRES

pronombre(pr(X), G, N) --> [X],  {pr(X, G, N)}.
pr(tu, _, sg).
pr(ella, f, sg).

% PRONOMBRES RELATIVOS

pronombre_relativo(prel(X)) --> [X],  {prel(X)}.%Dudo TODO
prel(que).

% ADVERBIOS

adverbio(adv(X)) --> [X],  {adv(X)}.
adv(bastante).
adv(lejos).
adv(manana).
adv(muy).
adv(rapidamente).
adv(solamente).

% ADVERBIOS (que funcionan como nexos)

adverbio_nexo(advn(X)) --> [X],  {advn(X)}.
advn(mientras).

% DETERMINANTES

determinante(det(X), G, N) --> [X],  {det(X, G, N)}.
det(el, m, sg).
det(esos, m, pl).
det(la, f, sg).
det(toda, f, sg).
det(un, m, sg).
det(una, f, sg).
det(su, _, sg).
det(mi, _, sg).

% CONJUNCIONES

conjuncion(conj(X)) --> [X],  {conj(X)}.
conj(pero).
conj(y).

% PREPOSICIONES

preposicion(prep(X)) --> [X],  {prep(X)}.
prep(a).
prep(con).
prep(de).
prep(del). % no es una preposición como tal,  es unión de de + el
prep(en).
prep(para).

% VERBOS COPULATIVOS

verbo_copulativo(vcop(X), N) --> [X],  {vcop(X, N)}.
vcop(esta, sg).
vcop(soy, sg).
vcop(es, sg).
vcop(era, sg).

% VERBOS PREDICATIVOS

verbo(v(X), N) --> [X],  {v(X, N)}.
v(alzo, sg).
v(bailamos, pl).
v(beben, pl).
v(bebimos, pl).
v(canta, sg).
v(cantan, pl).
v(come, sg).
v(comen, pl).
v(compre, sg).
v(creo, sg).
v(depende, sg).
v(estudiabas, pl).
v(hablas, pl).
v(hace, sg).
v(iremos, pl).
v(necesitais, pl).
v(recoge, sg).
v(toma, sg).
v(saltan, pl).
v(sirve, sg).
v(sonrien, pl).
v(vimos, pl).