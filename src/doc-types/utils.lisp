(in-package :mudkip)

(defun slurp-remainder (stream)
  "A helper for read content."
  (let ((seq (make-string (- (file-length stream)
                             (file-position stream)))))
    (read-sequence seq stream)
    (remove #\Nul seq)))

(defun parse-field (str)
  "A helper for read-content."
  (nth-value 1 (cl-ppcre:scan-to-strings "[a-zA-Z]+:\\s+(.*)" str)))

(defun field-name (line)
  "A helper for read-content."
  (make-keyword (string-upcase (subseq line 0 (position #\: line)))))

(defun read-content (file header-separator)
  "A helper to parse the common content case. Lifted from Coleslaw."
  (with-open-file (in file :external-format '(:utf-8))
    (unless (string= (read-line in) header-separator)
      (error "The provided file lacks the expected header.~%~% File: ~A~% Header Separator: ~A~%"
             file header-separator))
    (let ((header (loop
                     :for line = (read-line in)
                     :until (string= line header-separator)
                     :when (parse-field line)
                     :appending (list (field-name line)
                                       (aref (parse-field line) 0))))
          (content (slurp-remainder in)))
      (append header (list :text content)))))
