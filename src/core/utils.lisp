(defpackage #:mudkip/core/utils
  (:use :cl)
  (:import-from :closer-mop #:classp
                            #:class-direct-subclasses)
  (:export
   #:walk-collect
   #:build-inheritance-tree))
(in-package :mudkip/core/utils)

(defclass node ()
  ((value :initarg :value :initform :leaf :accessor value)
   (children :initarg children :initform nil :accessor children)))

(defmethod print-object ((obj node) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~A" (value obj))))

(defun build-inheritance-tree (class)
  (unless (classp class)
    (error (format nil "~A is not a class" class)))
  (let ((tree (make-instance 'node :value class)))
    (%build-inheritance-tree class tree)
    tree))

(defun %build-inheritance-tree (class node)
  (let ((subclasses (class-direct-subclasses class)))
    (if (null subclasses)
        node
        (dolist (subclass subclasses)
          (setf (children node)
                (cons (let
                          ((n (make-instance 'node :value subclass)))
                        (%build-inheritance-tree subclass n)
                        n)
                      (children node)))))))

(defun %walk-collect (node predicate queue results)
  (cond ((and (null node) (null queue)) results)
        ((and (null queue) (listp node))
         (%walk-collect (cdr node)
                        predicate
                        (mapcar #'value (children (car node)))
                        results))
        ((and (null queue) (atom node))
         (if (funcall predicate (value node))
             (cons (value node) results)
             (%walk-collect (children node)
                            predicate
                            (mapcar #'value (children node))
                            results)))
        (t (%walk-collect node
                          predicate
                          (cdr queue)  
                          (if (funcall predicate (car queue))
                              (cons (car queue) results)
                              results)))))

(defun walk-collect (tree predicate)
  "Walk the tree collecting the highest node for which the predicate returns
  true. Breadth-first."
  (%walk-collect tree predicate nil nil))
