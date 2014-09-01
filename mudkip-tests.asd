(in-package :cl-user)

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
