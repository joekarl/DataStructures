(load "./command_line_args.lisp")
(load "./binary_multiplication.lisp")

(defun print-usage()
  (print "Usage -- clisp TestMultiplication.lisp <nTest> <n1> <n2>
    nTest -- number of bits per muliplicant (must be <= 128)
    n1 -- first multiplicant, in binary, <= nTest bits
    n2 -- second multiplicant, in binary, <= nTest bits"))

;;Create integer from bit vector
;;via http://www.lispforum.com/viewtopic.php?f=2&t=1205#p6269
(defun bit-vector->integer (bit-vector)
  "Create a positive integer from a bit-vector."
  (reduce #'(lambda (first-bit second-bit)
              (+ (* first-bit 2) second-bit))
          bit-vector))

;;Create bit vector from integer
;;via http://www.lispforum.com/viewtopic.php?f=2&t=1205#p6269
(defun integer->bit-vector (integer)
  "Create a bit-vector from a positive integer."
  (labels ((integer->bit-list (int &optional accum)
             (cond ((> int 0)
                    (multiple-value-bind (i r) (truncate int 2)
                      (integer->bit-list i (push r accum))))
                   ((null accum) (push 0 accum))
                   (t accum))))
     (coerce (integer->bit-list integer) 'bit-vector)))

;;;Define vars needed to handle command line args
(let (args nTest n1 n2 rtnVal)
  
  ;;parse command line args
  (setf args (command-line-args))
  (if (nth 0 args) (setf nTest (parse-integer (nth 0 args))))
  (if (nth 1 args) (setf n1 (parse-integer (nth 1 args) :radix 2)))
  (if (nth 2 args) (setf n2 (parse-integer (nth 2 args) :radix 2)))

  ;;test to see if command line args are valid
  (if 
    (or
      (null args)
      (null nTest)
      (not (<= nTest 128))
      (not (<= n1 (bit-vector->integer (make-array nTest :initial-element 1))))
      (not (<= n2 (bit-vector->integer (make-array nTest :initial-element 1))))
      (not (= (list-length args) 3)))
    (progn
      (print "Invalid Usage")
      (print-usage)
      (quit 1)))
  
  ;;args are good, lets do the multiplication now....
  (setf rtnVal (b* nTest n1 n2))
  (format t "In Binary..... ~A x ~A is ~B ~%" (nth 1 args) (nth 2 args) rtnVal) 
  (format t "In Decimal.... ~A x ~A is ~A ~%" n1 n2 rtnVal)) 
