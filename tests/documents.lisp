(defpackage :mudkip/documents-test
  (:use :cl :prove :mudkip-test-mocks :mudkip/documents))
(in-package :mudkip/documents-test)

(defparameter +sample-post+
    (uiop/pathname:merge-pathnames* #P"demo/dir-site/post/sample-post.md"
                                    +test-files-root+))

(ok (equalp (id (make-instance 'document))
            (id (make-instance 'document)))
    "Empty documents should have the same id.")

(ok (equalp (id (make-instance 'foo-doc :foo 2))
            (id (make-instance 'foo-doc :foo 2)))
    "Documents with the same content should have the same id.")

(isnt (equalp (id (make-instance 'foo-doc :foo 2))
             (id (make-instance 'foo-doc :foo 3)))
    "Documents with different content should have different ids.")

;; Document parsing
(diag "read-content sanity check.")
(let ((content (read-content
                +sample-post+
                "-----")))
  (is (getf content :title) "Sample Post")
  (is (getf content :date) "2014-14-31")
  (ok content))

(ok (parse-document +sample-post+ (find-class 'post)) "parse-post-document sanity check.")
