(uiop:define-package :mudkip/core
  (:use :cl)
  (:use-reexport :mudkip/core/documents
                 :mudkip/core/doc-types
                 :mudkip/core/content-loaders
                 :mudkip/core/query
                 :mudkip/core/site
                 :mudkip/core/router))
