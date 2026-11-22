
; Test calls for S1. They are appended to code/Group30_q3.rkt by tests/run_s1.sh.
(define t1 '(4 (2 (1 () ()) (3 () ()))
               (6 (5 () ()) (7 () ()))))
(define t2 '(1 () (2 () (3 () ()))))
(define t3 '(a (b () ()) (c () ())))
(define t4 '(9 () ()))

(print-inorder t1)
(print-inorder t2)
(print-inorder t3)
(print-inorder t4)
(print-inorder '())

; preorder-acc (helper for print-all-traversals)
(display (preorder-acc t1 '())) (newline)
(display (preorder-acc t2 '())) (newline)
(display (preorder-acc t3 '())) (newline)
(display (preorder-acc t4 '())) (newline)
(display (preorder-acc '() '())) (newline)
