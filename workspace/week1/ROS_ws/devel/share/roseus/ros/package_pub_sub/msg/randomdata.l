;; Auto-generated. Do not edit!


(when (boundp 'package_pub_sub::randomdata)
  (if (not (find-package "PACKAGE_PUB_SUB"))
    (make-package "PACKAGE_PUB_SUB"))
  (shadow 'randomdata (find-package "PACKAGE_PUB_SUB")))
(unless (find-package "PACKAGE_PUB_SUB::RANDOMDATA")
  (make-package "PACKAGE_PUB_SUB::RANDOMDATA"))

(in-package "ROS")
;;//! \htmlinclude randomdata.msg.html


(defclass package_pub_sub::randomdata
  :super ros::object
  :slots (_id _value _timestamp ))

(defmethod package_pub_sub::randomdata
  (:init
   (&key
    ((:id __id) 0)
    ((:value __value) 0.0)
    ((:timestamp __timestamp) "")
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _value (float __value))
   (setq _timestamp (string __timestamp))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; float64 _value
    8
    ;; string _timestamp
    4 (length _timestamp)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; float64 _value
       (sys::poke _value (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _timestamp
       (write-long (length _timestamp) s) (princ _timestamp s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _value
     (setq _value (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _timestamp
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _timestamp (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get package_pub_sub::randomdata :md5sum-) "c8e0535bc1f6fa1ce5082bcc285bb831")
(setf (get package_pub_sub::randomdata :datatype-) "package_pub_sub/randomdata")
(setf (get package_pub_sub::randomdata :definition-)
      "int32 id
float64 value
string timestamp

")



(provide :package_pub_sub/randomdata "c8e0535bc1f6fa1ce5082bcc285bb831")


