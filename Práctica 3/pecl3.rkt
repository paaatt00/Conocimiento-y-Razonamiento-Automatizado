; Booleanos

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

; Aritmética natural. Se define también comprobar para verificar que la cosa va bien. Defino algunos naturales para hacer comprobaciones. Los escribo en francés para distinguirlos de los enteros 
; que escribiré en español.

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

(define comprobar (lambda (n)
                    ((n (lambda (x) (+ 1 x))) 0)))

(define sumnat (lambda (n)
                 (lambda (m)
                  ((n (lambda (x) (sucesor x))) m))))

(define prodnat (lambda (n)
                   (lambda (m)
                     (lambda (f)
                       (lambda (x) ((m (n f)) x))))))
                     
(define prefn (lambda (f)
                (lambda (p)
                  ((par (f (primero p))) (primero p)))))

(define predecesor (lambda (n)
                     (lambda (f)
                       (lambda (x)
                            (segundo ((n ((lambda (g)
                                             (lambda (p) ((prefn g) p))) f)) ((par x) x)))))))
                         
(define restanat (lambda (n)
                     (lambda (m)
                        ((m (lambda (x) (predecesor x))) n))))                                                 

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

(define restonat
    (lambda (n)
        (lambda (m)
            ((escero m) false ((restonataux n) m))
        )
    )
 )

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

(define cocientenat
  (lambda (n)
    (lambda (m)
      ((escero m)  false ((cocientenataux n) m))
     )
   )
 )

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

;;;;;; Definición de algunos enteros

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

;; Lo siguiente reduce la división de enteros a división de naturales. Si m \ge 0 y n> 0, y si q y r son cociente y resto de la división de m entre n, se tiene
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

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    PRACTICA DE LABORATORIO 3: λ CALCULO
  *        Laura Ramos Martínez
  *        Patricia Cuesta Ruiz
  *        Isabel Blanco Martínez
 ------------------------------------------------------------------------------------------------------------------------------------- |#

;; Definimos el módulo que se va a aplicar a todas las funciones como una "variable global".

(define mod seis)

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    CODIFICACIÓN DE ENTEROS
 ------------------------------------------------------------------------------------------------------------------------------------- |#

;; Convierte el número entero en una lista para imprimirlo por pantalla.

(define test_enteros (lambda (x) 
                       (list (testenteros(primero x)) (testenteros(segundo x)))))


#| -------------------------------------------------------------------------------------------------------------------------------------
  *    (a) Reducción a representante canónico.
 ------------------------------------------------------------------------------------------------------------------------------------- |#

;; Recibe como parámetro dos pares y devuelve el resto. 

(define representante_canonico (lambda (x)
                                 (lambda (p)
                                   ((restoent x) p))))

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    (b) ARITMETICA: suma y producto. 
 ------------------------------------------------------------------------------------------------------------------------------------- |#

;; Recibe como parámetros dos numeros enteros y devuelve un procedimiento que calcula la suma de los mismos.

(define suma_enteros (lambda (m)
                       (lambda (n)
                         ((representante_canonico ((sument m) n)) mod))))

;; Recibe como parámetros dos numeros enteros y devuelve un procedimiento que calcula la resta de los mismos.

(define resta_enteros (lambda (m)
                        (lambda (n)
                          ((representante_canonico ((restaent m) n)) mod))))

;; Recibe como parámetros dos numeros enteros y devuelve un procedimiento que calcula el producto de los mismos.

(define prod_enteros (lambda (m)
                       (lambda (n)
                         ((representante_canonico ((prodent m) n)) mod))))

;; Recibe como parámetros dos numeros enteros y devuelve un procedimiento que calcula el cociente de los mismos.

(define cociente_enteros (lambda(m)
                           (lambda (n)
                             ((representante_canonico ((cocienteent m) n)) mod))))

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    (c) Decisión sobre la inversibilidad y cálculo del inverso en el caso de que exista. 
 ------------------------------------------------------------------------------------------------------------------------------------- |#

;; Recibe como parametro un numero entero y devuelve un procedimiento que dice si dicho numero es cero o no. Si es cero no tiene inverso.

(define escero_enteros (lambda (x)
                         ((esigualent x) cero)))

;; Recibe como parámetro un número entero y devuelve un procedimiento que dice si tiene o no un inverso modular.

(define inversa_enteros? (lambda (x)
                           (((esigualent ((mcdent x) mod)) uno) true false)))

;; Recibe como parametro un número entero y devuelve un procedimiento que calcula su inverso.

