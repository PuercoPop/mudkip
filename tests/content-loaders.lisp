(stefil:define-test-package :content-loaders
  (:use :cl :mudkip))

(in-package :content-loaders)

(deftest coleslaw-content-discovery (&aux (site (mock-site)))
  (let ((loader (make-instance 'coleslaw-loader)))
    (load-content loader site)
    ))
