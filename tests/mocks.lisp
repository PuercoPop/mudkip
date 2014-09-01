(in-package :mudkip-tests)

(defclass foo-doc (document)
  ((foo :initarg :foo :reader foo))
  (:documentation "A run of the mill document type."))
