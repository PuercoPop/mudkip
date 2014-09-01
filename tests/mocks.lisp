(in-package :mudkip-tests)

(define-constant +test-files-root+
    (system-relative-pathname :mudkip-tests "tests/") :test #'equal)

(defclass foo-doc (document)
  ((foo :initarg :foo :reader foo))
  (:documentation "A run of the mill document type."))
