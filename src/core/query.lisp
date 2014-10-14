(defpackage :mudkip/core/query
  (:use :cl)
  (:import-from :mudkip/core/utils #:build-inheritance-tree
                                   #:walk-collect)
  (:import-from :closer-mop #:slot-definition-name
                            #:class-slots))
(in-package :mudkip/core/query)

(defun slots-required-by-query-pattern (query)
  "Return a list of the slots the object is assumed to have."
  (loop
    :for index :from 1 :upto (1- (length query))
    :when (oddp index)
    :collect (nth index query)))

(defun class-has-slots-p (class slots)
  "Return only if class has all the slots. slots is a list of keywords."
  (and (mapcar (lambda (slot)
                 (member (slot-definition-name slot) slots :test #'string=))
               (class-slots class))))


(defun expand-pattern (pattern)
  "Given a query pattern it returns a optima pattern that corresponds."
  (let* ((class (find-class (car pattern)))
         (slots-required (slots-required-by-query-pattern pattern))
         (class-tree (build-inheritance-tree class))
         (classes (walk-collect class-tree (lambda (x) (class-has-slots-p x slots-required)))))

    (cond ((null classes) 
           (error (format nil "No class with such slot combination: ~A" pattern)))
          ((eql 1 (length classes)) (list (car classes) (cdr pattern)))
          (t (list `(or ,(loop :for c :in classes
                               :collect (list (car classes) (cdr pattern)))))))))

;; FIXME: The class in the pattern may include slots that are only defined by subclasses, optima doesn't take care of. We should check that the base class has all slots and if not iterate through all the the subclasses and generate a match pattern if they conform to the slots.
(defmacro query (pattern db)
  "Collect all documents in db that match the pattern."
  (let ((matches (gensym))
        (expanded-pattern (expand-pattern pattern)))
    `(loop
       :with ,matches := nil
       :for doc :being :the hash-values :in ,db
       :do
          (match doc
            (,pattern (setf ,matches (adjoin doc ,matches))))
       :finally (return ,matches))))


;; (query (document :author "LispLover") (make-hash-table))

;; (defclass foo-doc (post) ())

;; (loop
;;   :with matches = nil
;;   :for doc :being :the hash-values :in *doc-db*
;;   :do
;;   (match doc
;;     ((foo-doc :author "LispHater")  (setf matches (adjoin doc matches))))
;;   :finally (return matches))
