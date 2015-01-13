(defpackage #:mudkip/core/router
  (:use :cl)
  (:export
   #:retrieve-document
   #:list-all-urls
   #:add-route))

(in-package #:mudkip/core/router)

(defgeneric retrieve-document (router url)
  (:documentation "Retrieve the document to render for the current url."))

(defgeneric list-all-urls (router)
  (:documentation "List all the urls mapped in the router."))

(defgeneric add-route (router url-selector document-selector)
  (:documentation "Add a new route to the router."))
