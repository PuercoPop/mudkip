(defpackage :mudkip-tests
  (:use :cl :stefil :mudkip)
  (:import-from :alexandria :define-constant)
  (:import-from :asdf :system-relative-pathname)
  (:export
   #:foo-doc
   #:+test-files-root+))
