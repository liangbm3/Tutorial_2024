; Auto-generated. Do not edit!


(cl:in-package work_pkg-msg)


;//! \htmlinclude CustomMsg.msg.html

(cl:defclass <CustomMsg> (roslisp-msg-protocol:ros-message)
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
   (name
    :reader name
    :initarg :name
    :type cl:string
    :initform ""))
)

(cl:defclass CustomMsg (<CustomMsg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CustomMsg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CustomMsg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name work_pkg-msg:<CustomMsg> is deprecated: use work_pkg-msg:CustomMsg instead.")))

(cl:ensure-generic-function 'id-val :lambda-list '(m))
(cl:defmethod id-val ((m <CustomMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader work_pkg-msg:id-val is deprecated.  Use work_pkg-msg:id instead.")
  (id m))

(cl:ensure-generic-function 'value-val :lambda-list '(m))
(cl:defmethod value-val ((m <CustomMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader work_pkg-msg:value-val is deprecated.  Use work_pkg-msg:value instead.")
  (value m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <CustomMsg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader work_pkg-msg:name-val is deprecated.  Use work_pkg-msg:name instead.")
  (name m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CustomMsg>) ostream)
  "Serializes a message object of type '<CustomMsg>"
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
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CustomMsg>) istream)
  "Deserializes a message object of type '<CustomMsg>"
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
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CustomMsg>)))
  "Returns string type for a message object of type '<CustomMsg>"
  "work_pkg/CustomMsg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CustomMsg)))
  "Returns string type for a message object of type 'CustomMsg"
  "work_pkg/CustomMsg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CustomMsg>)))
  "Returns md5sum for a message object of type '<CustomMsg>"
  "050f1d767b31899d38d360e2a43a147f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CustomMsg)))
  "Returns md5sum for a message object of type 'CustomMsg"
  "050f1d767b31899d38d360e2a43a147f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CustomMsg>)))
  "Returns full string definition for message of type '<CustomMsg>"
  (cl:format cl:nil "int32 id~%float64 value~%string name~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CustomMsg)))
  "Returns full string definition for message of type 'CustomMsg"
  (cl:format cl:nil "int32 id~%float64 value~%string name~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CustomMsg>))
  (cl:+ 0
     4
     8
     4 (cl:length (cl:slot-value msg 'name))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CustomMsg>))
  "Converts a ROS message object to a list"
  (cl:list 'CustomMsg
    (cl:cons ':id (id msg))
    (cl:cons ':value (value msg))
    (cl:cons ':name (name msg))
))
