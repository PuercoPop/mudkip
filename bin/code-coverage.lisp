#!/usr/local/bin/sbcl --script

(require 'asdf)
(load (uiop/pathname:merge-pathnames* ".sbclrc"
                                      (asdf/cl:user-homedir-pathname)))
(require 'sb-cover)

(declaim (optimize sb-cover:store-coverage-data))
(asdf:oos 'asdf:load-op :mudkip :force t)
(asdf:oos 'asdf:load-op :mudkip-tests)

(asdf:test-system :mudkip)

(sb-cover:report (asdf:system-relative-pathname :mudkip
                                                "report/"))

