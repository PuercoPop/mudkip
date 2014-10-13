(defpackage #:mudkip/documents/tree-test
  (:use :cl :mudkip/documents/tree :prove)
  (:import-from #:closer-mop #:class-precedence-list))
(in-package :mudkip/documents/tree-test)

(ok (build-inheritance-tree (find-class t)))
(is-error (build-inheritance-tree  t) 'simple-error) 

(let ((tree (build-inheritance-tree (find-class t))))
  (is (car (walk-collect tree (lambda (x) (eq x (find-class 'stream)))))
      (find-class 'stream))
  (ok (walk-collect tree (lambda (x) (member (find-class 'stream)
                                             (cdr (class-precedence-list x)))))))
