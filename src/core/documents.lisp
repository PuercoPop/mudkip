(defpackage #:mudkip/core/documents
  (:use :cl)
  (:import-from :alexandria :make-keyword)
  (:import-from :closer-mop :class-slots
                            :slot-definition-name)
  (:import-from :flexi-streams :string-to-octets)
  (:import-from :ironclad :make-digest
                          :update-digest
                          :sha1-buffer)
  (:export
   #:document
   #:id
   #:render-text
   #:read-content
   #:parse-hearder))
(in-package :mudkip/core/documents)


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

(defgeneric render-text (text format)
  (:documentation "Render TEXT of the given FORMAT to HTML for display."))

(defun read-content (file &optional (header "-----") (file-encoding '(:utf-8)))
  "Returns a plist of metadata from FILE with :text holding the content as a
  string."
  (with-open-file (in file :external-format file-encoding)
    (let ((results nil))
      (unless (string= header
                       (read-line in nil 'eof))
        (error "No header found in ~A" file))
      (setf results (%parse-header in header results))
      (setf (getf results :text) (loop
                                   :for line := (read-line in nil 'eof)
                                   :until (eq line 'eof)
                                   :collect line))
      results)))

(defun %parse-header (input header results)
  (loop
    :for line := (read-line input nil 'eof)
    :until (string= line header)
    :do
       (multiple-value-bind (key value) (%parse-header-line line)

         (unless (string= "" value)
           (setf (getf results key) value))))
  results)

(defun %parse-header-line (line)
  (let* ((separator-pos (position #\: line))
         (key (make-keyword (string-upcase (subseq line 0 separator-pos))))
         (value (string-trim '(#\Space #\Tab)
                             (subseq line (1+ separator-pos) ))))
      (values key value)))
