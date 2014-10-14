(defpackage #:mudkip/documents
  (:use :cl)
  (:import-from :closer-mop :slot-definition-name
                            :class-slots)
  (:import-from :ironclad :make-digest
                          :update-digest
                          :sha1-buffer)
  (:import-from :flexi-streams :string-to-octets)
  (:export
   #:post))
(in-package :mudkip/documents)

(defmethod discover (doc-type site)
  ;; TODO: Shouldn't depend on file extension being lowercase.
  ((let ((file-type (format nil "~(~A~)" doc-type)))
     (loop
        :for directory :in (search-path site)
        :do
        (loop
           :for file :in (directory-files directory file-type)
           :do (add-object (read-content file)))))))

(defclass post (document)
  ((file :initarg :file :reader file)
   (date :initarg :date :reader date)
   (slug :initarg :slug :accessor slug)
   (text :initarg :text :accessor text))
  (:default-initargs :date nil :slug nil)
  (:documentation "Your run of the mill blog post."))


(defmethod render-text (text (format (eql :md)))
  (let ((3md-code-blocks:*code-blocks* t))
    (with-output-to-string (str)
      (3bmd:parse-string-and-print-to-stream text str))))
