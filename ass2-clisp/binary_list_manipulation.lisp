
;;Create integer from bit vector
;;;;via http://www.lispforum.com/viewtopic.php?f=2&t=1205#p6269
(defun bit-vector->integer (bit-vector)
  "Create a positive integer from a bit-vector."
  (reduce #'(lambda (first-bit second-bit)
              (+ (* first-bit 2) second-bit))
          bit-vector))

;;Create bit vector from integer
;;;;via http://www.lispforum.com/viewtopic.php?f=2&t=1205#p6269
(defun integer->bit-vector (integer)
  "Create a bit-vector from a positive integer."
  (labels ((integer->bit-list (int &optional accum)
             (cond ((> int 0)
                    (multiple-value-bind (i r) (truncate int 2)
                      (integer->bit-list i (push r accum))))
                   ((null accum) (push 0 accum))
                   (t accum))))
   (coerce (integer->bit-list integer) 'bit-vector)))


;;;Pad a binary list to a given length with 0s
(defun pad-list (l nBits)
  (let (temp)
    (setf temp (append () l))
    (loop for i from 0 below (- nBits (list-length temp)) do (setf temp (append '(0) temp)))
    temp))

;;;Clean 0s from front of binary number list
(defun clean-list (l)
  (let (startIndex)
    (setf startIndex 0)
    (block escape
      (loop for i from 0 below (list-length l) do
        (let (n) 
          (setf n (nth i l))
          (if (> n 0) (return-from escape))
          (setf startIndex (+ startIndex 1)))))
    (subseq l startIndex)))
