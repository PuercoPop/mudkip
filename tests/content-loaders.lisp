(defpackage #:content-loaders
  (:use :cl :prove :mudkip/core :mudkip/content-loaders :mudkip-test-mocks)
  (:import-from #:mudkip/doc-types #:post))

(in-package #:content-loaders)

(defparameter +sample-dir-site+
  (uiop/pathname:merge-pathnames* "demo/dir-site/"
                                  +test-files-root+)
  "Path to a sample site using directory-content-type.")

(plan 1)

(let* ((loader (make-instance 'directory-as-content-type-loader
                              :root-dir +sample-dir-site+))
       (site (make-instance 'site :routes nil :content-loaders (list loader))))
  (load-content loader site)
  (is 2 (hash-table-count (document-db site))))

(finalize)
