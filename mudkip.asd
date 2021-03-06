(in-package :cl-user)

(asdf:defsystem #:mudkip/core
  :name "mudkip/core"
  :description "Mudkip's core abstractions, generic implementation's and API."
  :version "0.1"
  :pathname "src/"
  :depends-on (#:alexandria
               #:closer-mop
               #:flexi-streams
               #:ironclad)
  :components ((:module "core"
                :components ((:file "documents" :depends-on ("utils"))
                             (:file "doc-types")
                             (:file "content-loaders")
                             (:file "query" :depends-on ("documents" "utils"))
                             (:file "site" :depends-on ("content-loaders" "documents"))
                             (:file "utils")
                             (:file "router")
                             (:file "package")))))

(asdf:defsystem #:mudkip
  :name "mudkip"
  :pathname "src/"
  :serial t
  :depends-on (:3bmd
               :3bmd-ext-code-blocks
               :alexandria
               :closure-template
               :cl-ppcre
               :djula
               ;; :djurlex
               :inferior-shell
               :mudkip/core
               :uiop)
  :components ((:file "packages")
               (:file "documents")
               (:file "query-constructor")
               (:module "doc-types"
                :components
                ((:file "post")
                 (:file "package")))
               (:file "collections")
               (:module "content-loaders"
                :components
                ((:file "package")
                 (:file "coleslaw-loader")
                 (:file "directory-as-content-type")))
               (:file "router" :depends-on ("query-constructor")))
  :in-order-to ((asdf:test-op (asdf:load-op :mudkip-tests)))
  :perform (asdf:test-op (o c)
                    (asdf/package:symbol-call :prove 'run :mudkip-tests)))
