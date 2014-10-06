(fiasco:define-test-package :content-loaders
  (:use :cl :mudkip :mudkip-tests))

(in-package :content-loaders)

(defparameter +sample-dir-site+
  (uiop/pathname:merge-pathnames* "demo/dir-site/"
                                  +test-files-root+)
  "Path to a sample site using directory-content-type.")

(deftest coleslaw-content-discovery ()
  (let* ((loader (make-instance 'directory-as-content-type-loader
                               :root-dir +sample-dir-site+))
         (site (make-instance 'site :routes nil :content-loaders (list loader))))
    (load-content loader site)
    (is (eql 2 (hash-table-count (document-db site))))))