(define inverso_enteros (lambda (n)
                          ((inversa_enteros? n)
                           ((calcular_inverso n) cero) ; inicializamos contador a 0
                           cero            
                           )))

;; Función recursiva para calcular el inverso: mediante un contador va a comprobar con cada numero hasta llegar al modulo la siguiente formula:
;; (A * A^-1) = 1 (un numero por su inverso es igual a 1) --> siendo A^-1 nuestro candidato (c).

(define calcular_inverso (lambda (n) ; definimos A
                           (lambda (c) ; definimos el contador para el candidato
                             (((Y (lambda (f) ; mediante combinador de punto fijo creamos funcion recursiva f
                                    (lambda(x) ; equivalente a n
                                      (lambda(y) ; equivalente a c
                                        ((((esmayoroigualent y) mod) ; si el contador es mayor o igual al modulo
                                          (lambda (no_use)
                                            cero)                ; devuelve 0                 
                                          (lambda (no_use)
                                            ((((esigualent uno)((representante_canonico ((prodent x)y)) mod)) ; sino, si es igual el modulo de el producto del numero por el candidato a inverso a 1, 
                                              ; quiere decir que ese valor es el inverso y lo retornamos
                                              (lambda (no_use)
                                                y)
                                              (lambda (no_use)
                                                ((f x)((sument y) uno)) ; aumentamos contador en 1
                                                )
                                              )cero))) cero) ; pasamos cero como parametro de no_use
                                        ))))
                               n)c))))                                 

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    PRUEBAS: pruebas de operaciones con racionales
 ------------------------------------------------------------------------------------------------------------------------------------- |#

(define (pruebaEnteros)
  (display "------------------------ PRUEBAS OPERACIONES DE ENTEROS ------------------------\n")
  (display "\n3 mod 7 = ")
  (display (testenteros ((representante_canonico tres) siete)))
  (display "\n20 mod 3 = ")
  (display (testenteros ((representante_canonico veinte) tres)))
  (display "\nSuma de enteros 2 + 3 = ")
  (display (testenteros ((suma_enteros dos) tres)))
  (display "\nResta de enteros 10 - 3 = ")
  (display (testenteros ((resta_enteros diez) tres)))
  (display "\nProducto de enteros 2 * 4 = ")
  (display (testenteros ((prod_enteros dos) cuatro)))
  (display "\nCociente de enteros 6 / 3 = ")
  (display (testenteros ((cociente_enteros seis) tres)))
  (display "\nInverso de 5 = ")
  (display (testenteros (inverso_enteros cinco)))
  (display "\n\n--------------------------------------------------------------------------------")
  )

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    CODIFICACIÓN DE MATRICES
 ------------------------------------------------------------------------------------------------------------------------------------- |#

(define testmatrices (lambda (m)
                       (list (list (testenteros (primero (primero m))) (testenteros (segundo (primero m))))
                             (list (testenteros (primero (segundo m))) (testenteros (segundo (segundo m)))))))

(define matriz (lambda (a)
                 (lambda (b)
                   (lambda (c)
                     (lambda (d)
                       ((par ((par a) b)) ((par c) d)))))))


(define identidad ((((matriz uno) cero) cero) uno))

(define matriz_nula ((((matriz cero) cero) cero) cero))

(define matriz_prueba1 ((((matriz dos) cuatro) -uno) cinco))

(define matriz_prueba2 ((((matriz uno) dos) dos) tres))

(define matriz_prueba3 ((((matriz dos) uno) -tres) dos))

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    (d) Suma y producto.
 ------------------------------------------------------------------------------------------------------------------------------------- |#

#|
  * Recibe como parametro dos matrices
  * Devuelve un procedimiento que calcula la suma de ambos. El modulo lo aplica en suma_enteros pasado de forma global.
|#

(define suma_matrices (lambda (m)
                        (lambda (n)
                          ((((matriz
                              ((suma_enteros (primero (primero m))) (primero (primero n))))
                             ((suma_enteros (segundo (primero m))) (segundo (primero n))))
                            ((suma_enteros (primero (segundo m))) (primero (segundo n))))
                           ((suma_enteros (segundo (segundo m))) (segundo (segundo n)))))))

#|
  * Recibe como parametro dos matrices
  * Devuelve un procedimiento que calcula el producto de ambas matrices.
|#

