(defpackage #:mudkip/core/router
  (:use :cl)
  (:export
   #:find-document
   #:list-all-urls
   #:add-route))

(in-package #:mudkip/core/router)

(defgeneric find-document (router url db)
  (:documentation "Retrieve the document to render for the current url."))

(defgeneric list-all-urls (router)
  (:documentation "List all the urls mapped in the router."))

(defgeneric add-route (router url-selector document-selector)
  (:documentation "Add a new route to the router."))
