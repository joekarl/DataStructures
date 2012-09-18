(load "./command_line_args.lisp")
(load "./binary_list_manipulation.lisp")
(load "./binary_list_math.lisp")

;;function to print the usage information
(defun print-usage()
  (print "Usage -- clisp TestMultiplication.lisp [<nTest>] [<n1>] [<n2>]
    nTest -- number of bits per muliplicant (must be <= 128)
    n1 -- first multiplicant, in binary, <= nTest bits ex: 10101011
    n2 -- second multiplicant, in binary, <= nTest bits ex: 11001110"))

;;;Define vars needed to handle command line args
(let (args nTest bl1 bl2 n1 n2 rtnVal maxSize)
  
  ;;parse command line args
  ;;parse binary numbers into decimal to check for valid number sequences
  (setf args (command-line-args))
  (if (nth 0 args) (setf nTest (parse-integer (nth 0 args))))
  (if (nth 1 args) (setf n1 (parse-integer (nth 1 args) :radix 2)))
  (if (nth 2 args) (setf n2 (parse-integer (nth 2 args) :radix 2)))

  ;;if args weren't passed in, lets interactively ask the user for args...
  ;;parse binary numbers into decimal to check for valid number sequences
  (if (not (= (list-length args) 3))
    (progn
      (print "Enter number of bits to use for multiplying numbers")
      (setf nTest (parse-integer (read-line)))
      (print "Enter the first number in binary")
      (setf n1 (parse-integer (read-line) :radix 2))
      (print "Enter the second number in binary")
      (setf n2 (parse-integer (read-line) :radix 2))))

  ;;test to see if command line args are valid
  ;;make sure nTest is valid
  ;;make sure n1 and n2 are within the range of numbers that can be expresed in nTest bits
  (if 
    (or
      (null nTest)
      (not (<= nTest 128))
      (not (<= n1 (bit-vector->integer (make-array nTest :initial-element 1))))
      (not (<= n2 (bit-vector->integer (make-array nTest :initial-element 1)))))
    (progn
      ;;did not meet requirements, print usage statement and quit with error 1
      (print "Invalid Usage")
      (print-usage)
      (quit 1)))
  
  ;;args are good, lets do the multiplication now....
  ;;but first coerce the converted n1/n2 values into a list of bits
  (setf bl1 (coerce (integer->bit-vector n1) 'list))
  (setf bl2 (coerce (integer->bit-vector n2) 'list))

  ;;do the multiplication with a normalized bit length 
  (setf rtnVal (b* nTest bl1 bl2))
  
  ;;and print out what happened in binary...
  (format t "~%In Binary..... ~A x ~A is ~B ~%" (nth 1 args) (nth 2 args) (bit-vector->integer rtnVal)) 
  ;;print out the multiplication result in decimal for confirmation
  (format t "In Decimal.... ~A x ~A is ~A ~%" n1 n2 (bit-vector->integer rtnVal))) 
