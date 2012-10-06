
(in-package #:shovel-compiler-types)

(defstruct token type content start-pos end-pos)

(defstruct parse-tree label start-pos end-pos children)

(define-condition shovel-compiler-error (shovel-error)
  ((at-eof :initform nil :accessor error-at-eof :initarg :at-eof)))

(defmethod print-object ((object shovel-compiler-error) stream)
  (format stream "Shovel error")
  (alexandria:when-let (file (error-file object))
    (format stream " in file '~a'" file))
  (alexandria:when-let ((line (error-line object))
                        (column (error-column object)))
    (format stream " at line ~d, column ~d" line column))
  (when (error-at-eof object)
    (format stream " at end of file"))
  (format stream ": ~a~%" (error-message object)))