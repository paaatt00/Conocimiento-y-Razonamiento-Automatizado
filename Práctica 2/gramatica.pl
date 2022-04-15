% ______________________________________________________________________________________ %

% -------------------------- PRÁCTICA 2 - CRA ------------------------------------------ %
% ______________________________________________________________________________________ %

% ____________________________ gramática _______________________________________________ %

:-consult(diccionario).

% ______________________________________________________________________________________ %

% ORACIONES

oracion(Oracion) --> oracion_simple(Oracion).
oracion(Oracion) --> oracion_compuesta(Oracion).

% ORACIÓN SIMPLE

oracion_simple(Oracion)   --> oracion_aux(Oracion).

oracion_aux(o(GN,GV)) --> grupo_nominal(GN), grupo_verbal(GV).
oracion_aux(oSO(GV)) --> grupo_verbal(GV). % sujeto omitido

% ORACIÓN COMPUESTA

% ORACIÓN COORDINADA

% ORACION SUBORDINADA

% ______________________________________________________________________________________ %

% SINTAGMA NOMINAL (gn)

grupo_nominal(GN) --> grupo_nominal_aux(GN).
grupo_nominal(GN1, Nexo, GN2) --> grupo_nominal_aux(GN1), nexo(Nexo), grupo_nominal_aux(GN2).

grupo_nominal_aux(gn(N)) --> nombre(N).
grupo_nominal_aux(gn(N)) --> pronombre(N).
grupo_nominal_aux(gn(N)) --> nombre_propio(N).
grupo_nominal_aux(gn(Det, N)) --> determinante(Det), nombre(N).
grupo_nominal_aux(gn(Det, N, Adj)) --> determinante(Det), nombre(N), adjetivo(Adj).

% SINTAGMA VERBAL (gv)

grupo_verbal(gv(V)) --> verbo(V).

% SINTAGMA PREPOSICIONAL (gp)

grupo_preposicional(gp(Enlace, Termino)) --> preposicion(Enlace), grupo_preposicional_aux(Termino).

grupo_preposicional_aux(gn(N)) --> nombre(N). % de reflejos
grupo_preposicional_aux(gn(N)) --> nombre_propio(N). % de Madrid
grupo_preposicional_aux(gn(Det, N)) --> determinante(Det), nombre(N). % con un tenedor
grupo_preposicional_aux(gn(Det, N, Adj)) --> determinante(Det), nombre(N), adjetivo(Adj). % con un tenedor grande

% SINTAGMA ADJETIVAL (gadj)

grupo_adjetival(gadj(Adj)) --> adjetivo(Adj).

% SINTAGMA ADVERBIAL (gadv)

grupo_adverbial(gadv(GAdv)) --> grupo_adverbialAux(GAdv).
grupo_adverbial(gadv(GAdv1, GAdv2)) --> grupo_adverbialAux(GAdv1), grupo_adverbialAux(GAdv2). % muy rápidamente

grupo_adverbialAux(Adv) --> adverbio(Adv).

% COMPLEMENTO DEL NOMBRE

complemento_nombre(cn(Adj)) --> grupo_adjetival(Adj). % la casa grande
complemento_nombre(cn(GPrep)) --> grupo_preposicional(GPrep).

% COMPLEMENTO DIRECTO

% COMPLEMENTO PREDICATIVO

% COMPLEMENTO DE RÉGIMEN

% COMPLEMENTO CIRCUNSTANCIAL (implemental tipos si hay tiempo)