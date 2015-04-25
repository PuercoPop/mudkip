(uiop:define-package #:mudkip/router
  (:use :cl #:mudkip/core)
  (:use-reexport :mudkip/core/router)
  (:import-from :ppcre #:create-scanner
                       #:scan
                       #:parse-string)
  (:export #:route-not-found
           #:router
           #:routes))

(in-package #:mudkip/router)

(setf ppcre:*allow-named-registers* t)

(define-condition route-not-found ()
  ((url :initarg :url :reader url))
  (:report (lambda (c s)
             (format s "~A did not any url-template." (url c))))
  (:documentation "Signals that the url didn't match any url template in the
  router."))


(defclass router ()
  ((routes :initarg :db :initform (make-hash-table) :reader routes
           :documentation "A hash table mapping a regexp with a
           document query pattern constructor.")))

;; /posts/<title:str>/
(defmethod find-document ((router router) (url string) db)
  (loop :for key :being :the hash-keys :of (routes router)
        :for value :being :the hash-values :of (routes router)
        :do (when (scan key url)
              (return (query value db)))))

(defmethod find-document :around ((router router) (url string) db)
  (let ((result (call-next-method)))
    (if (eql 1 (length result))
        (car result)
        (error "Pattern associated with the URL ~A returned more than one document." url))))

(defmethod add-route ((router router) url-selector query)
  (multiple-value-bind (scanner register-names) (create-scanner url-selector)
    (let ((qc (make-instance 'query-constructor :names register-names)))
      (setf (gethash scanner (routes router)) qc))))



;; (make-url-selector "/posts/<str:name>/")
;; returns nil or a plist with the environment. Should be easy to add a let around. Should I use (values match env) instead?
