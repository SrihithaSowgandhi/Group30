#lang racket/base

; (my-length lst): the number of top-level elements of lst. Counts with an accumulator:
; 0 for '(), otherwise one more for each element of the rest of the list.
(define (my-length lst)
  (let loop ((rest lst) (count 0))
    (if (null? rest)
        count
        (loop (cdr rest) (+ count 1)))))

; (my-map f lst): the list of the results of applying f to each element of lst, in order.
; '() for '(), otherwise f of the first element consed onto the map of the rest.
(define (my-map f lst)
  (if (null? lst)
      '()
      (cons (f (car lst))
            (my-map f (cdr lst)))))
