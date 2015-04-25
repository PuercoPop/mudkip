(defpackage #:mudkip/router-test
  (:use :cl :prove :mudkip/core :mudkip/router :mudkip-test-mocks))

(in-package #:mudkip/router-test)

(plan 1)

(let ((router (make-instance 'router)))
  (ok (null (find-document router "/" +sample-doc-db+))
      "If nothing is found return nil.")
  (handler-case (find-document router "/" +sample-doc-db+)
    (route-not-found (s) 'foo)))

(finalize)
