(defpackage :mudkip/doc-types-test
  (:use :cl :prove :mudkip-test-mocks :mudkip/doc-types))
(in-package :mudkip/doc-types-test)

(ok (parse-document +sample-post+ (find-class 'post)) "parse-post-document sanity check.")
