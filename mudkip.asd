(in-package :cl-user)

(asdf:defsystem #:mudkip
  :name "mudkip"
  :pathname "src/"
  :serial t
  :depends-on (:closure-template
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
               (:file "collections")
               (:file "router")))

(asdf:defsystem #:mudkip-tests
  :name "mudkip tests"
  :serial t
  :pathname "tests/"
  :depends-on (:mudkip
               :stefil)
  :components ((:file "packages")
               (:file "mocks")
               (:file "documents")
               (:file "content-loaders")
               (:file "runner")))
(defmethod asdf:perform ((op asdf:test-op)
                         (system (eql (asdf:find-system :mudkip))))
  (asdf/package:symbol-call :mudkip-tests 'runner))
