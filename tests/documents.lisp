(stefil:define-test-package :mudkip-documents
  (:use :cl :mudkip))
(in-package :mudkip-documents)

;; Test same documents with no slots SHA1 to the same thing. Test two documents
;; with slots to the same contents SHA1 to the same things and with different
;; contents to different things.

(deftest empty-documents-should-have-the-same-id ()
  (is (equalp (id (make-instance 'document))
              (id (make-instance 'document)))))
