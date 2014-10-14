(defpackage :mudkip/documents/query-test
  (:use :cl :prove :mudkip/documents/query))
(in-package :mudkip/documents/query-test)

(diag "test-parse-slots-of-query-pattern")

(let ((internal-symbols '(slots-required-by-query-pattern))
      (package-to-import :mudkip/documents/query))
  (diag
   (format nil "Importing some internal symbols from ~A " package-to-import))
  (dolist (s internal-symbols)
    (import (find-symbol (symbol-name s) package-to-import))))


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

(diag "test-class-or-descendents")

(is (find-class 'document) (class-or-descendents (find-class 'document) nil) "If ")
(is (find-class 'document) (class-or-descendents (find-class 'document) '(id)))
(ok (not (class-or-descendents (find-class 'document) '(fubar))) "There is not class that has fubar as a slot.")

(is (find-class 'foo-doc)
    (class-or-descendents (find-class 'document) '(title author))
    "If the base class doesn't have the required slots, look at their sub-classes.")

(finalize)
