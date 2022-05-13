; Booleanos. Son los únicos lambda términos no currificados.

(define true (lambda (x y) x))

(define false (lambda (x y) y))

(define neg (lambda (x) (x false true)))
                         
(define and (lambda (x y) (x y false)))

(define or (lambda (x y) (x true y)))

; Pares ordenados
              
(define par (lambda (x)
              (lambda (y)
                (lambda (f) (f x y)))))

(define primero (lambda (p) (p true)))

(define segundo (lambda (p) (p false)))

;;;;; Combinador de punto fijo

(define Y
  (lambda (f)
    ((lambda (x) (f (lambda (v) ((x x) v))))
     (lambda (x) (f (lambda (v) ((x x) v)))))))

;;;;;; Orden en naturales y test de nulidad

(define esmenoroigualnat (lambda (n)
                             (lambda (m)
                                (escero ((restanat n) m)))))
                         
(define esmayoroigualnat (lambda (n)
                            (lambda (m)
                               (escero ((restanat m) n)))))
                         
(define esmenornat (lambda (n)
                     (lambda (m)
                       (and ((esmenoroigualnat n) m) (noescero ((restanat m) n))))))

(define esmayornat (lambda (n)
                     (lambda (m)
                       (and ((esmayoroigualnat n) m) (noescero ((restanat n) m))))))

(define esigualnat (lambda (n)
                     (lambda (m)
                       (and ((esmayoroigualnat n) m) ((esmenoroigualnat n) m)))))

(define escero (lambda (n)
                 ((n (lambda (x) false)) true)))

(define noescero (lambda (n)
                    (neg (escero n))))

; Aritmética natural. Se define también "comprobar" para poder hacer pruebas. Se definen algunos naturales para hacer comprobaciones. Se escriben en francés para distinguirlos de los enteros 
; que se escribirán en español.

(define zero (lambda (f)
               (lambda (x) x)))

(define sucesor (lambda (n)
                  (lambda (f)
                    (lambda (x)
                     (f((n f) x))))))

(define un (sucesor zero))

(define deux (sucesor un))

(define trois (sucesor deux))

(define quatre (sucesor trois))

(define cinq (sucesor quatre))

(define six (sucesor cinq))

(define sept (sucesor six))

(define huit (sucesor sept))

(define neuf (sucesor huit))

(define dix (sucesor neuf))

(define onze (sucesor dix))

(define douze (sucesor onze))

(define treize (sucesor douze))

(define quatorze (sucesor treize))

(define quinze (sucesor quatorze))

(define seize (sucesor quinze))

(define dix-sept (sucesor seize))

(define dix-huit (sucesor dix-sept))

(define dix-neuf (sucesor dix-huit))

(define vingt (sucesor dix-neuf))

;; Comprobar

(define comprobar (lambda (n)
                    ((n (lambda (x) (+ 1 x))) 0)))

;; Suma naturales

(define sumnat (lambda (n)
                 (lambda (m)
                   ((n (lambda (x) (sucesor x))) m))))

;; Producto naturales

(define prodnat (lambda (n)
                   (lambda (m)
                     (lambda (f)
                       (lambda (x) ((m (n f)) x))))))
                     
(define prefn (lambda (f)
                (lambda (p)
                  ((par (f (primero p))) (primero p)))))

;; Predecesor y resta 

(define predecesor (lambda (n)
                     (lambda (f)
                       (lambda (x)
                            (segundo ((n ((lambda (g)
                                             (lambda (p) ((prefn g) p))) f)) ((par x) x)))))))
                         
(define restanat (lambda (n)
                     (lambda (m)
                        ((m (lambda (x) (predecesor x))) n))))                                                 

;; Resto de la división euclídea. Si el divisor es cero, devuelve false.

