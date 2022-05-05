#| -------------------------------------------------------------------------------------------------------------------------------------
  *    PRACTICA DE LABORATORIO 3: λ CALCULO
  *        Laura Ramos Martínez
  *        Patricia Cuesta Ruiz
  *        Isabel Blanco Martínez
 ------------------------------------------------------------------------------------------------------------------------------------- |#

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    CODIFICACIÓN DE RACIONALES
 ------------------------------------------------------------------------------------------------------------------------------------- |#

(define test_racionales (lambda (x) ; Convierte el número racional en una lista para imprimirlo por pantalla
                          (list (testenteros(primero x)) (testenteros(segundo x)))))

;; Mínimo común múltiplo

(define mcment (lambda (r)
                 (lambda (s)
                   ((cocienteent ((prodent r) s)) ((mcdent r) s)))))

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    (a) Reducción a representante canonico
 ------------------------------------------------------------------------------------------------------------------------------------- |#

;; Recibe como parametro un numero racional y devuelve un procedimiento que reduce dicho numero a forma canonica

(define reducir_canonico (lambda (x)
                          ((par((cocienteent (primero x)) ((mcdent (primero x)) (segundo x))))
                           ((cocienteent (segundo x)) ((mcdent (primero x)) (segundo x))))))

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    (b) ARITMETICA: suma y producto de racionales 
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

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    (c) Decisión sobre la inversibilidad y cálculo del inverso en el caso de que exista. (Algoritmo extendido de Euclides)
 ------------------------------------------------------------------------------------------------------------------------------------- |#

;; Recibe como parametro un número racional y devuelve un procedimiento que calcula su inverso

(define inverso_racionales (lambda (n)
                             ((par
                               (segundo n))
                              (primero n))))

#| -------------------------------------------------------------------------------------------------------------------------------------
  *    PRUEBAS: pruebas de operaciones con racionales
 ------------------------------------------------------------------------------------------------------------------------------------- |#

(define (pruebaRacionales)
  (display "------------------------ PRUEBA RACIONALES ------------------------\n")
  (display "\nReduccion a representante canonico de (2/4):  ")
  (display (test_racionales(reducir_canonico ((par dos) cuatro))))
  (display "\nSuma de racionales (1/2)+(1/2) = ")
  (display (test_racionales ((suma_racionales ((par uno) dos)) ((par uno) dos))))
  (display "\nSuma de racionales (3/4)+(4/3) = ")
  (display (test_racionales ((suma_racionales ((par tres) cuatro)) ((par cuatro) tres))))
  (display "\nProducto de racionales (1/2)+(4/1) = ")
  (display (test_racionales ((suma_racionales ((par uno) dos)) ((par cuatro) uno))))
  (display "\nProducto de racionales (1/5)+(4/2) = ")
  (display (test_racionales ((suma_racionales ((par uno) cinco)) ((par cuatro) dos))))
  (display "\nInverso del racional (3/7) = ")
  (display (test_racionales (inverso_racionales ((par tres) siete)))))