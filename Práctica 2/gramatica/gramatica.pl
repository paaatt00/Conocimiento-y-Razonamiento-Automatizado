% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 2 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% ____________________________ gramática _______________________________________________ %

:- consult(diccionario).

% ______________________________________________________________________________________ %

% ORACIONES

oracion(Oracion) --> oracion_compuesta(Oracion).
oracion(Oracion) --> oracion_simple(Oracion).

% ORACIÓN SIMPLE

oracion_simple(Oracion) --> oracion_aux(Oracion).

oracion_aux(o(GN, GV)) --> grupo_nominal(GN), grupo_verbal(GV).
oracion_aux(oSO(GV)) --> grupo_verbal(GV). % sujeto omitido

% ORACIÓN COMPUESTA

oracion_compuesta(ocm(Oracion)) --> oracion_coordinada(Oracion).

% ORACION SUBORDINADA ADJETIVA

oracion_subordinada(or(Nexo, GV)) --> nexo_subR(Nexo), oracion_simple(GV).
oracion_subordinada(oa(Nexo, GV)) --> nexo_subA(Nexo), oracion_simple(GV).

% ORACIÓN COORDINADA

oracion_coordinada(oc(Oracion1, Nexo, Oracion2)) --> oracion_aux(Oracion1), nexo(Nexo), oracion_aux(Oracion2).
oracion_coordinada(oc(Oracion1, Nexo1, Oracion2, Nexo2, Oracion3)) --> oracion_aux(Oracion1), nexo(Nexo1), oracion_aux(Oracion2), nexo(Nexo2), oracion_aux(Oracion3).

% ______________________________________________________________________________________ %

% SINTAGMA NOMINAL (gn)

grupo_nominal(GN) --> grupo_nominal_aux(GN).
grupo_nominal(gn(Det, GN)) --> determinante(Det), grupo_nominal_aux(GN).
grupo_nominal(gn(GN1, Nexo, GN2)) --> grupo_nominal_aux(GN1), nexo(Nexo), grupo_nominal_aux(GN2).
grupo_nominal(gn(GN, GPrep)) --> grupo_nominal_aux(GN), grupo_preposicional(GPrep).
grupo_nominal(gn(GN, GAadj)) --> grupo_nominal_aux(GN), grupo_adjetival(GAadj).
grupo_nominal(gn(GN, OrSub)) --> grupo_nominal_aux(GN), oracion_subordinada(OrSub).
grupo_nominal(gn(GN1, GN2)) --> grupo_nominal_aux(GN1), grupo_nominal_aux(GN2).

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
grupo_verbal(gv(V, GV)) --> verbo_copulativo(V), grupo_adjetival(GV).
grupo_verbal(gv(V, GV)) --> verbo_copulativo(V), grupo_nominal(GV).
grupo_verbal(gv(V, GV)) --> verbo(V), grupo_nominal(GV).
grupo_verbal(gv(V, GV1, GV2)) --> verbo(V), grupo_nominal(GV1), grupo_preposicional(GV2).
grupo_verbal(gv(V, GV1, GV2)) --> verbo(V), grupo_nominal(GV1), grupo_adjetival(GV2).
grupo_verbal(gv(V, GV)) --> verbo_copulativo(V), grupo_adverbial(GV).
grupo_verbal(gv(V, GV)) --> verbo(V), grupo_adjetival(GV).
grupo_verbal(gv(V, GV)) --> verbo(V), grupo_preposicional(GV).
grupo_verbal(gv(V, GV)) --> verbo(V), grupo_adverbial(GV).
grupo_verbal(gv(V, GV1, GV2)) --> verbo(V), grupo_adverbial(GV1), grupo_nominal(GV2).
grupo_verbal(gv(V, GV1, GV2)) --> verbo(V), grupo_preposicional(GV1), grupo_nominal(GV2).
grupo_verbal(gv(GV1, V, GV2)) --> grupo_adverbial(GV1), verbo(V), grupo_preposicional(GV2).
grupo_verbal(gv(V, OrSub)) --> verbo(V), oracion_subordinada(OrSub).
grupo_verbal(gv(V, GV1, OrSub)) --> verbo(V), grupo_nominal(GV1), oracion_subordinada(OrSub).

% SINTAGMA PREPOSICIONAL (gp)

grupo_preposicional(gp(Enlace, Termino)) --> preposicion(Enlace), grupo_nominal(Termino).

% SINTAGMA ADJETIVAL (gadj)

grupo_adjetival(gadj(Adj)) --> adjetivo(Adj).
grupo_adjetival(gadj(Adj, CAdj)) --> adjetivo(Adj), grupo_preposicional(CAdj).
grupo_adjetival(gadj(Adv, Adj)) --> adverbio(Adv), adjetivo(Adj).

% SINTAGMA ADVERBIAL (gadv)

grupo_adverbial(gadv(Adv1, Adv2, GPrep)) --> adverbio(Adv1), adverbio(Adv2), grupo_preposicional(GPrep). % muy lejos de Guadalajara
grupo_adverbial(gadv(Adv1, Adv2)) --> adverbio(Adv1), adverbio(Adv2). % muy rápidamente
grupo_adverbial(gadv(Adv)) --> adverbio(Adv). % lejos

% NEXOS

nexo(nexo(Nexo)) --> conjuncion(Nexo).
nexo_subA(nexo(Nexo)) --> adverbio_nexo(Nexo).
nexo_subR(nexo(PrRel)) --> pronombre_relativo(PrRel).