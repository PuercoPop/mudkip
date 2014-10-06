(defpackage :mudkip-tests
  (:use :cl :fiasco :mudkip)
  (:import-from :alexandria :define-constant)
  (:import-from :asdf :system-relative-pathname)
  (:export
   #:foo-doc
   #:+test-files-root+
   #:+sample-doc-db+))
