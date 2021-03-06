(defpackage #:mudkip
  (:use :cl)
  (:import-from :alexandria :define-constant
                            :make-keyword
                            :symbolicate)
  (:import-from :closer-mop :class-slots
                            :slot-definition-name
                            :class-direct-subclasses)
  (:import-from :ironclad :make-digest
                          :update-digest
                          :sha1-buffer)
  (:import-from :flexi-streams :string-to-octets)
  (:import-from :asdf :system-relative-pathname)
  (:import-from :uiop/pathname :merge-pathnames*)
  (:import-from :uiop/filesystem :file-exists-p
                                 :directory-files
                                 :subdirectories)
  (:export
   #:document
   #:id
   #:read-content
   #:parse-document
   #:post
   #:site
   #:load-content
   #:directory-as-content-type-loader
   #:document-db
   #:add-document
   #:query))

(defpackage #:mudkip-user
  (:use :cl :mudkip))
