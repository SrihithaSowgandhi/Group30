
; Test calls for S2. They are appended to code/Group30_q4.rkt by tests/run_s2.sh.
; (make-numbers n): the list (1 2 ... n), used to build large inputs.
(define (make-numbers n)
  (let loop ((i n) (acc '()))
    (if (= i 0) acc (loop (- i 1) (cons i acc)))))

; my-length
(display (my-length '())) (newline)
(display (my-length '(1 2 3))) (newline)
(display (my-length '((1 2) (3 4 5) (6) ()))) (newline)
(display (my-length '(a))) (newline)
(display (my-length (make-numbers 10000))) (newline)

; my-map
(display (my-map (lambda (x) (* x 2)) '(1 2 3))) (newline)
(display (my-map (lambda (x) (* x 2)) '())) (newline)
(display (my-map (lambda (x) (list x x)) '(a b))) (newline)
(display (my-length (my-map (lambda (x) (+ x 1)) (make-numbers 10000)))) (newline)
(display (car (my-map (lambda (x) (+ x 1)) (make-numbers 10000)))) (newline)

; insert-if-short (first version, using my-length and my-map)
; (nest d): a list nested d levels deep, innermost '(): '() for 0, ((())) for 2, and so on.
(define (nest d)
  (if (= d 0) '() (list (nest (- d 1)))))
(display (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3)) (newline)
(display (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3)) (newline)
(display (insert-if-short 7 '() 3)) (newline)
(display (insert-if-short 7 '() 0)) (newline)
(display (insert-if-short 'x '(a (b)) 5)) (newline)
(display (insert-if-short 'x '((1) ()) 1)) (newline)
(display (car (insert-if-short 'x (nest 100) 2))) (newline)
(display (my-length (insert-if-short 'x (make-numbers 10000) 10001))) (newline)
(display (my-length (insert-if-short 'x (make-numbers 10000) 10000))) (newline)
