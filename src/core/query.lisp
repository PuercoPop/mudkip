(defpackage #:mudkip/core/query
  (:use #:cl)
  (:import-from #:mudkip/core/utils
                #:class-slots)
  (:import-from #:alexandria
                #:with-unique-names)
  (:import-from #:closer-mop
                #:slot-definition-name
                #:ensure-finalized)
  (:export
   #:query)
  (:documentation " Provides a way to query a collection of documents using the
following query pattern syntax: (klass {slot-name value}*). A document matches
the pattern if it is a subclass of the class named by the symbol klass and has
all the slots specified in bound to their corresponding value. "))

(in-package #:mudkip/core/query)

(defun make-matcher (pattern)
  (let ((base-class (find-class (car pattern))))
    (labels ((is-of-subclass-p (candidate)
               (c2mop:subclassp (class-of candidate) base-class))
             (has-slot-p (slot candidate)
               (member slot
                       (class-slots (class-of candidate))
                       :key #'slot-definition-name
                       :test #'string=)))
      (lambda (candidate)
        (and (is-of-subclass-p candidate)
             (loop :for (slot value) :on (cdr pattern) :by #'cddr
                   :do (unless (and (has-slot-p slot candidate)
                                    (equalp (slot-value candidate slot)
                                            value))
                         (return nil))
                   :finally (return candidate)))))))


(defun %query (pattern collection)
  (let (matches
        (matcher (make-matcher pattern)))
    (loop :for doc :being :the hash-values :in collection
          :do
             ;; Test if the is the object class is a subclass of klass, and
             ;; then for each slot spec test the presence of a slot and then
             ;; the value.
             (when (funcall matcher doc)
               (push doc matches)))
    (remove-duplicates matches :test #'equalp)))

(defmacro query (pattern db)
  "The entry"
  `(%query ',pattern ,db))
