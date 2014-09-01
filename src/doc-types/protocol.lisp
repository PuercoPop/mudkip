(in-package :mudkip)

(defgeneric parse-document (file doc-type)
  (:documentation "Read the contents of file an use them to initialize an
  object of class doc-type."))
