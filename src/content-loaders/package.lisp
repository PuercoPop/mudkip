(defpackage #:mudkip/content-loaders
  (:use :cl :mudkip/core/content-loaders)
  (:import-from :mudkip/core :add-document
                             :parse-document
                             :site)
  (:import-from :alexandria :symbolicate)
  (:import-from :uiop/filesystem :directory-files
                                 :subdirectories)
  (:export
   #:directory-as-content-type-loader
   #:root-dir
   #:mappings))
