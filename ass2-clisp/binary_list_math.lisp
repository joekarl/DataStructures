
(load "./binary_list_manipulation.lisp")

;;;Binary list shift left function (b<<)
;;;l - list to shift
;;;shiftNum - number of bits to shift left
;;;Returns an array of nBits with the shifted number
(defun b<< (l shiftNum) 
  (let (isZero)
    (setf isZero t)
    (block escape
      (loop for i from 0 below (list-length l) do
        (setf isZero (= 0 (nth i l)))
        (if (not isZero) (return-from escape))))
    (if isZero '(0)
      ;;declare return value and temp list
      (let (r temp)
        ;;copy l into temp list for shifting
        (setf temp (clean-list l))
        (loop for i from 0 below shiftNum do
          (progn 
            ;;setup return value to be an empty list
            (setf r ())
            (loop for j from 0 below (list-length temp) do 
              (progn
                (setf r (append r (list (nth j temp))))))
            (setf r (append r '(0)))
            ;;reset temp list to r for next iteration
            (setf temp (append () r))))
        r))))

;;;Binary list addition function (b+)
;;;returns a list that has the added numbers from the passed in binary lists....
(defun b+ (n1 n2)
  (let (carryBit r copyN1 copyN2 maxLength)
    (setf copyN1 (clean-list n1))
    (setf copyN2 (clean-list n2))
    (setf maxLength (if (> (list-length copyN1) (list-length copyN2)) (list-length copyN1) (list-length copyN2)))
    (setf copyN1 (pad-list copyN1 maxLength))
    (setf copyN2 (pad-list copyN2 maxLength))
    ;;(if (> maxLength 5) (format t "n1 length ~A n2 length ~A maxLength ~A~%" (list-length n1) (list-length n2) maxLength))
    (setf r ())
    (setf carryBit 0)
    ;;loop from right most bit to left most bit
    (loop for i from (- maxLength 1) downto 0 do
      (let (addResult binAddResult) 
        (setf addResult (+ (nth i copyN1) (nth i copyN2) carryBit))
        (setf binAddResult 
          (if 
            (or 
              (= 1 addResult)
              (= 3 addResult))
            1 0))
        (setf carryBit 
          (if 
            (or 
              (= 2 addResult)
              (= 3 addResult))
            1 0))
        (setf r (append (list binAddResult) r))))
      (if (= 1 carryBit) (setf r (append (list carryBit) r)))
    (setf r (clean-list r))
    ;;(if (and copyN1 copyN2 r) (format t "Adding ~A and ~A and got ~A~%" (bit-vector->integer copyN1) (bit-vector->integer copyN2)  (bit-vector->integer r)))
    r))

;;;Binary list multiplication function (b*)
;;;nBits -- number of bits in numbers
;;;n1 -- binary number list with no more bits than nBits 
;;;n2 -- binary number list with no more bits than nBits 
;;;returns a list full of binary numbers....

(defun b* (nBits n1 n2)
  (setf n1 (pad-list n1 nBits))
  (setf n2 (pad-list n2 nBits))
   
  ;;setup local variables
  ;;m being half of nBits so we can split binary number in half
  ;;xl being left half of n1
  ;;xr being right half of n1
  ;;yl being left half of n2
  ;;y2 being right half of n2
  ;;r being base case return
  (let (m xl xr yl yr r n/2)
    (setf n/2 (floor nBits 2))
    ;;set xl to be left half of n1 by bit shifting to the right by m
    (setf xl (subseq n1 0 n/2))
    ;;set mask xl from n1 as xr
    (setf xr (subseq n1 n/2))
    ;;set yl to be left half of n2 by bit shifting to the right by m
    (setf yl (subseq n2 0 n/2))
    ;;set mask yl from n2 as yr
    (setf yr (subseq n2 n/2))
    ;;calculate m
    (setf m (- nBits n/2))
    ;(format t "nBits ~A n/2 ~A m ~A~%" nBits n/2 m)
    
    (if
      (= nBits 1)
      ;;if we have hit base case, return either 1 or 0 based on our multiplicants
      (progn
        (setf r (if (and (= (nth 0 (last n1)) 1) (= (nth 0 (last n2)) 1)) '(1) '(0)))
        r)
      ;;if we haven't hit base case (when nBits is 1) do algorithm and take advantage of tail call elimination so we never have to worry about a stack overflow o_0
      (progn

        (b+ 
          (b+ 
            (b<< (b* m xl yl) nBits) 
            (b<< (b+ 
                    (b* m xl yr) 
                    (b* m xr yl)) 
                 m))
          (b* m xr yr))))))
