(in-package :blud)

(defgeneric load-content (loader site)
  (:documentation "Load documents to the site according the strategy of the
  loader. Arguments the loader takes should be passed as slots."))
