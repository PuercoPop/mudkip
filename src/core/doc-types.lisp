(defpackage #:mudkip/core/doc-types
  (:use :cl)
  (:export
   #:parse-document))
(in-package :mudkip/core/doc-types)

(defgeneric parse-document (file doc-type)
  (:documentation "Read the contents of file an use them to initialize an
  object of class doc-type."))
