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

; (insert-if-short x lst n): lst with x inserted at the front of every list, at every level of
; nesting, whose length (measured on the original list) is less than n. Each element of lst
; that is a list ('() included) is processed recursively and atoms are kept; then x is
; consed onto the front when (my-length lst) < n.
(define (insert-if-short x lst n)
  (let ((processed (my-map (lambda (e)
                             (if (or (pair? e) (null? e))
                                 (insert-if-short x e n)
                                 e))
                           lst)))
    (if (< (my-length lst) n)
        (cons x processed)
        processed)))