(define producto_matrices (lambda (m)
                            (lambda (n)
                              ((((matriz
                                  ((suma_enteros ((prodent (primero (primero m))) (primero (primero n)))) ((prodent (segundo (primero m))) (primero (segundo n)))))
                                 ((suma_enteros ((prodent (primero (primero m))) (segundo (primero n)))) ((prodent (segundo (primero m))) (segundo (segundo n)))))
                                ((suma_enteros ((prodent (primero (segundo m))) (primero (primero n)))) ((prodent (segundo (segundo m))) (primero (segundo n)))))
                               ((suma_enteros ((prodent (primero (segundo m))) (segundo (primero n)))) ((prodent (segundo (segundo m))) (segundo (segundo n))))))))

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    (e) Determinante
 ------------------------------------------------------------------------------------------------------------------------------------- |#

#|
  * Recibe como parametro una matriz.
  * Devuelve un procedimiento que calcula el determinante de una matriz.
  * Como las matrices son 2 x 2, el determinante es la resta de los elementos de la primera diagonal multiplicados entre sí,
    menos los elementos de la segunda diagonal multiplicados entre sí.
  * El módulo se aplica con la función representante_canónico pasándole el mod global.
|#

(define determinante (lambda (m)
                       ((representante_canonico ((restaent ((prodent (primero (primero m))) (segundo (segundo m))))
                                         ((prodent (segundo (primero m))) (primero (segundo m))))) mod)))

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    (f) Decisión sobre inversibilidad y cálculo de inversa y del rango.
 ------------------------------------------------------------------------------------------------------------------------------------- |#

#|
 * Dada una matriz y un número entero, devuelve un procedimiento con el resultado de la multiplicación de dicho número por todos
 * los elementos de la matriz.
|#

(define prod_escalar (lambda (m)
                       (lambda (n)
                         ((((matriz 
                             ((prod_enteros (primero (primero m))) n))
                            ((prod_enteros (segundo (primero m))) n))
                           ((prod_enteros (primero (segundo m))) n))
                          ((prod_enteros (segundo (segundo m))) n)))))

; Prueba: (testmatrices((prod_escalar matriz_prueba3) dos))

#|
 * Decisión sobre inversibilidad de una matriz dependiendo de si el determinante es 0 (si es 0 no tiene).
 * Devuelve un procedimiento con la inversa de la matriz recibida 
|#

(define inversa_matriz? (lambda (m)
                          ((esceroent (determinante m)) false true)))

; Prueba: (inversa_matriz? matriz_prueba1)

#|
 * Dada la matriz calcula la inversa. 
 * Si es 0 el determinante de la matriz devuelve matriz nula (no tiene inverso). Sino llama a inversa_matriz_aux para calcular su inversa.
|#

(define inversa_matriz (lambda (m)
                         ((esceroent (determinante m)) matriz_nula (inversa_matriz_aux m))))

; Prueba: (testmatrices(inversa_matriz matriz_prueba1)) --> no tiene inversa y sale nula
; Prueba: (testmatrices(inversa_matriz matriz_prueba2)) --> tiene inversa y convierte (-3, 2, 2, 1)

#|
 * Recibe como parametro una matriz
 * Multiplica el determinante por la matriz adjunta con el producto escalar.
 * Al ser una matriz de 2x2, se cumple que la matriz  a b   al hacer la adjunta y despues la transpuesta de la adjunta
 *                                                    c d
 * queda siempre como  d -b .
 *                    -c  a
|#

(define inversa_matriz_aux (lambda (m)
                             ((prod_escalar (matriz_traspuesta (matriz_adjunta m))) (inverso_enteros (determinante m)))))

#|
 * Recibe como parametro una matriz. 
 * Dada una matriz devuelve la matriz adjunta, que es la diagonal secundaria con los números en negativo.
|#

(define matriz_adjunta (lambda (m)                         
                         ((((matriz 
                             ((representante_canonico (segundo (segundo m)))mod))
                            ((representante_canonico ((restaent cero) (primero (segundo m))))mod))
                           ((representante_canonico ((restaent cero) (segundo (primero m))))mod))
                          ((representante_canonico (primero (primero m)))mod))
                         ))
; Prueba: (testmatrices(matriz_adjunta matriz_prueba1))

#|
 * Recibe como parametro una matriz. 
 * Dada una matriz devuelve la matriz traspuesta, intercambiando los valores a fuerza bruta mediante la creación de
 * una matriz nueva.
|#

(define matriz_traspuesta (lambda (m)
                             ((((matriz 
                                 (primero (primero m)))
                                (primero (segundo m)))
                               (segundo (primero m)))
                              (segundo (segundo m)))))

#|
 * Recibe como parametro una matriz. 
 * Recibe como parametro una matriz y mediante la comprobación de cada uno de sus elementos devuelve
 * true o false según la matriz sea nula o no.
|#

