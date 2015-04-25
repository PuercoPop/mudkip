(defpackage #:mudkip/core/router
  (:use :cl)
  (:export
   #:find-document
   #:list-all-urls
   #:add-route
   #:route-not-found
   #:multiple-documents-returned))

(in-package #:mudkip/core/router)

(defgeneric find-document (router url db)
  (:documentation "Retrieve the document to render for the current url."))

(defgeneric list-all-urls (router)
  (:documentation "List all the urls mapped in the router."))

(defgeneric add-route (router url-selector document-selector)
  (:documentation "Add a new route to the router."))

(define-condition route-not-found ()
  ((url :initarg :url :reader url))
  (:report (lambda (condition stream)
             (format stream "~A did not any url-template." (url condition))))
  (:documentation "Signals that the url didn't match any url template in the
  router."))

(define-condition multiple-documents-returned ()
  ((query :initarg :query :reader query))
  (:report (lambda (condition stream)
             (format stream "The query ~A returned multiple documents." (query condition))))
  (:documentation "A particular URL should only match one document. Signaled when
  the query returns multiple documents in the context of the router."))
