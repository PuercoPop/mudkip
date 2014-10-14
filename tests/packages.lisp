(defpackage :mudkip-tests
  (:use :cl :mudkip)
  (:import-from :alexandria :define-constant)
  (:import-from :asdf :system-relative-pathname)
  (:export
   #:foo-doc
   #:+test-files-root+
   #:+sample-doc-db+))
