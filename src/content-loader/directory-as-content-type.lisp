(in-package :blud)

;;;; Take the directory the file is in as the content-type discriminant. Look
;;;; the directory in an alist to fetch the concrete content type.


(defclass directory-content-type-loader ()
  ((root-dir :initarg :root-dir :reader root-dir)
   (mappings :initarg :mappings :initform nil :reader mappings
             :documentation "An alist mapping a directory name to a
             content-type. If nil assume the directory is the content-type.")))


(defmethod load-content ((loader directory-content-type-loader) (site site))
  "List all directories and in every directory construct a document of the
  appropriate content-type and add it the site.")
