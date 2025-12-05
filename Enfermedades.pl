% --- Base de conocimiento 2  ---

% Síntomas asociados a Dengue
sintoma(dengue, fiebre_alta).
sintoma(dengue, dolor_muscular).
sintoma(dengue, dolor_articulaciones).
sintoma(dengue, dolor_cabeza).
sintoma(dengue, sarpullido).
sintoma(dengue, dolor_ojos).

% Síntomas asociados a Chikungunya
sintoma(chikungunya, fiebre_alta).
sintoma(chikungunya, dolorarticulacionesintenso).
sintoma(chikungunya, dolor_cabeza).
sintoma(chikungunya, nauseas).
sintoma(chikungunya, fatiga).
sintoma(chikungunya, sarpullido).

% Tratamientos básicos
tratamiento(dengue, [
'Reposo absoluto',
'Hidratación abundante',
'Paracetamol para la fiebre y dolor',
'Evitar aspirina o ibuprofeno'
]).

tratamiento(chikungunya, [
'Reposo',
'Hidratación',
'Paracetamol para dolor y fiebre',
'Compresas frías en articulaciones'
]).

% --- Reglas de diagnóstico probabilístico ---

% Contar síntomas coincidentes
contarcoincidencias([], , 0).
contar_coincidencias([S|Resto], Enfermedad, Conteo) :-
    sintoma(Enfermedad, S),
    contar_coincidencias(Resto, Enfermedad, ConteoResto),
    Conteo is ConteoResto + 1.
contar_coincidencias([S|Resto], Enfermedad, Conteo) :-
    \+ sintoma(Enfermedad, S),
    contar_coincidencias(Resto, Enfermedad, Conteo).

% Calcular porcentaje de coincidencia
porcentaje(SintomasPaciente, Enfermedad, Porcentaje) :-
    findall(S, sintoma(Enfermedad, S), ListaSintomas),
    length(ListaSintomas, Total),
    contar_coincidencias(SintomasPaciente, Enfermedad, Coincidentes),
    Porcentaje is (Coincidentes / Total) * 100.

% Diagnóstico: elegir enfermedad con mayor porcentaje
diagnosticar_prob(Sintomas, EnfermedadProbable, Porcentaje) :-
    porcentaje(Sintomas, dengue, PD),
    porcentaje(Sintomas, chikungunya, PC),
    (PD >= PC -> EnfermedadProbable = dengue, Porcentaje = PD
    ; EnfermedadProbable = chikungunya, Porcentaje = PC).

% Proponer tratamiento
proponer_tratamiento(Enfermedad, Tratamiento) :-
    tratamiento(Enfermedad, Tratamiento).


