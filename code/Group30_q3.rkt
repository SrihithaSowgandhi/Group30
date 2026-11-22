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

; (preorder-acc tree acc): the values of tree in preorder, followed by the list acc.
; For '() it is acc; otherwise: the node value, then the left subtree's values, then the
; right subtree's values followed by acc. Built right to left with cons.
(define (preorder-acc tree acc)
  (if (null? tree)
      acc
      (cons (car tree)
            (preorder-acc (cadr tree)
                          (preorder-acc (caddr tree) acc)))))

; (postorder-acc tree acc): the values of tree in postorder, followed by the list acc.
; For '() it is acc; otherwise: the left subtree's values, then the right subtree's values,
; then the node value, then acc. Built right to left with cons.
(define (postorder-acc tree acc)
  (if (null? tree)
      acc
      (postorder-acc (cadr tree)
                     (postorder-acc (caddr tree)
                                    (cons (car tree) acc)))))

; (print-all-traversals tree): prints three lines: the inorder list, the preorder list and
; the postorder list of the values of tree, each followed by a newline.
(define (print-all-traversals tree)
  (display (inorder-acc tree '()))
  (newline)
  (display (preorder-acc tree '()))
  (newline)
  (display (postorder-acc tree '()))
  (newline))
