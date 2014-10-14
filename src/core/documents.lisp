(defpackage #:mudkip/core/documents
  (:use :cl)
  (:import-from :closer-mop :class-slots
                            :slot-definition-name)
  (:import-from :flexi-streams :string-to-octets)
  (:import-from :ironclad :make-digest
                          :update-digest
                          :sha1-buffer)
  (:export
   #:discover
   #:document
   #:id
   #:render-text
   #:read-content
   #:parse-hearder))
(in-package :mudkip/core/documents)

(defgeneric discover (doc-type)
  (:documentation "Scour the files in the search path and load the matching document type."))

(defclass document ()
  ((id :reader id :documentation "A SHA-1 of every slot except the id slot preprended with document."))
  (:documentation "Document base class."))

(defmethod initialize-instance :after ((obj document) &key)
  (setf (slot-value obj 'id)
        (let*
            ((sha1 (make-digest :sha1))
             (slots-as-strings
              (format nil "document~{~A~}"
                      (mapcar (lambda (slot)
                                (slot-value obj
                                            (slot-definition-name slot)))
                              (remove-if
                               (lambda (slot)
                                 (or (eq (slot-definition-name slot)
                                         'id)
                                     (not (slot-boundp obj
                                                       (slot-definition-name slot)))))
                               (class-slots (class-of obj)))))))
          (update-digest sha1
                         (string-to-octets slots-as-strings))
          (sha1-buffer sha1))))

(defgeneric render-text (text)
  (:documentation "Render TEXT of the given FORMAT to HTML for display."))

(defun read-content (file)
  "Returns a plist of metadata from FILE with :text holding the content as a string."
  )

(defun parse-hearder ())
