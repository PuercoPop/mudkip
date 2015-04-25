(uiop:define-package #:mudkip/router
  (:use :cl)
  (:use-reexport :mudkip/core/router)
  (:import-from :ppcre #:create-scanner
                       #:scan))
(in-package :mudkip/router)

(defclass router ()
  ((routes :initarg :db :initform (make-hash-table) :reader routes
           :documentation "A hash table mapping a regexp with a
           document query pattern.")))

;; /posts/<title:str>/
(defmethod find-document ((router router) (url string) db)
  (loop :for key :being :the hash-keys :of (routes router)
        :for value :being :the hash-values :of (routes router)
        :when (scran key url)
          (return value)))

;; TODO: around-method to verify the query returns only one document.
(defmethod add-route ((router router) url-selector query)
  (setf (gethash (create-scanner url-selector) (routes router)) query))



;; (make-url-selector "/posts/<str:name>/")
;; returns nil or a plist with the environment. Should be easy to add a let around. Should I use (values match env) instead?
