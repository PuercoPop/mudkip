(defpackage #:mudkip/query-test
  (:use :cl :prove :mudkip/core :mudkip-test-mocks))
(in-package :mudkip/query-test)

(plan 11)
(diag "test-parse-slots-of-query-pattern")

(let ((internal-symbols '(slots-required-by-query-pattern
                          class-has-slots-p
                          expand-pattern))
      (package-to-import :mudkip/core/query))
  (diag
   (format nil "Importing some internal symbols from ~A " package-to-import))
  (dolist (s internal-symbols)
    (shadowing-import (find-symbol (symbol-name s) package-to-import))))


(ok (not (slots-required-by-query-pattern '(document))))
(ok (member 'author
            (slots-required-by-query-pattern '(document :author "LispLover"))
            :test #'string=))
(ok (member 'author
            (slots-required-by-query-pattern
             '(document :title "Hail Lisp" :author "LispLover"))
            :test #'string=))
(ok (member 'title
            (slots-required-by-query-pattern
             '(document :title "Hail Lisp" :author "LispLover"))
            :test #'string=))

(ok (class-has-slots-p (find-class 'document) '(id)))
(ok (not (class-has-slots-p (find-class 'document) '(foo))))

(ok (expand-pattern '(document)))
(is (expand-pattern '(document :id "1")) '(document :id "1"))
(is (car (expand-pattern '(document :title "Hai"))) 'or)
(ok (every #'listp (cdr (expand-pattern '(document :title "Hai")))))

(ok (query '(document :author "LispLover") +sample-doc-db+))

(finalize)
