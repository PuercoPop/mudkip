(in-package :mudkip-tests)

(defun runner (&optional interactive)
  (mudkip-documents:run-package-tests :initeractive interactive))
