
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
