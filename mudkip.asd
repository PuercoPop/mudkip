(in-package :cl-user)

(asdf:defsystem #:mudkip
  :name "mudkip"
  :pathname "src/"
  :serial t
  :depends-on (:closure-template
               :cl-ppcre
               :closer-mop
               :djula
               :alexandria
               :uiop
               :3bmd
               :3bmd-ext-code-blocks
               :inferior-shell
               :ironclad)
  :components ((:file "packages")
               (:file "site")
               (:file "documents")
               (:module "doc-types"
                :components
                ((:file "protocol")
                 (:file "utils")
                 (:file "post")))
               (:file "collections")
               (:module "content-loaders"
                :components
                ((:file "protocol")
                 (:file "coleslaw-loader")
                 (:file "directory-as-content-type")))
               (:file "router"))
  :in-order-to ((asdf:test-op (asdf:load-op :mudkip-tests)))
  :perform (asdf:test-op (o c)
                    (asdf/package:symbol-call :mudkip-tests 'runner)))
