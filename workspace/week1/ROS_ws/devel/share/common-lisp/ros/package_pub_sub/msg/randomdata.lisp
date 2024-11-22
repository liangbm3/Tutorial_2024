; Auto-generated. Do not edit!


(cl:in-package package_pub_sub-msg)


;//! \htmlinclude randomdata.msg.html

(cl:defclass <randomdata> (roslisp-msg-protocol:ros-message)
  ((id
    :reader id
    :initarg :id
    :type cl:integer
    :initform 0)
   (value
    :reader value
    :initarg :value
    :type cl:float
    :initform 0.0)
   (timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:string
    :initform ""))
)

(cl:defclass randomdata (<randomdata>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <randomdata>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'randomdata)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name package_pub_sub-msg:<randomdata> is deprecated: use package_pub_sub-msg:randomdata instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <randomdata>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader package_pub_sub-msg:id-val is deprecated.  Use package_pub_sub-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <randomdata>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader package_pub_sub-msg:value-val is deprecated.  Use package_pub_sub-msg:value instead.")
  (value m))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <randomdata>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader package_pub_sub-msg:timestamp-val is deprecated.  Use package_pub_sub-msg:timestamp instead.")
  (timestamp m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <randomdata>) ostream)
  "Serializes a message object of type '<randomdata>"
  (cl:let* ((signed (cl:slot-value msg 'id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'value))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'timestamp))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'timestamp))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <randomdata>) istream)
  "Deserializes a message object of type '<randomdata>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'value) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'timestamp) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'timestamp) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<randomdata>)))
  "Returns string type for a message object of type '<randomdata>"
  "package_pub_sub/randomdata")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'randomdata)))
  "Returns string type for a message object of type 'randomdata"
  "package_pub_sub/randomdata")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<randomdata>)))
  "Returns md5sum for a message object of type '<randomdata>"
  "c8e0535bc1f6fa1ce5082bcc285bb831")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'randomdata)))
  "Returns md5sum for a message object of type 'randomdata"
  "c8e0535bc1f6fa1ce5082bcc285bb831")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<randomdata>)))
  "Returns full string definition for message of type '<randomdata>"
  (cl:format cl:nil "int32 id~%float64 value~%string timestamp~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'randomdata)))
  "Returns full string definition for message of type 'randomdata"
  (cl:format cl:nil "int32 id~%float64 value~%string timestamp~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <randomdata>))
  (cl:+ 0
     4
     8
     4 (cl:length (cl:slot-value msg 'timestamp))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <randomdata>))
  "Converts a ROS message object to a list"
  (cl:list 'randomdata
    (cl:cons ':id (id msg))
    (cl:cons ':value (value msg))
    (cl:cons ':timestamp (timestamp msg))
))
