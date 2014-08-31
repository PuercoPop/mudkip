(in-package :blud)

;; Using djula instead of Should I support closure-templates as well?

(define-constant themes-path (system-relative-pathname :ncoleslaw "themes/")
  :documentation "The path where to look for descriptions of themes.")

(defun find-theme (name)
  "Look a for <name>.theme file in themes-path and use it to instantiate a
  theme object." 
  (let ((theme-file (merge-pathnames* (format nil "~A.theme" name) themes-path))) 
    (if (file-exists-p theme-file)
        (load-theme theme-file)
        (error "theme ~A not found" name))))

(defun load-theme (theme-file)
  "")


(defclass theme ()
  ((name :initarg :name :reader name)))

(defmethod print-object ((obj theme) stream)
  (print-unreadable-object (obj stream :type t)
    (format stream "~A" (name obj))))

(defclass djula-theme (theme)
  ()
  (:documentation "Use djula as a backend."))

(defmethod render ((theme djula-theme) template-name (document document))
  )
