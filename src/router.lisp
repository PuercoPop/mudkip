(in-package :mudkip)

(defgeneric retrieve-document (router url)
  (:documentation "Retrieve the document to render for the current url."))

(defgeneric list-all-urls (router)
  (:documentation "List all the urls mapped in the router."))

(defgeneric add-route (router url-selector document-selector)
  (:documentation "Add a new route to the router."))

(defclass router ()
  ((routes :initarg :db :reader routes :documentation "A hash table where the
  key is a url/regexp and the value a document optima pattern.")))

;; /posts/<title:str>/
(defmethod retrieve-document ((router router) (url string))
  (with-hash-table-iterator (next (routes router))
    (loop
       (multiple-value-bind (more? key value) (next)
         (unless more? (return))
         )
       )))

;; TODO: around-method to verify the query returns only one document.
;; (add-route (router site) (make-instance 'url-selector
;;                                         :template
;;                                         "/posts/<str:name>/" (document :slug name)))
(defmethod add-route ((router router) url-selector query)
  )



;; (make-url-selector "/posts/<str:name>/")
;; returns nil or a plist with the environment. Should be easy to add a let around. Should I use (values match env) instead?
