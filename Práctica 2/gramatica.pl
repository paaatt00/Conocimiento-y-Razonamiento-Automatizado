% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 2 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% ____________________________ gramática _______________________________________________ %

:-consult(diccionario).

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
% grupo_nominal(GN1, Nexo, GN2) --> grupo_nominal_aux(GN1), nexo(Nexo), grupo_nominal_aux(GN2).

grupo_nominal_aux(gn(N)) --> nombre(N).
grupo_nominal_aux(gn(N)) --> pronombre(N).
grupo_nominal_aux(gn(N)) --> nombre_propio(N).
grupo_nominal_aux(gn(Det, N)) --> determinante(Det), nombre(N).
grupo_nominal_aux(gn(Det, N, Adj)) --> determinante(Det), nombre(N), adjetivo(Adj).
grupo_nominal_aux(gn(Det, N, Adj)) --> determinante(Det), adjetivo(Adj), nombre(N).
grupo_nominal_aux(gn(Det, N, GN)) --> determinante(Det), nombre(N), complemento_nombre(GN).
grupo_nominal_aux(gn(N1, Nexo, N2)) --> nombre_propio(N1), nexo(Nexo), nombre_propio(N2).

% SINTAGMA VERBAL (gv)

grupo_verbal(gv(V)) --> verbo(V).
grupo_verbal(gv(V, GV)) --> verbo(V), grupo_verbal_aux(GV).
grupo_verbal(gv(GV1, V, GV2)) --> grupo_verbal_aux(GV1), verbo(V), grupo_verbal_aux(GV2).
grupo_verbal(gv(V, GV1, GV2)) --> verbo(V), grupo_verbal_aux(GV1), grupo_verbal_aux(GV2).

grupo_verbal(gv(V, GV)) --> verbo_copulativo(V), grupo_verbal_aux(GV).
grupo_verbal(gv(V, GV)) --> verbo_copulativo(V), atributo(GV).

grupo_verbal_aux(GV) --> complemento_directo(GV).
grupo_verbal_aux(GV) --> complemento_circunstancial(GV).

% SINTAGMA PREPOSICIONAL (gp)

grupo_preposicional(gp(Enlace, Termino)) --> preposicion(Enlace), grupo_preposicional_aux(Termino).

grupo_preposicional_aux(gn(N)) --> nombre(N). % de reflejos
grupo_preposicional_aux(gn(N)) --> nombre_propio(N). % de Madrid
grupo_preposicional_aux(gn(Det, N)) --> determinante(Det), nombre(N). % con un tenedor
grupo_preposicional_aux(gn(Det, N, Adj)) --> determinante(Det), nombre(N), adjetivo(Adj). % con un tenedor grande
grupo_preposicional_aux(gn(Det1, N1, Nexo, Det2, N2)) --> determinante(Det1), nombre(N1), nexo(Nexo), determinante(Det2), nombre(N2). % con un tenedor y un cuchillo
grupo_preposicional_aux(gn(N1, Nexo, N2)) --> nombre_propio(N1), nexo(Nexo), nombre_propio(N2). % Juan y María
grupo_preposicional_aux(gn(Det, N, CN)) --> determinante(Det), nombre(N), complemento_nombre(CN). % a la feria del comic

% SINTAGMA ADJETIVAL (gadj)

grupo_adjetival(gadj(Adj)) --> adjetivo(Adj).
grupo_adjetival(gadj(Adj, CAdj)) --> adjetivo(Adj), complemento_adjetivo(CAdj).

% SINTAGMA ADVERBIAL (gadv)

grupo_adverbial(gadv(GAdv)) --> grupo_adverbial_aux(GAdv). 
grupo_adverbial(gadv(GAdv1, GAdv2)) --> grupo_adverbial_aux(GAdv1), grupo_adverbial_aux(GAdv2). % muy rápidamente
grupo_adverbial(gadv(GAdv1, GAdv2, GAdv3)) --> grupo_adverbial_aux(GAdv1), grupo_adverbial_aux(GAdv2), grupo_adverbial_aux(GAdv3). % muy lejos de Guadalajara

grupo_adverbial_aux(Adv) --> adverbio(Adv).
grupo_adverbial_aux(Adv) --> complemento_adverbio(Adv).

% COMPLEMENTO DEL NOMBRE (cn)

complemento_nombre(cn(Adj)) --> grupo_adjetival(Adj). 
complemento_nombre(cn(GPrep)) --> grupo_preposicional(GPrep).

% COMPLEMENTO DEL ADJETIVO (cadj)

complemento_adjetivo(cadj(GPrep)) --> grupo_preposicional(GPrep).

% COMPLEMENTO DEL ADVERBIO (cadv)

complemento_adverbio(cadv(GPrep)) --> grupo_preposicional(GPrep).

% COMPLEMENTO DIRECTO (cd)

complemento_directo(cd(GN)) --> grupo_nominal(GN). % tiene libros

% ATRIBUTO

atributo(atrib(GAdj)) --> grupo_adjetival(GAdj). % soy lento de reflejos

% COMPLEMENTO PREDICATIVO (cpred)

% COMPLEMENTO DE RÉGIMEN (creg)

% COMPLEMENTO CIRCUNSTANCIAL (cc)

complemento_circunstancial(cc(GAdv)) --> grupo_adverbial(GAdv).
complemento_circunstancial(cc(GPrep)) --> grupo_preposicional(GPrep).

% NEXOS

nexo(nexo(Conj)) --> conjuncion(Conj).