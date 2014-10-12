(defpackage mudkip/tree
  (:use :cl)
  (:import-from :closer-mop #:classp
                            #:class-direct-subclasses)
  (:export
   #:walk-collect))
(in-package :mudkip/tree)

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

(defun spam-or-ham (xs test-fn)
  "Return two values the list of elements that satisfy that test function and the list of elements that don't satisfy it.
 (xs-pass, xs-fail)"
  (let ((pass-xs)
        (fail-xs))
    (loop
      :for elem :in xs
      :do
      (if (funcall test-fn elem)
          (setf pass-xs (cons elem pass-xs))
          (setf fail-xs (cons elem fail-xs))))
    (values pass-xs fail-xs)))

(defun %walk-collect (node predicate results)
  (if (funcall predicate (value node))
      (setf results (cons (value node) results))
      (multiple-value-bind (ham spam)
          (spam-or-ham (children node) predicate)
        (dolist (v ham)
          (setf results (cons (value v) results)))
        (dolist (v spam)
          (%walk-collect v predicate results)))))

(defun walk-collect (tree predicate)
  "Walk the tree collecting the highest node for which the predicate returns
  true."
  (let ((results nil))
    (%walk-collect tree predicate results)
    results))
