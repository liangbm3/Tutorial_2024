; Auto-generated. Do not edit!


(cl:in-package packge_ser_cli-srv)


;//! \htmlinclude TwoNumbers-request.msg.html

(cl:defclass <TwoNumbers-request> (roslisp-msg-protocol:ros-message)
  ((a
    :reader a
    :initarg :a
    :type cl:integer
    :initform 0)
   (b
    :reader b
    :initarg :b
    :type cl:integer
    :initform 0))
)

(cl:defclass TwoNumbers-request (<TwoNumbers-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TwoNumbers-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TwoNumbers-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name packge_ser_cli-srv:<TwoNumbers-request> is deprecated: use packge_ser_cli-srv:TwoNumbers-request instead.")))

(cl:ensure-generic-function 'a-val :lambda-list '(m))
(cl:defmethod a-val ((m <TwoNumbers-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader packge_ser_cli-srv:a-val is deprecated.  Use packge_ser_cli-srv:a instead.")
  (a m))

(cl:ensure-generic-function 'b-val :lambda-list '(m))
(cl:defmethod b-val ((m <TwoNumbers-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader packge_ser_cli-srv:b-val is deprecated.  Use packge_ser_cli-srv:b instead.")
  (b m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TwoNumbers-request>) ostream)
  "Serializes a message object of type '<TwoNumbers-request>"
  (cl:let* ((signed (cl:slot-value msg 'a)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'b)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TwoNumbers-request>) istream)
  "Deserializes a message object of type '<TwoNumbers-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'a) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'b) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TwoNumbers-request>)))
  "Returns string type for a service object of type '<TwoNumbers-request>"
  "packge_ser_cli/TwoNumbersRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TwoNumbers-request)))
  "Returns string type for a service object of type 'TwoNumbers-request"
  "packge_ser_cli/TwoNumbersRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TwoNumbers-request>)))
  "Returns md5sum for a message object of type '<TwoNumbers-request>"
  "c9430c0754d7eee705aa42d6ef2f22e7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TwoNumbers-request)))
  "Returns md5sum for a message object of type 'TwoNumbers-request"
  "c9430c0754d7eee705aa42d6ef2f22e7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TwoNumbers-request>)))
  "Returns full string definition for message of type '<TwoNumbers-request>"
  (cl:format cl:nil "int32 a~%int32 b~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TwoNumbers-request)))
  "Returns full string definition for message of type 'TwoNumbers-request"
  (cl:format cl:nil "int32 a~%int32 b~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TwoNumbers-request>))
  (cl:+ 0
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TwoNumbers-request>))
  "Converts a ROS message object to a list"
  (cl:list 'TwoNumbers-request
    (cl:cons ':a (a msg))
    (cl:cons ':b (b msg))
))
;//! \htmlinclude TwoNumbers-response.msg.html

(cl:defclass <TwoNumbers-response> (roslisp-msg-protocol:ros-message)
  ((sum
    :reader sum
    :initarg :sum
    :type cl:integer
    :initform 0)
   (product
    :reader product
    :initarg :product
    :type cl:integer
    :initform 0)
   (is_equal
    :reader is_equal
    :initarg :is_equal
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass TwoNumbers-response (<TwoNumbers-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TwoNumbers-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TwoNumbers-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name packge_ser_cli-srv:<TwoNumbers-response> is deprecated: use packge_ser_cli-srv:TwoNumbers-response instead.")))

(cl:ensure-generic-function 'sum-val :lambda-list '(m))
(cl:defmethod sum-val ((m <TwoNumbers-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader packge_ser_cli-srv:sum-val is deprecated.  Use packge_ser_cli-srv:sum instead.")
  (sum m))

(cl:ensure-generic-function 'product-val :lambda-list '(m))
(cl:defmethod product-val ((m <TwoNumbers-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader packge_ser_cli-srv:product-val is deprecated.  Use packge_ser_cli-srv:product instead.")
  (product m))

(cl:ensure-generic-function 'is_equal-val :lambda-list '(m))
(cl:defmethod is_equal-val ((m <TwoNumbers-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader packge_ser_cli-srv:is_equal-val is deprecated.  Use packge_ser_cli-srv:is_equal instead.")
  (is_equal m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TwoNumbers-response>) ostream)
  "Serializes a message object of type '<TwoNumbers-response>"
  (cl:let* ((signed (cl:slot-value msg 'sum)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'product)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_equal) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TwoNumbers-response>) istream)
  "Deserializes a message object of type '<TwoNumbers-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sum) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'product) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'is_equal) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TwoNumbers-response>)))
  "Returns string type for a service object of type '<TwoNumbers-response>"
  "packge_ser_cli/TwoNumbersResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TwoNumbers-response)))
  "Returns string type for a service object of type 'TwoNumbers-response"
  "packge_ser_cli/TwoNumbersResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TwoNumbers-response>)))
  "Returns md5sum for a message object of type '<TwoNumbers-response>"
  "c9430c0754d7eee705aa42d6ef2f22e7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TwoNumbers-response)))
  "Returns md5sum for a message object of type 'TwoNumbers-response"
  "c9430c0754d7eee705aa42d6ef2f22e7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TwoNumbers-response>)))
  "Returns full string definition for message of type '<TwoNumbers-response>"
  (cl:format cl:nil "int32 sum~%int32 product~%bool is_equal~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TwoNumbers-response)))
  "Returns full string definition for message of type 'TwoNumbers-response"
  (cl:format cl:nil "int32 sum~%int32 product~%bool is_equal~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TwoNumbers-response>))
  (cl:+ 0
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TwoNumbers-response>))
  "Converts a ROS message object to a list"
  (cl:list 'TwoNumbers-response
    (cl:cons ':sum (sum msg))
    (cl:cons ':product (product msg))
    (cl:cons ':is_equal (is_equal msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'TwoNumbers)))
  'TwoNumbers-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'TwoNumbers)))
  'TwoNumbers-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TwoNumbers)))
  "Returns string type for a service object of type '<TwoNumbers>"
  "packge_ser_cli/TwoNumbers")