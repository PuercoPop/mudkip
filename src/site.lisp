(in-package :mudkip)

(defclass site ()
  ((db :initarg :db :initform (make-hash-table) :accessor document-db :documentation "In memory database where documents are kept.")
   (routes :initarg :routes :reader routes :type router :documentation "A mapping of relative urls to documents.")
   (search-path :initarg :search-path :accessor search-path :documentation "Directories where to look for documents.")))
