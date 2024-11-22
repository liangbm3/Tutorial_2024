;; Auto-generated. Do not edit!


(when (boundp 'packge_ser_cli::TwoNumbers)
  (if (not (find-package "PACKGE_SER_CLI"))
    (make-package "PACKGE_SER_CLI"))
  (shadow 'TwoNumbers (find-package "PACKGE_SER_CLI")))
(unless (find-package "PACKGE_SER_CLI::TWONUMBERS")
  (make-package "PACKGE_SER_CLI::TWONUMBERS"))
(unless (find-package "PACKGE_SER_CLI::TWONUMBERSREQUEST")
  (make-package "PACKGE_SER_CLI::TWONUMBERSREQUEST"))
(unless (find-package "PACKGE_SER_CLI::TWONUMBERSRESPONSE")
  (make-package "PACKGE_SER_CLI::TWONUMBERSRESPONSE"))

(in-package "ROS")





(defclass packge_ser_cli::TwoNumbersRequest
  :super ros::object
  :slots (_a _b ))

(defmethod packge_ser_cli::TwoNumbersRequest
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
    ;; int32 _a
    4
    ;; int32 _b
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _a
       (write-long _a s)
     ;; int32 _b
       (write-long _b s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _a
     (setq _a (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _b
     (setq _b (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass packge_ser_cli::TwoNumbersResponse
  :super ros::object
  :slots (_sum _product _is_equal ))

(defmethod packge_ser_cli::TwoNumbersResponse
  (:init
   (&key
    ((:sum __sum) 0)
    ((:product __product) 0)
    ((:is_equal __is_equal) nil)
    )
   (send-super :init)
   (setq _sum (round __sum))
   (setq _product (round __product))
   (setq _is_equal __is_equal)
   self)
  (:sum
   (&optional __sum)
   (if __sum (setq _sum __sum)) _sum)
  (:product
   (&optional __product)
   (if __product (setq _product __product)) _product)
  (:is_equal
   (&optional (__is_equal :null))
   (if (not (eq __is_equal :null)) (setq _is_equal __is_equal)) _is_equal)
  (:serialization-length
   ()
   (+
    ;; int32 _sum
    4
    ;; int32 _product
    4
    ;; bool _is_equal
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _sum
       (write-long _sum s)
     ;; int32 _product
       (write-long _product s)
     ;; bool _is_equal
       (if _is_equal (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _sum
     (setq _sum (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _product
     (setq _product (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _is_equal
     (setq _is_equal (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass packge_ser_cli::TwoNumbers
  :super ros::object
  :slots ())

(setf (get packge_ser_cli::TwoNumbers :md5sum-) "c9430c0754d7eee705aa42d6ef2f22e7")
(setf (get packge_ser_cli::TwoNumbers :datatype-) "packge_ser_cli/TwoNumbers")
(setf (get packge_ser_cli::TwoNumbers :request) packge_ser_cli::TwoNumbersRequest)
(setf (get packge_ser_cli::TwoNumbers :response) packge_ser_cli::TwoNumbersResponse)

(defmethod packge_ser_cli::TwoNumbersRequest
  (:response () (instance packge_ser_cli::TwoNumbersResponse :init)))

(setf (get packge_ser_cli::TwoNumbersRequest :md5sum-) "c9430c0754d7eee705aa42d6ef2f22e7")
(setf (get packge_ser_cli::TwoNumbersRequest :datatype-) "packge_ser_cli/TwoNumbersRequest")
(setf (get packge_ser_cli::TwoNumbersRequest :definition-)
      "int32 a
int32 b
---
int32 sum
int32 product
bool is_equal


")

(setf (get packge_ser_cli::TwoNumbersResponse :md5sum-) "c9430c0754d7eee705aa42d6ef2f22e7")
(setf (get packge_ser_cli::TwoNumbersResponse :datatype-) "packge_ser_cli/TwoNumbersResponse")
(setf (get packge_ser_cli::TwoNumbersResponse :definition-)
      "int32 a
int32 b
---
int32 sum
int32 product
bool is_equal


")



(provide :packge_ser_cli/TwoNumbers "c9430c0754d7eee705aa42d6ef2f22e7")


