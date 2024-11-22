;; Auto-generated. Do not edit!


(when (boundp 'work1::AddTwoInts)
  (if (not (find-package "WORK1"))
    (make-package "WORK1"))
  (shadow 'AddTwoInts (find-package "WORK1")))
(unless (find-package "WORK1::ADDTWOINTS")
  (make-package "WORK1::ADDTWOINTS"))
(unless (find-package "WORK1::ADDTWOINTSREQUEST")
  (make-package "WORK1::ADDTWOINTSREQUEST"))
(unless (find-package "WORK1::ADDTWOINTSRESPONSE")
  (make-package "WORK1::ADDTWOINTSRESPONSE"))

(in-package "ROS")





(defclass work1::AddTwoIntsRequest
  :super ros::object
  :slots (_a _b ))

(defmethod work1::AddTwoIntsRequest
  (:init
   (&key
    ((:a __a) 0)
    ((:b __b) 0)
    )
   (send-super :init)
   (setq _a (round __a))
   (setq _b (round __b))
   self)
  (:a
   (&optional __a)
   (if __a (setq _a __a)) _a)
  (:b
   (&optional __b)
   (if __b (setq _b __b)) _b)
  (:serialization-length
   ()
   (+
    ;; int64 _a
    8
    ;; int64 _b
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _a
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _a (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _a) (= (length (_a . bv)) 2)) ;; bignum
              (write-long (ash (elt (_a . bv) 0) 0) s)
              (write-long (ash (elt (_a . bv) 1) -1) s))
             ((and (class _a) (= (length (_a . bv)) 1)) ;; big1
              (write-long (elt (_a . bv) 0) s)
              (write-long (if (>= _a 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _a s)(write-long (if (>= _a 0) 0 #xffffffff) s)))
     ;; int64 _b
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _b (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _b) (= (length (_b . bv)) 2)) ;; bignum
              (write-long (ash (elt (_b . bv) 0) 0) s)
              (write-long (ash (elt (_b . bv) 1) -1) s))
             ((and (class _b) (= (length (_b . bv)) 1)) ;; big1
              (write-long (elt (_b . bv) 0) s)
              (write-long (if (>= _b 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _b s)(write-long (if (>= _b 0) 0 #xffffffff) s)))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _a
#+(or :alpha :irix6 :x86_64)
      (setf _a (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _a (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _b
#+(or :alpha :irix6 :x86_64)
      (setf _b (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _b (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;;
   self)
  )

(defclass work1::AddTwoIntsResponse
  :super ros::object
  :slots (_sum _product _isEqual ))

(defmethod work1::AddTwoIntsResponse
  (:init
   (&key
    ((:sum __sum) 0)
    ((:product __product) 0)
    ((:isEqual __isEqual) nil)
    )
   (send-super :init)
   (setq _sum (round __sum))
   (setq _product (round __product))
   (setq _isEqual __isEqual)
   self)
  (:sum
   (&optional __sum)
   (if __sum (setq _sum __sum)) _sum)
  (:product
   (&optional __product)
   (if __product (setq _product __product)) _product)
  (:isEqual
   (&optional (__isEqual :null))
   (if (not (eq __isEqual :null)) (setq _isEqual __isEqual)) _isEqual)
  (:serialization-length
   ()
   (+
    ;; int64 _sum
    8
    ;; int64 _product
    8
    ;; bool _isEqual
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _sum
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _sum (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _sum) (= (length (_sum . bv)) 2)) ;; bignum
              (write-long (ash (elt (_sum . bv) 0) 0) s)
              (write-long (ash (elt (_sum . bv) 1) -1) s))
             ((and (class _sum) (= (length (_sum . bv)) 1)) ;; big1
              (write-long (elt (_sum . bv) 0) s)
              (write-long (if (>= _sum 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _sum s)(write-long (if (>= _sum 0) 0 #xffffffff) s)))
     ;; int64 _product
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _product (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _product) (= (length (_product . bv)) 2)) ;; bignum
              (write-long (ash (elt (_product . bv) 0) 0) s)
              (write-long (ash (elt (_product . bv) 1) -1) s))
             ((and (class _product) (= (length (_product . bv)) 1)) ;; big1
              (write-long (elt (_product . bv) 0) s)
              (write-long (if (>= _product 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _product s)(write-long (if (>= _product 0) 0 #xffffffff) s)))
     ;; bool _isEqual
       (if _isEqual (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _sum
#+(or :alpha :irix6 :x86_64)
      (setf _sum (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _sum (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; int64 _product
#+(or :alpha :irix6 :x86_64)
      (setf _product (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _product (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; bool _isEqual
     (setq _isEqual (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass work1::AddTwoInts
  :super ros::object
  :slots ())

(setf (get work1::AddTwoInts :md5sum-) "1859b27a2ca347eed9068f108f06d918")
(setf (get work1::AddTwoInts :datatype-) "work1/AddTwoInts")
(setf (get work1::AddTwoInts :request) work1::AddTwoIntsRequest)
(setf (get work1::AddTwoInts :response) work1::AddTwoIntsResponse)

(defmethod work1::AddTwoIntsRequest
  (:response () (instance work1::AddTwoIntsResponse :init)))

(setf (get work1::AddTwoIntsRequest :md5sum-) "1859b27a2ca347eed9068f108f06d918")
(setf (get work1::AddTwoIntsRequest :datatype-) "work1/AddTwoIntsRequest")
(setf (get work1::AddTwoIntsRequest :definition-)
      "int64 a
int64 b
---
int64 sum
int64 product
bool isEqual
")

(setf (get work1::AddTwoIntsResponse :md5sum-) "1859b27a2ca347eed9068f108f06d918")
(setf (get work1::AddTwoIntsResponse :datatype-) "work1/AddTwoIntsResponse")
(setf (get work1::AddTwoIntsResponse :definition-)
      "int64 a
int64 b
---
int64 sum
int64 product
bool isEqual
")



(provide :work1/AddTwoInts "1859b27a2ca347eed9068f108f06d918")


