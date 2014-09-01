(stefil:define-test-package :mudkip-documents
  (:use :cl :mudkip :mudkip-tests))
(in-package :mudkip-documents)

(deftest empty-documents-should-have-the-same-id ()
  (is (equalp (id (make-instance 'document))
              (id (make-instance 'document)))))

(deftest same-content-should-have-the-same-id ()
  (is (equalp (id (make-instance 'foo-doc :foo 2))
              (id (make-instance 'foo-doc :foo 2)))))

(deftest different-content-should-have-different-ids ()
  (is (not (equalp (id (make-instance 'foo-doc :foo 2))
                   (id (make-instance 'foo-doc :foo 3))))))
