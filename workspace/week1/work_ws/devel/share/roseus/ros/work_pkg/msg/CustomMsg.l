;; Auto-generated. Do not edit!


(when (boundp 'work_pkg::CustomMsg)
  (if (not (find-package "WORK_PKG"))
    (make-package "WORK_PKG"))
  (shadow 'CustomMsg (find-package "WORK_PKG")))
(unless (find-package "WORK_PKG::CUSTOMMSG")
  (make-package "WORK_PKG::CUSTOMMSG"))

(in-package "ROS")
;;//! \htmlinclude CustomMsg.msg.html


(defclass work_pkg::CustomMsg
  :super ros::object
  :slots (_id _value _name ))

(defmethod work_pkg::CustomMsg
  (:init
   (&key
    ((:id __id) 0)
    ((:value __value) 0.0)
    ((:name __name) "")
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _value (float __value))
   (setq _name (string __name))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:value
   (&optional __value)
   (if __value (setq _value __value)) _value)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; float64 _value
    8
    ;; string _name
    4 (length _name)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; float64 _value
       (sys::poke _value (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _value
     (setq _value (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get work_pkg::CustomMsg :md5sum-) "050f1d767b31899d38d360e2a43a147f")
(setf (get work_pkg::CustomMsg :datatype-) "work_pkg/CustomMsg")
(setf (get work_pkg::CustomMsg :definition-)
      "int32 id
float64 value
string name
")



(provide :work_pkg/CustomMsg "050f1d767b31899d38d360e2a43a147f")