(define matriz_nula? (lambda (m)
                       ((esceroent ((representante_canonico (primero (primero m))) mod))
                        ((esceroent ((representante_canonico (segundo (primero m))) mod))
                         ((esceroent ((representante_canonico (primero (segundo m))) mod))
                          ((esceroent ((representante_canonico (segundo (segundo m))) mod)) true false) false) false) 
                        false)))

#|
 * Recibe como parametro una matriz. 
 * Procedimiento auxiliar que nos devuelve si el rango es uno o dos.
 * Usada para calcular el rango.
|#

(define rango_aux (lambda (m)
                    ((esceroent (determinante m)) uno dos)))

#|
 * Recibe como parametro una matriz. 
 * Dada una matriz calcula el rango de esta. 
 * Si es matriz nula devuelve cero directamente.
|#

(define rango (lambda (m)
                ((matriz_nula? m) cero (rango_aux m))))

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    (g) Cálculo de potencias(naturales) de matrices. Este cálculo se tiene que hacer usando el algoritmo binario para el
           cálculo de potencias, también conocido como exponenciación binaria.
 ------------------------------------------------------------------------------------------------------------------------------------- |#

#|
 * Recibe como parametro una matriz. 
 * Devuelve un procedimiento que calcula el cuadrado de una matriz dada.
|#

(define cuadrado_matrices (lambda (m)
                              ((producto_matrices m) m)))

#|
  * Recibe como parametros una matriz y un número.
  * Calcula la matriz resultante de elevar una matriz a un numero natural.
  * Devuelve un procedimiento que calcula cual seria la matriz resultado al elevar la matriz parametro al numero parametro siguiendo
    el algoritmo recursivo de la exponenciacion binaria.
|#

(define potencia_matrices (lambda (m)
                            (lambda (p)
                              ((Y (lambda (f) ; declaramos llamada recursiva como f, pasando el exponente 
                                    (lambda (e)                                      
                                      (((esceroent e) ; si el exponente es cero
                                        (lambda (no_use)                                          
                                          identidad ; devuelve la matriz identidad
                                          )                                        
                                        (lambda (no_use)                                          
                                          (((esceroent ((restoent e) dos)) ; si no es cero se comprueba si el exponente es par                                          
                                            (lambda (no_use)
                                              (cuadrado_matrices (f ((cocienteent e) dos)))) ; si es par se calcula el cuadrado de la matriz y se llama a recursion dividiendo entre 2 el exponente                                           
                                            (lambda (no_use)
                                              ((producto_matrices m)(f ((restaent e) uno))))) cero)  ; si es impar se multiplica la matriz por el valor del exponente menos uno
                                          )
                                        )
                                       cero)
                                      )
                                    ))
                               p)
                              )
                            )
  )

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    PRUEBAS: pruebas de operaciones con matrices
 ------------------------------------------------------------------------------------------------------------------------------------- |#

(define (pruebaMatrices)
  (display "------------------------ PRUEBAS DE MATRICES DE ENTEROS ------------------------\n")
  (display "\nMatriz identidad: ")
  (display (testmatrices identidad))
  (display "\nMatriz prueba 1: ")
  (display (testmatrices matriz_prueba1))
  (display "\nMatriz prueba 2: ")
  (display (testmatrices matriz_prueba2))
  (display "\nMatriz de prueba 1 + Matriz de prueba 2: ")
  (display (testmatrices ((suma_matrices matriz_prueba1) matriz_prueba2)))
  (display "\nMatriz de prueba 1 x Matriz de prueba 2: ")
  (display (testmatrices ((producto_matrices matriz_prueba1) matriz_prueba2)))
  (display "\nDeterminante matriz de prueba 2: ")
  (display (testenteros (determinante matriz_prueba2)))
  (display "\nRango matriz prueba 1: ")
  (display (testenteros (rango matriz_prueba1)))
  (display "\nRango matriz prueba 2: ")
  (display (testenteros (rango matriz_prueba2)))
  (display "\nRango matriz nula: ")
  (display (testenteros (rango matriz_nula)))
  (display "\nInversa matriz prueba 1: ")
  (display (testmatrices(inversa_matriz matriz_prueba1)))
  (display "\nInversa matriz prueba 2: ")
  (display (testmatrices(inversa_matriz matriz_prueba2))) 
  (display "\nMatriz prueba 1 ^ 2: ")
  (display (testmatrices((potencia_matrices matriz_prueba1) dos)))
  (display "\nMatriz prueba 2 ^ 3: ")
  (display (testmatrices((potencia_matrices matriz_prueba2) tres)))
  (display "\n\n------------------------------------------------------------------------------")
  )
