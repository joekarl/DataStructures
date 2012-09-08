;;;Binary multiplication function (b*)
;;;nBits -- number of bits in numbers
;;;n1 -- number with no more bits than nBits 
;;;n2 -- number with no more bits than nBits 

(defun b* (nBits n1 n2) 
  ;;setup local variables
  (let (m xl xr yl yr r)
    ;;calculate m
    (setf m (floor nBits 2))
    ;;set xl to be left half of n1 by bit shifting to the right by m
    (setf xl (ash n1 (- m)))
    ;;set mask xl from n1 as xr
    (setf xr (- n1 (ash xl m)))
    ;;set yl to be left half of n2 by bit shifting to the right by m
    (setf yl (ash n2 (- m)))
    ;;set mask yl from n2 as yr
    (setf yr (- n2 (ash yl m)))
    (if (not (= nBits 1))
      ;;if we haven't hit base case do algorithm
      (progn
        (+ 
          (ash (b* m xl yl) nBits) 
          (ash (+ (b* m xl yr) (b* m xr yl)) m) 
          (b* m xr yr)))
      ;;if we have hit base case, return either 1 or 0 based on our multiplicants
      (progn
        (setf r (if (and (= n1 1) (= n2 1)) 1 0))
        r))))
