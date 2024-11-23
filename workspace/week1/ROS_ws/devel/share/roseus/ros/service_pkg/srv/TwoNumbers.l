;; Auto-generated. Do not edit!


(when (boundp 'service_pkg::TwoNumbers)
  (if (not (find-package "SERVICE_PKG"))
    (make-package "SERVICE_PKG"))
  (shadow 'TwoNumbers (find-package "SERVICE_PKG")))
(unless (find-package "SERVICE_PKG::TWONUMBERS")
  (make-package "SERVICE_PKG::TWONUMBERS"))
(unless (find-package "SERVICE_PKG::TWONUMBERSREQUEST")
  (make-package "SERVICE_PKG::TWONUMBERSREQUEST"))
(unless (find-package "SERVICE_PKG::TWONUMBERSRESPONSE")
  (make-package "SERVICE_PKG::TWONUMBERSRESPONSE"))

(in-package "ROS")





(defclass service_pkg::TwoNumbersRequest
  :super ros::object
  :slots (_a _b ))

(defmethod service_pkg::TwoNumbersRequest
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

(defclass service_pkg::TwoNumbersResponse
  :super ros::object
  :slots (_sum _product _is_equal ))

(defmethod service_pkg::TwoNumbersResponse
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

(defclass service_pkg::TwoNumbers
  :super ros::object
  :slots ())

(setf (get service_pkg::TwoNumbers :md5sum-) "c9430c0754d7eee705aa42d6ef2f22e7")
(setf (get service_pkg::TwoNumbers :datatype-) "service_pkg/TwoNumbers")
(setf (get service_pkg::TwoNumbers :request) service_pkg::TwoNumbersRequest)
(setf (get service_pkg::TwoNumbers :response) service_pkg::TwoNumbersResponse)

(defmethod service_pkg::TwoNumbersRequest
  (:response () (instance service_pkg::TwoNumbersResponse :init)))

(setf (get service_pkg::TwoNumbersRequest :md5sum-) "c9430c0754d7eee705aa42d6ef2f22e7")
(setf (get service_pkg::TwoNumbersRequest :datatype-) "service_pkg/TwoNumbersRequest")
(setf (get service_pkg::TwoNumbersRequest :definition-)
      "int32 a
int32 b
---
int32 sum
int32 product
bool is_equal


")

(setf (get service_pkg::TwoNumbersResponse :md5sum-) "c9430c0754d7eee705aa42d6ef2f22e7")
(setf (get service_pkg::TwoNumbersResponse :datatype-) "service_pkg/TwoNumbersResponse")
(setf (get service_pkg::TwoNumbersResponse :definition-)
      "int32 a
int32 b
---
int32 sum
int32 product
bool is_equal


")



(provide :service_pkg/TwoNumbers "c9430c0754d7eee705aa42d6ef2f22e7")


