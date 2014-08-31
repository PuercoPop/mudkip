(defpackage #:mudkip
  (:use :cl)
  (:import-from :alexandria :define-constant)
  (:import-from :closer-mop :class-slots
                            :slot-definition-name)
  (:import-from :ironclad :make-digest
                          :update-digest)
  (:import-from :flexi-streams :string-to-octets)
  (:import-from :asdf :system-relative-pathname)
  (:import-from :uiop/pathname :merge-pathnames*)
  (:import-from :uiop/filesystem :file-exists-p
                                 :directory-files)
  (:export
   #:document
   #:id))
