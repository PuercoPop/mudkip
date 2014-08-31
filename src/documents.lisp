(in-package :mudkip)

(defgeneric discover (doc-type)
  (:documentation "Scour the files in the search path and load the matching document type."))

#+nil(defmethod discover (doc-type site)
  ;; FIX: Shouldn't depend on file extension being lowercase.
  ((let ((file-type (format nil "~(~A~)" doc-type)))
     (loop
        :for directory :in (search-path site)
        :do
        (loop
           :for file :in (directory-files directory file-type)
           :do (add-object (read-content file)))))))


(defclass document ()
  ((id :reader id :documentation "A SHA-1 of every slot except the id slot preprended with document."))
  (:documentation "Document base class."))

(defmethod initialize-instance :after ((obj document) &key)
  (setf (slot-value obj 'id)
        (loop
           :with sha1 :=  (make-digest :sha1)
           :initially (update-digest sha1 (string-to-octets "document"))
           :for slot :in (remove-if (lambda (obj) (eq 'id (slot-definition-name obj))) (class-slots (class-of obj)))
           :finally (return sha1))))

(defclass post (document)
  ((file :initarg :file :reader file)
   (date :initarg :date :reader date)
   (slug :initarg :slug :accessor slug)
   (text :initarg :text :accessor text))
  (:default-initargs :date nil :slug nil)
  (:documentation "Your run of the mill blog post."))


(defgeneric render-text (text)
  (:documentation "Render TEXT of the given FORMAT to HTML for display."))

#+nil(defmethod render-text (text (format (eql :md)))
  (let ((3md-code-blocks:*code-blocks* t))
    (with-output-to-string (str)
      (3bmd:parse-string-and-print-to-stream text str))))


(defun read-content (file)
  "Returns a plist of metadata from FILE with :text holding the content as a string."
  )

(defun parse-hearder ())
