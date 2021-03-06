(defpackage #:mudkip/query-constructor
  (:use :cl)
  (:export
   #:construct-query
   #:query-constructor
   #:names
   #:base-class)
  (:documentation "The query constructor is in charge of returning a sexp that
  mudkip:query understands from a list of values."))

(in-package #:mudkip/query-constructor)

(defun construct-query (qc &rest values)
  "Take a query-constructor and return a query"
  (if (names qc)
      (progn
        (assert (eql (length values)
                     (length (names qc))))
        (append (list (base-class qc))
                (loop
                  :for name :in (names qc)
                  :for value :in values
                  :collect name
                  :collect value)))
      ;; If no names require binding a good 'ol document is enough.
      (list (alexandria:make-keyword (base-class qc)))))

(defclass query-constructor ()
  ((names :initarg :names :initform nil :reader names
          :documentation "A list of names/slots that the query constructor takes.")
   (base-class :initarg :base-class :initform :document :reader base-class
               :documentation "The base class of the query, by default
               document."))
  (:documentation ""))
