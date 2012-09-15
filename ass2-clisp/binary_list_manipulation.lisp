
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
;;;a new list will be returned conatining the original value padded with 0's to a given length
;;;l is the lest to pad
;;;nBits is the length of the returned padded list
(defun pad-list (l nBits)
  (let (temp)
    (setf temp (append () l))
    (loop for i from 0 below (- nBits (list-length temp)) do (setf temp (append '(0) temp)))
    temp))

;;;Clean 0s from front of binary number list
;;;a new list will be returen containing the original value without any precending 0's
(defun clean-list (l)
  (let (startIndex)
    (setf startIndex 0)
    ;;find where the number actually begins
    (block escape
      (loop for i from 0 below (list-length l) do
        (let (n) 
          (setf n (nth i l))
          ;;we're done
          (if (> n 0) (return-from escape))
          (setf startIndex (+ startIndex 1)))))
    ;;make a new list from where the number starts
    (subseq l startIndex)))
