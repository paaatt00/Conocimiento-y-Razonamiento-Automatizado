% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 2 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% ____________________________ gramática _______________________________________________ %

:- consult(diccionario).

% ______________________________________________________________________________________ %

% ORACIONES

oracion(Oracion) --> oracion_simple(Oracion).
% oracion(Oracion) --> oracion_compuesta(Oracion).

% ORACIÓN SIMPLE

oracion_simple(Oracion) --> oracion_aux(Oracion).

oracion_aux(o(GN,GV)) --> grupo_nominal(GN), grupo_verbal(GV).
oracion_aux(oSO(GV)) --> grupo_verbal(GV). % sujeto omitido

% ORACIÓN COMPUESTA

% ORACIÓN COORDINADA

% ORACION SUBORDINADA ADJETIVA

% oracionSubordinada(or(Nexo, GV)) --> nexo(Nexo), g_verbal(GV).

% ______________________________________________________________________________________ %

% SINTAGMA NOMINAL (gn)

grupo_nominal(GN) --> grupo_nominal_aux(GN).
grupo_nominal(gn(GN1, Nexo, GN2)) --> grupo_nominal_aux(GN1), nexo(Nexo), grupo_nominal_aux(GN2).

grupo_nominal_aux(gn(N)) --> nombre(N).
grupo_nominal_aux(gn(N)) --> pronombre(N).
grupo_nominal_aux(gn(NP)) --> nombre_propio(NP).
grupo_nominal_aux(gn(Det, N)) --> determinante(Det), nombre(N).
grupo_nominal_aux(gn(N, CN)) --> nombre(N), grupo_adjetival(CN).
grupo_nominal_aux(gn(CN, N)) --> grupo_adjetival(CN), nombre(N).
grupo_nominal_aux(gn(Det, CN, N)) --> determinante(Det), grupo_adjetival(CN), nombre(N).
grupo_nominal_aux(gn(Det, N, CN)) --> determinante(Det), nombre(N), grupo_adjetival(CN).
grupo_nominal_aux(gn(Det, N, CN)) --> determinante(Det), nombre(N), grupo_preposicional(CN).

% SINTAGMA VERBAL (gv)

grupo_verbal(gv(V)) --> verbo(V).
grupo_verbal(gv(V, GV)) --> verbo(V), complemento_directo(GV).
grupo_verbal(gv(V, GV)) --> verbo_copulativo(V), atributo(GV).
grupo_verbal(gv(V, GV1, GV2)) --> verbo(V), complemento_directo(GV1), grupo_preposicional(GV2).
% grupo_verbal(gv(V, GV1, GV2)) --> verbo(V), complemento_directo(GV1), grupo_adjetival(GV2).
grupo_verbal(gv(V, GV)) --> verbo(V), grupo_adjetival(GV).
grupo_verbal(gv(V, GV)) --> verbo(V), grupo_preposicional(GV).
grupo_verbal(gv(V, GV)) --> verbo(V), grupo_adverbial(GV).
grupo_verbal(gv(V, GV)) --> verbo_copulativo(V), grupo_adverbial(GV).
grupo_verbal(gv(V, GV1, GV2)) --> verbo(V), grupo_preposicional(GV1), complemento_directo(GV2).
grupo_verbal(gv(GV1, V, GV2)) --> grupo_adverbial(GV1), verbo(V), grupo_preposicional(GV2).

% SINTAGMA PREPOSICIONAL (gp)

grupo_preposicional(gp(Enlace, Termino)) --> preposicion(Enlace), grupo_nominal(Termino).

% SINTAGMA ADJETIVAL (gadj)

grupo_adjetival(gadj(Adj)) --> adjetivo(Adj).
grupo_adjetival(gadj(Adj, CAdj)) --> adjetivo(Adj), grupo_preposicional(CAdj).

% SINTAGMA ADVERBIAL (gadv)

grupo_adverbial(gadv(Adv1, Adv2, GPrep)) --> adverbio(Adv1), adverbio(Adv2), grupo_preposicional(GPrep). % muy lejos de Guadalajara
grupo_adverbial(gadv(Adv1, Adv2)) --> adverbio(Adv1), adverbio(Adv2). % muy rápidamente
grupo_adverbial(gadv(Adv)) --> adverbio(Adv). % lejos


% COMPLEMENTO DIRECTO (cd)

complemento_directo(cd(GN)) --> grupo_nominal(GN). % tiene libros

% ATRIBUTO

atributo(atrib(GAdj)) --> grupo_adjetival(GAdj). % soy lento de reflejos

% NEXOS

nexo(nexo(Conj)) --> conjuncion(Conj).