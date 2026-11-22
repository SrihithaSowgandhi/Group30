#lang racket/base

; (my-length lst): the number of top-level elements of lst. Counts with an accumulator:
; 0 for '(), otherwise one more for each element of the rest of the list.
(define (my-length lst)
  (let loop ((rest lst) (count 0))
    (if (null? rest)
        count
        (loop (cdr rest) (+ count 1)))))
