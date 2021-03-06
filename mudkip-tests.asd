(in-package :cl-user)

(asdf:defsystem #:mudkip-tests
  :name "mudkip tests"
  :serial t
  :pathname "tests/"
  :depends-on (:mudkip
               :prove)
  :defsystem-depends-on (:prove-asdf)
  :components ((:file "packages")
               (:file "mocks")
               (:test-file "documents")
               (:test-file "doc-types")
               (:test-file "content-loaders")
               (:test-file "query")
               (:test-file "query-constructor")
               (:test-file "router")))
