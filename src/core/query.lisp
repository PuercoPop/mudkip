(defpackage #:mudkip/core/query
  (:use #:cl)
  (:import-from #:mudkip/core/utils
                #:class-slots)
  (:import-from #:alexandria
                #:with-unique-names)
  (:import-from #:closer-mop
                #:slot-definition-name
                #:ensure-finalized
                #:slot-value-using-class
                #:standard-effective-slot-definition
                #:subclassp)
  (:export
   #:query)
  (:documentation " Provides a way to query a collection of documents using the
following query pattern syntax: (klass {slot-name value}*). A document matches
the pattern if it is a subclass of the class named by the symbol klass and has
all the slots specified in bound to their corresponding value. "))

(in-package #:mudkip/core/query)

(defun find-slot (slot candidate)
  (find slot (class-slots candidate) :key #'slot-definition-name :test #'string=))

(defun slotp (candidate)
  "Return t if CANDIDATE is a slot. "
  (subclassp (class-of candidate)
             'standard-effective-slot-definition))

(defun slot-value* (object potential-slot)
  "Similar to slot-value but uses a slot object, instead of a symbol."
  (slot-value-using-class (class-of potential-slot) object potential-slot))

(defun make-matcher (pattern)
  (let ((base-class (find-class (car pattern))))
    (labels ((is-of-subclass-p (candidate)
               (subclassp (class-of candidate) base-class))
             (has-slot-p (slot candidate)
               (member slot
                       (class-slots (class-of candidate))
                       :key #'slot-definition-name
                       :test #'string=)))
      (lambda (candidate)
        (let (slot-object)
          (and (is-of-subclass-p candidate)
               (loop :for (slot value) :on (cdr pattern) :by #'cddr
                     :do (unless (and (prog1 (has-slot-p slot candidate)
                                        (setf slot-object (find-slot slot (class-of candidate))))
                                      (slotp slot-object)
                                      (equalp (slot-value* candidate slot-object)
                                              value))
                           (return nil))
                         (setf slot-object nil)
                     :finally (return candidate))))))))


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
