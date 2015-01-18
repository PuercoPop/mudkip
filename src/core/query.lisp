(defpackage #:mudkip/core/query
  (:use :cl)
  (:import-from :mudkip/core/utils #:build-inheritance-tree
                                   #:walk-collect)
  (:import-from :closer-mop #:slot-definition-name
                            #:class-slots
                            #:ensure-finalized)
  (:import-from :optima #:match)
  (:export
   #:query))

(in-package #:mudkip/core/query)

(defun slots-required-by-query-pattern (query)
  "Return a list of the slots the object is assumed to have."
  (loop
    :for index :from 1 :upto (1- (length query))
    :when (oddp index)
    :collect (nth index query)))

(defun class-has-slots-p (class slots)
  "Return only if class has all the slots. slots is a list of keywords."
  (and (remove-if-not
        (lambda (slot)
          (member (slot-definition-name slot) slots :test #'string=))
        (class-slots (ensure-finalized class)))))

(defun expand-pattern (pattern)
  "Given a query pattern it returns a optima pattern that corresponds."
  (let ((class (find-class (car pattern)))
        (slots-required (slots-required-by-query-pattern pattern)))
    (if  (null slots-required)
         (list (class-name class))
         (let*
             ((class-tree (build-inheritance-tree class))
              (classes (walk-collect
                        class-tree
                        (lambda (x) (class-has-slots-p x slots-required)))))
           (cond
             ((null classes)
              (error "No class with such slot combination: ~A" pattern))
             ((eql 1 (length classes)) (apply #'list (class-name (car classes)) (cdr pattern)))
             (t `(or ,@(loop :for c :in classes
                             :collect (list (class-name c) (cdr pattern))))))))))

(defun query (pattern db)
  "Collect all documents in db that match the pattern."
  (let ((expanded-pattern (expand-pattern pattern)))
    (loop
      :with matches := nil
      :for doc being the hash-values in db
      :do
         (match doc
           (expanded-pattern (setf matches (adjoin doc matches))))
      :finally (return matches))))
