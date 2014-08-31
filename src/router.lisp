(in-package :mudkip)

(defgeneric retrieve-document (router url)
  (:documentation "Retrieve the document to render for the current url."))

(defgeneric list-all-urls (router)
  (:documentation "List all the urls mapped in the router."))

(defclass router ()
  ((db :initarg :db :reader db)))
