(uiop:define-package #:mudkip/router
  (:use #:cl #:mudkip/core)
  (:use-reexport #:mudkip/core/router)
  (:import-from #:mudkip/query-constructor
                #:construct-query)
  (:import-from #:cl-ppcre
                #:create-scanner
                #:scan-to-strings
                #:parse-string)
  (:export #:route-not-found
           #:router
           #:routes))

(in-package #:mudkip/router)

(setf ppcre:*allow-named-registers* t)

(defclass router ()
  ((routes :initarg :db :initform (make-hash-table) :reader routes
           :documentation "A mapping from a regexp to a document query pattern
           constructor.")))

;; /posts/<title:str>/
(defmethod find-document ((router router) (url string) db)
  (loop :for key :being :the hash-keys :of (routes router)
        :for query-constructor :being :the hash-values :of (routes router)
        :do
           (multiple-value-bind (match matches)
               (scan-to-strings key url)
             (when match
               (let ((pattern (apply #'construct-query
                                     query-constructor
                                     (loop
                                       :for m :across matches
                                       :collect m))))
                 (return (query pattern db)))))))

(defmethod find-document :around ((router router) (url string) db)
  (let* ((result (call-next-method))
         (length (length result)))
    (cond ((zerop length) (signal 'route-not-found))
          ((= 1 length) (car result))
          (t
           (error "Pattern associated with the URL ~A returned more than one document.~%~% Results: ~{~A~^, ~}"
                  url result)))))

(defmethod add-route ((router router) url-selector query)
  (multiple-value-bind (scanner register-names) (create-scanner url-selector)
    (let ((qc (make-instance 'query-constructor :names register-names)))
      (setf (gethash scanner (routes router)) qc))))

;; (make-url-selector "/posts/<str:name>/")
;; returns nil or a plist with the environment. Should be easy to add a let around. Should I use (values match env) instead?
