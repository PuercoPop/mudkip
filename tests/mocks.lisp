(defpackage #:mudkip-test-mocks
  (:use :cl :mudkip/core)
  (:import-from :alexandria :define-constant)
  (:import-from :asdf :system-relative-pathname)
  (:export
   #:+test-files-root+
   #:foo-doc
   #:foo
   #:tittle
   #:author
   #:+sample-doc-db+
   #:+sample-post+))
(in-package :mudkip-test-mocks)

(define-constant +test-files-root+
    (system-relative-pathname :mudkip-tests "tests/") :test #'equal)

(defclass foo-doc (document)
  ((foo :initarg :foo :reader foo)
   (title :initarg :title :reader tittle)
   (author :initarg :author :reader author))
  (:documentation "A run of the mill document type."))

(defparameter +sample-doc-db+
  (let
      ((db (make-hash-table)))
    (flet ((add-document (document site)
             (setf (gethash (id document)  site)
                   document)))
      (add-document (make-instance 'foo-doc
                                   :title "I Love Lisp" :author "LispLover")
                    db)
      (add-document (make-instance 'foo-doc
                                   :title "Lisp Love Song" :author "LispLover")
                    db)
      (add-document (make-instance 'foo-doc
                                   :title "I hate Lisp" :author "LispHater")
                    db))
    db)
  "A document db to test against.")

(defparameter +sample-post+
    (uiop/pathname:merge-pathnames* #P"demo/dir-site/post/sample-post.md"
                                    +test-files-root+))
