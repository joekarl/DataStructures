(defun command-line-args()
  (or
  *args*
  #+SBCL *posix-argv*
  #+LISPWORKS system:*line-arguments-list*
  #+CMU extensions:*command-line-words*
  nil))
