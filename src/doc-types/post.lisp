(defpackage :mudkip/doc-types/post
  (:use :cl :mudkip/core)
  (:export
   #:post))
(in-package :mudkip/doc-types/post)

(defclass post (document)
  ((title :initarg :title :reader title)
   (date :initarg :date :reader date)
   (slug :initarg :slug :accessor slug)
   (text :initarg :text :accessor text))
  (:default-initargs :date nil :slug nil)
  (:documentation "Your run of the mill blog post."))

(defmethod parse-document (file (doc-type (eql (find-class 'post))))
  ;; TODO: Establish a proper path to config the separator
  (apply #'make-instance 'post (read-content file "-----")))
