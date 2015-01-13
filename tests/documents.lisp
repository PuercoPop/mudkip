(defpackage :mudkip/documents-test
  (:use :cl :prove :mudkip-test-mocks :mudkip/documents))
(in-package :mudkip/documents-test)

(ok (equalp (id (make-instance 'document))
            (id (make-instance 'document)))
    "Empty documents should have the same id.")

(ok (equalp (id (make-instance 'foo-doc :foo 2))
            (id (make-instance 'foo-doc :foo 2)))
    "Documents with the same content should have the same id.")

(isnt (equalp (id (make-instance 'foo-doc :foo 2))
             (id (make-instance 'foo-doc :foo 3)))
    "Documents with different content should have different ids.")

(ok (let* ((foo (make-instance 'foo-doc :foo 3))
             (old-id (id foo)))
        (setf (slot-value foo 'foo) 5)

      (not (equalp old-id (id foo))))
      "Documents should update the id when a slot changes.")

;; Document parsing
(diag "read-content sanity check.")
(let ((content (read-content
                +sample-post+
                "-----")))
  (is (getf content :title) "Sample Post")
  (is (getf content :date) "2014-14-31")
  (ok content))
