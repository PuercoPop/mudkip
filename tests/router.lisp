(fiasco:define-test-package :mudkip-router
    (:use :cl :mudkip :mudkip-tests))
(in-package :mudkip-router)


;;;; Test retrieve one document (it doesn't fail if there are more to retrieve), and retrieve various documents

;; All posts of Author LispLover

#+nil
(deftest query-by-author ()
  (let ((result (query (document :author "LispLover") +sample-doc-db+)))
    (mapcar (lambda (doc) (is (string= (author doc) "LispLover"))))))

#+nil
(foo-doc :title (ppcre ".*Love.*"))
#+nil
(foo-doc :author "LispHater")  
