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

; (print-insert-result): reads x, lst and n from standard input (in this order, with read),
; then prints (insert-if-short x lst n) with display, followed by a newline. Prints nothing else.
(define (print-insert-result)
  (let* ((x (read))
         (lst (read))
         (n (read)))
    (display (insert-if-short x lst n))
    (newline)))

; (make-inserter x len-ok?): a function of one argument (a list) that inserts x at the front of
; every list, at every level of nesting, whose length (measured on the original list) satisfies
; len-ok?, a function of one number. Inside, insert processes each element that is a list
; ('() included) recursively, keeps atoms, then conses x on when (len-ok? (my-length lst)).
(define (make-inserter x len-ok?)
  (letrec ((insert (lambda (lst)
                     (let ((processed (my-map (lambda (e)
                                                (if (or (pair? e) (null? e))
                                                    (insert e)
                                                    e))
                                              lst)))
                       (if (len-ok? (my-length lst))
                           (cons x processed)
                           processed)))))
    insert))

; (insert-if-short x lst n): lst with x inserted at the front of every list, at every level of
; nesting, whose length is less than n. It is the inserter made by make-inserter for x and the
; length test (< len n), applied to lst.
(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))
