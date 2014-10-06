(in-package :mudkip-tests)

(defun runner (&optional interactive)
  (fiasco:run-package-tests :interactive interactive :packages :mudkip-documents)
  (fiasco:run-package-tests :interactive interactive :packages :content-loaders)
  (run-package-tests :interactive interactive :packages :mudkip-router))