(define restonataux
    (lambda (n)
        (lambda (m)
            ((Y (lambda (f)
                 (lambda (x)
                    ((((esmayoroigualnat x) m)  
                        (lambda (no_use)
                            (f ((restanat x) m))
                        )
                        (lambda (no_use)
                            x
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                )
            ))
                n)  ; Pasa n como el valor inicial de x.
        )
))

(define restonat (lambda (n)
                      (lambda (m)
                        (((escero m) (lambda (no_use) false) (lambda (no_use) ((restonataux n) m))) zero))))

;; Cociente de la división euclídea. Al igual que el resto, devuelve false si se divide por cero.

(define cocientenataux
    (lambda (n)
        (lambda (m)
            ((Y (lambda (f)
                (lambda (x)
                    ((((esmayoroigualnat x) m)  
                        (lambda (no_use)
                            (sucesor (f ((restanat x) m)))  
                        )
                        (lambda (no_use)
                            zero
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                )
            ))
                n)  ; Pasa n como el valor inicial de x.
        )
    )
)

(define cocientenat (lambda (n)
                      (lambda (m)
                        (((escero m) (lambda (no_use) false) (lambda (no_use) ((cocientenataux n) m))) zero))))

;; Máximo común denominador.

(define mcdnat
    (lambda (n)
        (lambda (m)
            (((Y (lambda (f)
                   (lambda (x)
                     (lambda(y)
                      (((escero y)  
                       (lambda (no_use)
                            x
                        ) 
                       (lambda (no_use)
                            ((f y)((restonat x) y)) 
                        )
                        
                    )
                        zero)    ; Pasa zero como argumento de no_use
                ))
            ))
                n) ; Pasa n como el valor inicial de x.
          m)       ; Pasa m como el valor inicial de y.
    )
))

;;;; Paridad

(define par? (lambda (n)
               (escero ((restonat n) deux))))

(define cuadrado (lambda (n)
                   ((prodnat n) n)))


;;;;; Potencias de naturales usando algo binario.

(define potencianat
    (lambda (n)
        (lambda (m)
            ((Y (lambda (f)
                (lambda (y)
                    (((escero y)
                        (lambda (no_use)
                            un
                        )
                        (lambda (no_use)
                          (((par? y)
                           (lambda (no_use1)
                             (cuadrado (f ((cocientenat y) deux))))
                           (lambda (no_use1)
                             ((prodnat n) (f (predecesor y))))) zero)
                        )
                    )
                        zero)    ; Pasa zero como argumento de no_use
                )
            ))
                m)  ; Pasa n como el valor inicial de x.
        )
    )
)

;;;;;; Definición de algunos enteros. Se codifican los enteros mediante pares de naturales: el par (m,n) es una representación de m-n. Es obvio que varios
;;;;;; pares codifican el mismo entero. Por ejemplo, (7,5)=(9,7). Por lo tanto, los enteros se definen como el conjunto cociente de NxN mediante la relación 
;;;;;; de equivalencia R dada por
;;;;;;
;;;;;;                     (m,n) R (m',n') si y solo si m-n=m'-n'

(define cero ((par zero) zero))

(define -uno ((par zero) un))

(define -dos ((par zero) deux))

(define -tres ((par zero) trois))

(define -cuatro ((par zero) quatre))

(define -cinco ((par zero) cinq))

(define -seis ((par zero) six))

(define -siete ((par zero) sept))

(define -ocho ((par zero) huit))

(define -nueve ((par zero) neuf))

(define -diez ((par zero) dix))

(define -once ((par zero) onze))

(define -doce ((par zero) douze))

(define -trece ((par zero) treize))

(define -catorce ((par zero) quatorze))

(define -quince ((par zero) quinze))

(define -dieciseis ((par zero) seize))

(define -diecisiete ((par zero) dix-sept))

(define -dieciocho ((par zero) dix-huit))

(define -diecinueve ((par zero) dix-neuf))

(define -veinte ((par zero) vingt))

(define uno ((par un) zero))

(define dos ((par deux) zero))

(define tres ((par trois) zero))

(define cuatro ((par quatre) zero))

(define cinco ((par cinq) zero))

(define seis ((par six) zero))

(define siete ((par sept) zero))

(define ocho ((par huit) zero))

(define nueve ((par neuf) zero))

(define diez ((par dix) zero))

(define once ((par onze) zero))

(define doce ((par douze) zero))

(define trece ((par treize) zero))

(define catorce ((par quatorze) zero))

(define quince ((par quinze) zero))

(define dieciseis ((par seize) zero))

(define diecisiete ((par dix-sept) zero))

(define dieciocho ((par dix-huit) zero))

(define diecinueve ((par dix-neuf) zero))

(define veinte ((par vingt) zero))

;;;;; Orden, valor absoluto y tests de nulidad, positividad y negatividad. 
;;;
;;; m-n > m'-n' si y solo si m+n' > m'+n e igual con el resto

(define esmayoroigualent (lambda (r)
                           (lambda (s)
                             ((esmayoroigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r)))))) 

(define esmenoroigualent (lambda (r)
                           (lambda (s)
                             ((esmenoroigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esmayorent (lambda (r)
                           (lambda (s)
                             ((esmayornat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esmenorent (lambda (r)
                           (lambda (s)
                             ((esmenornat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define esigualent (lambda (r)
                           (lambda (s)
                             ((esigualnat ((sumnat (primero r)) (segundo s))) ((sumnat (primero s)) (segundo r))))))

(define absoluto (lambda (r)
                    (((esmayoroigualnat (primero r)) (segundo r)) ((par ((restanat (primero r)) (segundo r))) zero) ((par ((restanat (segundo r)) (primero r))) zero))))

(define negativo (lambda (r)
                   ((esmenorent r) cero)))

(define positivo (lambda (r)
                   ((esmayorent r) cero)))

(define esceroent (lambda (r)
                     ((esigualnat (primero r)) (segundo r))))
                      
(define noesceroent (lambda (r)
                       (neg (esceroent r))))

;;;;; Reducción a representante canónico de la clase de equivalencia.

(define reducir (lambda (r)
                  (((esmayoroigualnat (primero r)) (segundo r)) 
                        ((par ((restanat (primero r)) (segundo r))) zero)
                        ((par zero) ((restanat (segundo r)) (primero r))))))

;;;;; Aritmética entera. La respuesta está siempre dada por el representante canónico de la clase de equivalencia. 

(define testenteros (lambda (r)
                      (- (comprobar (primero r)) (comprobar (segundo r)))))

(define sument (lambda (r)
                  (lambda (s)
                    (reducir ((par ((sumnat (primero r)) (primero s))) ((sumnat (segundo r)) (segundo s)))))))

(define prodent (lambda (r)
                  (lambda (s)
                    (reducir ((par ((sumnat ((prodnat (primero r)) (primero s))) ((prodnat (segundo r)) (segundo s))))
                          ((sumnat ((prodnat (primero r)) (segundo s))) ((prodnat (segundo r)) (primero s))))))))                       

(define restaent (lambda (r)
                   (lambda (s)
                     (reducir ((par ((sumnat (primero r)) (segundo s))) ((sumnat (segundo r)) (primero s)))))))

(define opuesto (lambda (r)
                  ((par (segundo r)) (primero r))))

;; Lo siguiente reduce la división de enteros a división de naturales. Si m mayor o igual que 0 y n > 0, y si q y r son cociente y resto de la división de m entre n, se tiene
;;  m  = q       * n        + r
;;  m  = (-q)    * (-n)     + r
;; -m  = (-(q+1))* n        + (n-r)
;; -m  = (q+1)   * (-n)     + (n-r),
;; siempre y cuando el resto no sea cero. Cuando el divisor es cero, la función cocienteent devuelve false.

(define cocienteent_aux (lambda (r)
                          (lambda (s)
                            ((cocientenat (primero (absoluto r))) (primero (absoluto s))))))

; Caso1: resto cero. Si m= q*n, entonces -m= (-q)*n, -m = q* (-n) y m= (-q)*(-n).

(define cocienteentaux-caso1 (lambda (r)
                               (lambda (s)
                                  ((or (and ((esmayoroigualent r) cero) (positivo s)) (and (negativo r) (negativo s))) ((par ((cocientenat (primero (absoluto r))) (primero (absoluto s)))) zero)
                                                                                                                       ((par zero) ((cocientenat (primero (absoluto r))) (primero (absoluto s))))))))
                              
; Caso 2: resto no nulo

(define cocienteentaux-caso2 (lambda (r)
                                (lambda (s)
                                    (((esmayoroigualent r) cero) ((positivo s) ((par ((cocienteent_aux r) s)) zero) ((par zero) ((cocienteent_aux r) s)))
                                                                 ((positivo s) ((par zero) (sucesor ((cocienteent_aux r) s))) ((par (sucesor ((cocienteent_aux r) s))) zero))))))
; Cociente cuando no hay división por cero

(define cocienteentaux (lambda (r)
                         (lambda (s)
                           ((escero ((restonat (primero (absoluto r))) (primero (absoluto s)))) ((cocienteentaux-caso1 r) s) ((cocienteentaux-caso2 r) s)))))

; Cociente considerando la división por cero

(define cocienteent (lambda (r)
                      (lambda (s)
                        (((esceroent s) (lambda (no_use) false) (lambda (no_use) ((cocienteentaux r) s))) zero))))

; Resto. Si se divide por cero, devuelve false

(define restoentaux1 (lambda (r)
                        (lambda (s)
                          ((or (and ((esmayoroigualent r) cero) (positivo s)) (and ((esmayoroigualent r) cero) (negativo s))) ((par ((restonat (primero (absoluto r))) (primero (absoluto s)))) zero)
                                                                                                           ((par ((restanat (primero (absoluto s)))((restonat (primero (absoluto r))) (primero (absoluto s))))) zero)))))

(define restoentaux (lambda (r)
                       (lambda (s)
                          ((escero ((restonat (primero (absoluto r))) (primero (absoluto s)))) cero ((restoentaux1 r) s)))))

(define restoent (lambda (r)
                      (lambda (s)
                        (((esceroent s) (lambda (no_use) false) (lambda (no_use) ((restoentaux r) s))) zero))))

;; Como mcd (r,s)=mcd(|r|,|s|), se tiene

(define mcdent (lambda (r)
                 (lambda (s)
                   ((par ((mcdnat (primero (absoluto r))) (primero (absoluto s)))) zero))))

;; Mínimo común múltiplo

(define mcment (lambda (r)
                 (lambda (s)
                   ((cocienteent ((prodent r) s)) ((mcdent r) s)))))



#| -------------------------------------------------------------------------------------------------------------------------------------
  *    PRACTICA DE LABORATORIO 3: λ CALCULO
  *        David Moreno Lopez
  *        Javier Garcia Jimenez
  *        Isabel Martinez Gomez
 ------------------------------------------------------------------------------------------------------------------------------------- |#

;; Recibe como parametro un numero racional y devuelve un procedimiento que dice si dicho numero es cero o no
(define escero_racional (lambda (x)
                          ((esigualent (primero x)) cero)))

;; Recibe como parametros dos numeros racionales y devuelve un procedimiento que calcula el cociente de las mismas
(define cociente_racionales (lambda (x)
                              (lambda (y)
                                ((par ((prodent (primero x)) (segundo y)))
                                      ((prodent (segundo x)) (primero y))))))

(define test_racionales (lambda (r)
                          (list (testenteros(primero r)) (testenteros(segundo r)))))

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    Reduccion a representante canonico
 ------------------------------------------------------------------------------------------------------------------------------------- |#

;; Recibe como parametro un numero racional y devuelve un procedimiento que reduce dicho numero a forma canonica
(define reducir_canonico (lambda (x)
                          ((par((cocienteent (primero x)) ((mcdent (primero x)) (segundo x))))
                           ((cocienteent (segundo x)) ((mcdent (primero x)) (segundo x))))))


#| -------------------------------------------------------------------------------------------------------------------------------------
  *    ARITMETICA:
  *    Suma de racionales
  *    Producto de racionales
  *    Resta de racionales
  *    Calculo inverso
 ------------------------------------------------------------------------------------------------------------------------------------- |#

;; Recibe como parametros dos numeros racionales y devuelve un procedimiento que calcula la suma de los mismos
(define suma_racionales (lambda (n)
                          (lambda (m)
                            (reducir_canonico
                             ((par
                               ((sument
                                 ((prodent (primero n)) ((cocienteent ((mcment (segundo n)) (segundo m))) (segundo n))))
                                ((prodent (primero m)) ((cocienteent ((mcment (segundo n)) (segundo m))) (segundo m)))))
                              ((mcment (segundo n)) (segundo m)))))))

;; Recibe como parametros dos numeros racionales y devuelve un procedimiento que calcula el producto de los mismos
(define prod_racionales (lambda (n)
                          (lambda (m)
                            (reducir_canonico
                             ((par
                                 ((prodent (primero n)) (primero m)))
                                 ((prodent (segundo n)) (segundo m)))))))


;; Recibe como parametros dos numeros racionales y devuelve un procedimiento que calcula la resta de ambos
(define resta_racionales (lambda (n)
                          (lambda (m)
                            (reducir_canonico
                             ((par
                               ((restaent
                                 ((prodent (primero n)) ((cocienteent ((mcment (segundo n)) (segundo m))) (segundo n))))
                                ((prodent (primero m)) ((cocienteent ((mcment (segundo n)) (segundo m))) (segundo m)))))
                              ((mcment (segundo n)) (segundo m)))))))


;; Recibe como parametro un numero racional y devuelve un procedimiento que calcula su inverso
(define inverso_racionales (lambda (n)
                             ((par
                               (segundo n))
                              (primero n))))



#| -------------------------------------------------------------------------------------------------------------------------------------
  *    RELACIONES DE ORDEN E IGUALDAD:
  *    Es igual
  *    Mayor que
  *    Mayor o igual que
  *    Menor que
  *    Menor o igual que
 ------------------------------------------------------------------------------------------------------------------------------------- |#

#|
  * Recibe como parametro dos pares
  * Determina si un numero racional es igual que otro
  * Se reduce a forma canonica y se comparan para determinar si son iguales o no.
|# 
(define esigual_racional (lambda (n)
                             (lambda (m)
                               (and((esigualent (primero(reducir_canonico ((par (primero n)) (segundo n)))))
                                    (primero(reducir_canonico ((par (primero m)) (segundo m)))))
                                   ((esigualent (segundo(reducir_canonico ((par (primero n)) (segundo n)))))
                                    (segundo(reducir_canonico ((par (primero m)) (segundo m)))))))))

#|
  * Recibe como parametro dos pares
  * Determina si un numero racional es mayor que otro
  * Realiza una resta del primer numero racional frente al segundo y si dicha resta es mayor que cero, el primer numero
  * es mayor que el otro, en caso contrario, es menor.
|# 
(define mayor_racional (lambda (n)
                             (lambda (m)
                               ((esmayorent (primero((resta_racionales ((par (primero n))(segundo n))) ((par (primero m))(segundo m))))) cero))))

#|
  * Recibe como parametro dos pares
  * Determina si un numero racional es mayor o igual que otro
  * Realiza una resta del primer numero racional frente al segundo y si dicha resta es mayor o igual que cero, el primer numero
  * es mayor o igual que el otro, en caso contrario, es menor.
|# 
(define mayoroigual_racional (lambda (n)
                             (lambda (m)
                               ((esmayoroigualent (primero((resta_racionales ((par (primero n))(segundo n))) ((par (primero m))(segundo m))))) cero))))

#|
  * Recibe como parametro dos pares
  * Determina si un numero racional es menor que otro
  * Realiza una resta del primer numero racional frente al segundo y si dicha resta es menor que cero, el primer numero
  * es menor que el otro, en caso contrario, es mayor.
|# 
(define menor_racional (lambda (n)
                             (lambda (m)
                               ((esmenorent (primero((resta_racionales ((par (primero n))(segundo n))) ((par (primero m))(segundo m))))) cero))))

#|
  * Recibe como parametro dos pares
  * Determina si un numero racional es menor o igual que otro
  * Realiza una resta del primer numero racional frente al segundo y si dicha resta es menor o igual que cero, el primer numero
  * es menor o igual que el otro, en caso contrario, es mayor.
|# 
(define menoroigual_racional (lambda (n)
                             (lambda (m)
                               ((esmenoroigualent
                                 (primero((resta_racionales ((par (primero n))(segundo n))) ((par (primero m))(segundo m)))))
                                cero))))



#| -------------------------------------------------------------------------------------------------------------------------------------
  *    CODIFICACION DE MATRICES 2x2 EN R MEDIANTE λ TERMINOS:
  *    Suma de matrices
  *    Producto de matrices
  *    Determinante
  *    Decision sobre inversibilidad, calculo de inversa y rango
  *    Calculos de potencias naturales de matrices (usando el algoritmo binario)
 ------------------------------------------------------------------------------------------------------------------------------------- |#

(define definir_matriz (lambda (a)
                         (lambda (b)
                           (lambda (c)
                             (lambda (d)
                               ((par ((par a) b)) ((par c) d)))))))


(define test_matriz (lambda (m)
                        (list (list (test_racionales (primero (primero m))) (test_racionales (segundo (primero m))))
                              (list (test_racionales (primero (segundo m))) (test_racionales (segundo (segundo m))))
                        )
                      )
)

(define identidad ((((definir_matriz ((par uno) uno)) ((par cero) uno)) ((par cero) uno)) ((par uno) uno)))
(define matriz_nula ((((definir_matriz ((par cero) uno)) ((par cero) uno)) ((par cero) uno)) ((par cero) uno)))
(define matriz_prueba1 ((((definir_matriz ((par dos) cuatro)) ((par cuatro) cuatro)) ((par -uno) cuatro)) ((par cinco) cuatro)))
(define matriz_prueba2 ((((definir_matriz ((par uno) cuatro))   ((par -cuatro) seis))     ((par dos) ocho)) ((par -dos) tres)))
(define matriz_prueba3 ((((definir_matriz ((par uno) dos))   ((par -cuatro) dos))     ((par dos) dos)) ((par -tres) dos)))

#|
  * Recibe como parametro dos matrices
  * Devuelve un procedimiento que calcula la suma de ambos.
  * Para ello, define una matriz a partir de la suma de los elementos de cada una de las matrices recibidas como parametro,
  * posicion a posicion. Es decir, suma la primera posicion de la primera matriz con la primera posicion de la segunda matriz,
  * y asi sucesivamente con cada una de las poosiciones de las matrices.
|# 
(define suma_matrices (lambda (n)
                        (lambda (m)
                          ((((definir_matriz
                               ((suma_racionales(primero(primero n))) (primero(primero m))))
                             ((suma_racionales(segundo(primero n))) (segundo(primero m))))
                            ((suma_racionales(primero(segundo n))) (primero(segundo m))))
                           ((suma_racionales(segundo(segundo n))) (segundo(segundo m)))))))

#|
  * Recibe como parametro dos matrices
  * Devuelve un procedimiento que calcula el producto de ambas matrices.
  * Para ello, realiza el proceso de muiltiplicacion de matrices comun, multiplicando cada fila de la primera matriz por la
  * columna de la segunda matriz y definiendo una nueva matriz a partir de los resultados.
|# 
(define prod_matrices (lambda (n)
                        (lambda (m)
                          ((((definir_matriz
                               ((suma_racionales
                                 ((prod_racionales (primero(primero m))) (primero(primero n))))
                                 ((prod_racionales (segundo(primero m))) (primero(segundo n)))))
                               ((suma_racionales
                                 ((prod_racionales (primero(primero m))) (segundo(primero n))))
                                 ((prod_racionales (segundo(primero m))) (segundo(segundo n)))))
                               ((suma_racionales
                                 ((prod_racionales (primero(segundo m))) (primero(primero n))))
                                 ((prod_racionales (segundo(segundo m))) (primero(segundo n)))))
                               ((suma_racionales
                                 ((prod_racionales (primero(segundo m))) (segundo(primero n))))
                                 ((prod_racionales (segundo(segundo m))) (segundo(segundo n))))))))

#|
  * Recibe como parametro una matriz 
  * Devuelve un procedimiento que calcula el cuadrado de la matriz que recibe.
|#
(define cuadrado_matrices (lambda (m)
                            ((((definir_matriz
                                 ((suma_racionales
                                   ((prod_racionales (primero(primero m))) (primero(primero m))))
                                  ((prod_racionales (segundo(primero m))) (primero(segundo m)))))
                               ((suma_racionales
                                 ((prod_racionales (primero(primero m))) (segundo(primero m))))
                                ((prod_racionales (segundo(primero m))) (segundo(segundo m)))))
                              ((suma_racionales
                                ((prod_racionales (primero(segundo m))) (primero(primero m))))
                               ((prod_racionales (segundo(segundo m))) (primero(segundo m)))))
                             ((suma_racionales
                               ((prod_racionales (primero(segundo m))) (segundo(primero m))))
                              ((prod_racionales (segundo(segundo m))) (segundo(segundo m)))))))


#|
  * Recibe como parametro una matriz
  * Devuelve un procedimiento que calcula el determinante de una matriz
  * Como las matrices son 2 x 2, el determinante es la resta de los elementos de la primera diagonal multiplicados entre si,
    menos los elementos de la segunda diagonal multiplicados entre si
|#
(define determinante (lambda(m)
                       ((resta_racionales
                         ((prod_racionales (primero(primero m))) (segundo(segundo m))))
                         ((prod_racionales (segundo(primero m))) (primero(segundo m))))))

#|
 * Recibe como parametro una matriz
 * Devuelve un procedimiento con la inversa de la matriz recibida
 * Al ser una matriz de 2x2, se cumple que la matriz  a b   al hacer la adjunta y despues la transpuesta de la adjunta
 *                                                    c d
 * queda siempre como  d -b   por lo que lo hemos implementado de forma bruta
 *                    -c  a
|#
(define inversa (lambda (m)
                  ((((definir_matriz
                       ((prod_racionales
                         (segundo(segundo m)))
                        ((cociente_racionales ((par uno)uno)) ((par (primero(determinante m))) (segundo(determinante m))))))
                     ((prod_racionales
                       ((resta_racionales(segundo(primero m))) ((prod_racionales ((par dos) uno)) (segundo(primero m)))))
                      ((cociente_racionales ((par uno)uno)) ((par (primero(determinante m))) (segundo(determinante m))))))
                    ((prod_racionales
                      ((resta_racionales(primero(segundo m))) ((prod_racionales ((par dos) uno)) (primero(segundo m)))))
                     ((cociente_racionales ((par uno)uno)) ((par (primero(determinante m))) (segundo(determinante m))))))
                  ((prod_racionales
                    (primero(primero m)))
                   ((cociente_racionales ((par uno)uno)) ((par (primero(determinante m))) (segundo(determinante m))))))))

;; Recibe como parametro una matriz y devuelve un procedimiento que dice si dicha matriz es inversible o no
(define inversa? (lambda (m)
                   (neg(escero_racional (determinante m)))))


;; Recibe como parametro una matriz y devuelve un procedimiento que dice si una matriz es nula o no
(define matriz_nula? (lambda (n)
                       (and
                        (and(escero_racional (primero(primero n)))
                            (escero_racional (segundo(primero n))))
                        (and(escero_racional (primero(segundo n)))
                            (escero_racional (segundo(segundo n)))))))

;; Recibe como parametro una matriz y devuelve un procedimiento que calcula el rango de la misma
(define rango (lambda (m)
                ((matriz_nula? m) cero
                                  ((escero_racional(determinante m)) uno dos))))


;; Recibe como parametro un numero y devuelve un procedimiento que dice si dicho numero es par o no
(define espar? (lambda (x)
                 (escero((restonat x)deux))))


#|
  * Recibe como parametros una matriz y un numero
  * Calcula la matriz resultante de elevar una matriz a un numero natural
  * Devuelve un procedimiento que calcula cual seria la matriz resultado al elevar la matriz parametro al numero parametro siguiendo
    el algoritmo recursivo de la exponenciacion binaria.
|#
(define potencia_matrices
  (lambda (m) ; Argumento 1 (matriz)
    (lambda (n) ; Argumento 2 (numero a elevar la matriz)
      ((Y (lambda (f) ; Llamada a Y, f es la funcion auxiliar
            (lambda (x) ; Argumento 1 de la funcion auxiliar
              ((((esigualnat x)un) ; Condicion de recursividad: Si x es 1, devolvemos la matriz
                (lambda (no_use) ; Caso base, necesario envolverlo en un lambda con argumento no_use
                  m
                 )
                ((espar? x) ; Condicion de recursividad, si x es par
                 (lambda (no_use) ; Caso recursivo, necesario envolverlo en un lambda con argumento no_use
                   (cuadrado_matrices (f ((cocientenat x)deux)))
                 )
                 (lambda (no_use) ; Condicion de recursividad, si x es impar
                   ((prod_matrices m) (f ((restanat x) un))))))
               zero) ; Pasa zero como argumento de no_use
              )))
       n) ; Pasa m como el valor inicial de x.
)))
  

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    PRUEBAS:
  *    Pruebas de operaciones con racionales
  *    Pruebas de operaciones con matrices racionales
  *    Prueba completa
 ------------------------------------------------------------------------------------------------------------------------------------- |#

(define (pruebaRacionales)
  (display "------------------------ PRUEBA RACIONALES ------------------------\n")
  (display "\nReduccion a representante canonico de (2/4):  ")
  (display (test_racionales(reducir_canonico ((par dos) cuatro))))
  (display "\n¿Es cero el racional (1/1)? ")
  (display "\n¿Es cero el racional (0/1)? ")
  (display (escero_racional ((par cero) uno)))
  (display "\n¿Es cero el racional (1/1)? ")
  (display (escero_racional ((par uno) uno)))
  (display "\n¿Es igual (1/2) que (2/4)? ")
  (display ((esigual_racional ((par uno) dos)) ((par dos) cuatro)))
  (display "\n¿Es mayor (3/4) que (3/5)? ")
  (display ((mayor_racional ((par tres) cuatro)) ((par tres) cinco)))
  (display "\n¿Es mayor o igual (3/4) que (3/4)? ")
  (display ((mayoroigual_racional ((par tres) cuatro)) ((par tres) cuatro)))
  (display "\n¿Es menor (3/4) que (3/5)? ")
  (display ((menor_racional ((par tres) cuatro)) ((par tres) cinco)))
  (display "\n¿Es menor o igual (3/4) que (3/4)? ")
  (display ((menoroigual_racional ((par tres) cuatro)) ((par tres) cuatro)))
  (display "\nSuma de racionales (1/2)+(1/2) = ")
  (display (test_racionales ((suma_racionales ((par uno) dos)) ((par uno) dos))))
  (display "\nSuma de racionales (3/4)+(4/3) = ")
  (display (test_racionales ((suma_racionales ((par tres) cuatro)) ((par cuatro) tres))))
  (display "\nResta de racionales (7/5)+(4/5) = ")
  (display (test_racionales ((suma_racionales ((par siete) cinco)) ((par cuatro) cinco))))
  (display "\nProducto de racionales (1/2)+(4/1) = ")
  (display (test_racionales ((suma_racionales ((par uno) dos)) ((par cuatro) uno))))
  (display "\nProducto de racionales (1/5)+(4/2) = ")
  (display (test_racionales ((suma_racionales ((par uno) cinco)) ((par cuatro) dos))))
  (display "\nInverso del racional (3/7) = ")
  (display (test_racionales (inverso_racionales ((par tres) siete)))))

(define (pruebaMatricesRacionales)
  (display "\n\n------------------------ PRUEBA MATRICES RACIONALES ------------------------\n")
  (display "\nMatriz identidad: ")
  (display (test_matriz identidad))
  (display "\nMatriz prueba 1: ")
  (display(test_matriz matriz_prueba1))
  (display "\n Matriz prueba 2: ")
  (display (test_matriz matriz_prueba2))
  (display "\n¿Es inversible la matriz de prueba 1?: ")
  (display(inversa? matriz_prueba1))
  (display "\n¿Es inversible la matriz de prueba 2?: ")
  (display (inversa? matriz_prueba2))
  (display "\nDeterminante matriz de prueba 1: ")
  (display (test_racionales (determinante matriz_prueba1)))
  (display "\nDeterminante matriz de prueba 2: ")
  (display (test_racionales (determinante matriz_prueba2)))
  (display "\nMatriz de prueba 1 + Matriz de prueba 2: ")
  (display (test_matriz ((suma_matrices matriz_prueba1) matriz_prueba2)))
  (display "\nMatriz de prueba 1 x Matriz de prueba 2: ")
  (display (test_matriz ((prod_matrices matriz_prueba1) matriz_prueba2)))
  (display "\nMatriz de prueba 1 al cuadrado: ")
  (display (test_matriz (cuadrado_matrices matriz_prueba1)))
  (display "\nMatriz identidad elevado a la quinta con exponenciacion binaria: ")
  (display (test_matriz ((potencia_matrices identidad) cinq)))
  (display "\nMatriz de prueba 3 al cubo con exponenciacion binaria: ")
  (display (test_matriz ((potencia_matrices matriz_prueba3) trois)))
  (display "\nInversa de matriz de prueba 1: ")
  (display (test_matriz (inversa matriz_prueba1)))
  (display "\nMatriz de prueba 1 x Inversa de matriz de prueba 1: ")
  (display (test_matriz ((prod_matrices matriz_prueba1) (inversa matriz_prueba1))))
  (display "\nRango matriz prueba 1: ")
  (display (testenteros(rango matriz_prueba1)))
  (display "\nRango matriz prueba 2: ")
  (display (testenteros(rango matriz_prueba2)))
  (display "\nRango matriz nula: ")
  (display (testenteros(rango matriz_nula))))

(define (pruebaCompleta)
  (pruebaRacionales)
  (pruebaMatricesRacionales))

(pruebaCompleta)