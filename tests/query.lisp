(defpackage #:mudkip/query-test
  (:use #:cl #:prove #:mudkip/core #:mudkip-test-mocks))

(in-package #:mudkip/query-test)

(plan 3)

(is (length (query (document author "LispLover") +sample-doc-db+))
    2)
(is (length (query (document author "LispHater") +sample-doc-db+))
    1)
(is (length (query (document) +sample-doc-db+))
    3)

(finalize)
