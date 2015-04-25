(defpackage #:mudkip/query-constructor-test
  (:use :cl :prove #:mudkip/core :mudkip/query-constructor))

(in-package #:mudkip/query-constructor-test)

(is (construct-query (make-instance 'query-constructor))
    '(:document))

(is (construct-query (make-instance 'query-constructor :names '(:author))
                     "LispLover")
    '(:document :author "LispLover"))
