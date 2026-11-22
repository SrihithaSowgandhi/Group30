#lang racket/base

; (inorder-acc tree acc): the values of tree in inorder, followed by the list acc.
; For '() it is acc; otherwise: left subtree, then the node value, then the right
; subtree's values followed by acc. Built right to left with cons, so no append is needed.
(define (inorder-acc tree acc)
  (if (null? tree)
      acc
      (inorder-acc (cadr tree)
                   (cons (car tree)
                         (inorder-acc (caddr tree) acc)))))

; (print-inorder tree): prints the list of values of tree in inorder on one line.
(define (print-inorder tree)
  (display (inorder-acc tree '()))
  (newline))
