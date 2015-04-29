(defpackage #:mudkip/core/site
  (:use :cl)
  (:import-from :mudkip/core/documents #:id)
  (:import-from :mudkip/core/content-loaders #:load-content)
  (:export
   #:site
   #:document-db
   #:routes
   #:content-loaders
   #:load-documents
   #:add-document))
(in-package :mudkip/core/site)

(defclass site ()
  ((db :initarg :db :initform (make-hash-table) :accessor document-db
       :documentation "In memory database where documents are kept.")
   (routes :initarg :routes :reader routes :type router
           :documentation "A mapping of relative urls to documents.")
   (content-loaders :initarg :content-loaders :accessor content-loaders
                    :documentation "Loaders to populate the document db with.")))


(defun load-documents (site)
  "Iterate through all the loaders and load all the content."
  (dolist (loader (content-loaders site))
    (load-content loader site)))

(defun add-document (document site)
  "Add the document to the site's database."
  ;; TODO: Evaluate if I should change the SHA1 octect to a base64 string.
  (setf (gethash (id document) (document-db site))
        document))
