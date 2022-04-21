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

oracion_aux(o(GN,GV)) --> grupo_nominal(GN,G,N),grupo_verbal(GV,G,N).
oracion_aux(oSO(GV)) --> grupo_verbal(GV,G,N). % sujeto omitido

% ORACIÓN COMPUESTA

oracion_compuesta(ocm(Oracion)) --> oracion_coordinada(Oracion).

% ORACION SUBORDINADA ADJETIVA

oracion_subordinada(or(Nexo,GV)) --> nexo_sub(Nexo),grupo_verbal(GV,_,_).

% ORACIÓN COORDINADA

oracion_coordinada(oc(Oracion1,Nexo,Oracion2)) --> oracion_aux(Oracion1),nexo(Nexo),oracion_aux(Oracion2).
oracion_coordinada(oc(Oracion1,Nexo1,Oracion2,Nexo2,Oracion3)) --> oracion_aux(Oracion1),nexo(Nexo1),oracion_aux(Oracion2),nexo(Nexo2),oracion_aux(Oracion3).

% ______________________________________________________________________________________ %

% SINTAGMA NOMINAL (gn)

grupo_nominal(GN,G,N) --> grupo_nominal_aux(GN,G,N).
grupo_nominal(gn(Det,GN),G,N) --> determinante(Det,G,N),grupo_nominal_aux(GN,G,N).
grupo_nominal(gn(GN1,Nexo,GN2),_,pl) --> grupo_nominal_aux(GN1,_,_),nexo(Nexo),grupo_nominal_aux(GN2,_,_).
grupo_nominal(gn(GN,GPrep),G,N) --> grupo_nominal_aux(GN,G,N),grupo_preposicional(GPrep).
grupo_nominal(gn(GN,GAadj),G,N) --> grupo_nominal_aux(GN,G,N),grupo_adjetival(GAadj,G,N).
grupo_nominal(gn(GN,OrSub),G,N) --> grupo_nominal_aux(GN,G,N),oracion_subordinada(OrSub).

grupo_nominal_aux(gn(Nom),G,N) --> nombre(Nom,G,N).
grupo_nominal_aux(gn(Nom),G,N) --> pronombre(Nom,G,N).
grupo_nominal_aux(gn(NP),G,N) --> nombre_propio(NP,G,N).
grupo_nominal_aux(gn(Det,Nom),G,N) --> determinante(Det,G,N),nombre(Nom,G,N).
grupo_nominal_aux(gn(Nom,CN),G,N) --> nombre(Nom,G,n),grupo_adjetival(CN,G,N).
grupo_nominal_aux(gn(CN,Nom),G,N) --> grupo_adjetival(CN,G,N),nombre(Nom,G,N).
grupo_nominal_aux(gn(Det,CN,Nom),G,N) --> determinante(Det,G,N),grupo_adjetival(CN,G,N),nombre(Nom,G,N).
grupo_nominal_aux(gn(Det,Nom,CN),G,N) --> determinante(Det,G,N),nombre(Nom,G,N),grupo_adjetival(CN,G,N).
grupo_nominal_aux(gn(Det,Nom,CN),G,N) --> determinante(Det,G,N),nombre(Nom,G,N),grupo_preposicional(CN).

% SINTAGMA VERBAL (gv)

grupo_verbal(gv(V),G,N) --> verbo(V,N).
grupo_verbal(gv(V,GV),G,N) --> verbo_copulativo(V,N),atributo(GV,G,N).
grupo_verbal(gv(V,GV),G,N) --> verbo(V,N),grupo_nominal(GV,_,N).
grupo_verbal(gv(V,GV1,GV2),G,N) --> verbo(V,N),grupo_nominal(GV1,_,N),grupo_preposicional(GV2).
grupo_verbal(gv(V,GV1,GV2),G,N) --> verbo(V,N),grupo_nominal(GV1,_,N),grupo_adjetival(GV2,G,N).
grupo_verbal(gv(V,GV),G,N) --> verbo_copulativo(V,N),grupo_adverbial(GV).
grupo_verbal(gv(V,GV),G,N) --> verbo(V,N),grupo_adjetival(GV,_,N).
grupo_verbal(gv(V,GV),G,N) --> verbo(V,N),grupo_preposicional(GV).
grupo_verbal(gv(V,GV),G,N) --> verbo(V,N),grupo_adverbial(GV).
grupo_verbal(gv(V,GV1,GV2),G,N) --> verbo(V,N),grupo_adverbial(GV1),grupo_nominal(GV2,_,N).
grupo_verbal(gv(V,GV1,GV2),G,N) --> verbo(V,N),grupo_preposicional(GV1),grupo_nominal(GV2,_,N).
grupo_verbal(gv(GV1,V,GV2),G,N) --> grupo_adverbial(GV1),verbo(V,N),grupo_preposicional(GV2).
grupo_verbal(gv(V,OrSub),G,N) --> verbo_copulativo(V,N),oracion_subordinada(OrSub).

% SINTAGMA PREPOSICIONAL (gp)

grupo_preposicional(gp(Enlace,Termino)) --> preposicion(Enlace),grupo_nominal(Termino,_,_).

% SINTAGMA ADJETIVAL (gadj)

grupo_adjetival(gadj(Adj),G,N) --> adjetivo(Adj,G,N).
grupo_adjetival(gadj(Adj,CAdj),G,N) --> adjetivo(Adj,G,N),grupo_preposicional(CAdj).

% SINTAGMA ADVERBIAL (gadv)

grupo_adverbial(gadv(Adv1,Adv2,GPrep)) --> adverbio(Adv1),adverbio(Adv2),grupo_preposicional(GPrep). % muy lejos de Guadalajara
grupo_adverbial(gadv(Adv1,Adv2)) --> adverbio(Adv1),adverbio(Adv2). % muy rápidamente
grupo_adverbial(gadv(Adv)) --> adverbio(Adv). % lejos


% ATRIBUTO (única función implementada para diferenciar las oraciones copulativas)

atributo(atrib(GAdj),G,N) --> grupo_adjetival(GAdj,G,N). % soy lento de reflejos

% NEXOS

nexo(nexo(Nexo)) --> conjuncion(Nexo).
nexo(nexo(Nexo)) --> adverbio_nexo(Nexo).
nexo_sub(nexo(PrRel)) --> pronombre_relativo(PrRel).