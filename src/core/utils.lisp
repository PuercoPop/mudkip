(defpackage #:mudkip/core/utils
  (:use #:cl)
  (:import-from #:closer-mop #:ensure-finalized)
  (:export
   #:class-slots))
(in-package #:mudkip/core/utils)

(defun class-slots (class)
  "Similar to C2MOP:CLASS-SLOTS but ensures class is finalized."
  (c2mop:class-slots (ensure-finalized class)))
