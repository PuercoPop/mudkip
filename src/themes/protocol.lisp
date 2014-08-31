(in-package :blud)

(defgeneric render (theme template-name document)
  (:documentation "Evaluate the template using the document as the environment.ø"))
