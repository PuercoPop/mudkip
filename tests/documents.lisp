(stefil:define-test-package :mudkip-documents
  (:use :cl :mudkip :mudkip-tests))
(in-package :mudkip-documents)

(defparameter +sample-post+
    (uiop/pathname:merge-pathnames* #P"demo/sample-post.md"
                                    +test-files-root+))

(deftest empty-documents-should-have-the-same-id ()
  (is (equalp (id (make-instance 'document))
              (id (make-instance 'document)))))

(deftest same-content-should-have-the-same-id ()
  (is (equalp (id (make-instance 'foo-doc :foo 2))
              (id (make-instance 'foo-doc :foo 2)))))

(deftest different-content-should-have-different-ids ()
  (is (not (equalp (id (make-instance 'foo-doc :foo 2))
                   (id (make-instance 'foo-doc :foo 3))))))

;; Document parsing

(deftest read-content-sanity-check ()
  (let ((content (read-content
                  +sample-post+
                  "-----")))
    (is (string= (getf content :title) "Sample Post"))
    (is (string= (getf content :date) "2014-14-31"))))

(deftest parse-post-document ()
  (parse-document +sample-post+ (find-class 'post)))
