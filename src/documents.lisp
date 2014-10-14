(uiop:define-package #:mudkip/documents
  (:use :cl)
  (:use-reexport :mudkip/core/documents)
  (:import-from :closer-mop :slot-definition-name
                            :class-slots)
  (:import-from :ironclad :make-digest
                          :update-digest
                          :sha1-buffer)
  (:import-from :flexi-streams :string-to-octets)
  (:export
   #:post))
(in-package :mudkip/documents)

(defclass post (document)
  ((file :initarg :file :reader file)
   (date :initarg :date :reader date)
   (slug :initarg :slug :accessor slug)
   (text :initarg :text :accessor text))
  (:default-initargs :date nil :slug nil)
  (:documentation "Your run of the mill blog post."))


(defmethod render-text (text (format (eql :md)))
  (let ((3bmd-code-blocks:*code-blocks* t))
    (with-output-to-string (str)
      (3bmd:parse-string-and-print-to-stream text str))))
