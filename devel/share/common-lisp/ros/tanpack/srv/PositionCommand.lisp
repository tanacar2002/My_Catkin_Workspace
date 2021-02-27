; Auto-generated. Do not edit!


(cl:in-package tanpack-srv)


;//! \htmlinclude PositionCommand-request.msg.html

(cl:defclass <PositionCommand-request> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (z
    :reader z
    :initarg :z
    :type cl:float
    :initform 0.0))
)

(cl:defclass PositionCommand-request (<PositionCommand-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PositionCommand-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PositionCommand-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tanpack-srv:<PositionCommand-request> is deprecated: use tanpack-srv:PositionCommand-request instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <PositionCommand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:x-val is deprecated.  Use tanpack-srv:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <PositionCommand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:y-val is deprecated.  Use tanpack-srv:y instead.")
  (y m))

(cl:ensure-generic-function 'z-val :lambda-list '(m))
(cl:defmethod z-val ((m <PositionCommand-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:z-val is deprecated.  Use tanpack-srv:z instead.")
  (z m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PositionCommand-request>) ostream)
  "Serializes a message object of type '<PositionCommand-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PositionCommand-request>) istream)
  "Deserializes a message object of type '<PositionCommand-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'z) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PositionCommand-request>)))
  "Returns string type for a service object of type '<PositionCommand-request>"
  "tanpack/PositionCommandRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PositionCommand-request)))
  "Returns string type for a service object of type 'PositionCommand-request"
  "tanpack/PositionCommandRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PositionCommand-request>)))
  "Returns md5sum for a message object of type '<PositionCommand-request>"
  "cc153912f1453b708d221682bc23d9ac")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PositionCommand-request)))
  "Returns md5sum for a message object of type 'PositionCommand-request"
  "cc153912f1453b708d221682bc23d9ac")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PositionCommand-request>)))
  "Returns full string definition for message of type '<PositionCommand-request>"
  (cl:format cl:nil "float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PositionCommand-request)))
  "Returns full string definition for message of type 'PositionCommand-request"
  (cl:format cl:nil "float32 x~%float32 y~%float32 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PositionCommand-request>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PositionCommand-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PositionCommand-request
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':z (z msg))
))
;//! \htmlinclude PositionCommand-response.msg.html

(cl:defclass <PositionCommand-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass PositionCommand-response (<PositionCommand-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PositionCommand-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PositionCommand-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tanpack-srv:<PositionCommand-response> is deprecated: use tanpack-srv:PositionCommand-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PositionCommand-response>) ostream)
  "Serializes a message object of type '<PositionCommand-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PositionCommand-response>) istream)
  "Deserializes a message object of type '<PositionCommand-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PositionCommand-response>)))
  "Returns string type for a service object of type '<PositionCommand-response>"
  "tanpack/PositionCommandResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PositionCommand-response)))
  "Returns string type for a service object of type 'PositionCommand-response"
  "tanpack/PositionCommandResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PositionCommand-response>)))
  "Returns md5sum for a message object of type '<PositionCommand-response>"
  "cc153912f1453b708d221682bc23d9ac")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PositionCommand-response)))
  "Returns md5sum for a message object of type 'PositionCommand-response"
  "cc153912f1453b708d221682bc23d9ac")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PositionCommand-response>)))
  "Returns full string definition for message of type '<PositionCommand-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PositionCommand-response)))
  "Returns full string definition for message of type 'PositionCommand-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PositionCommand-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PositionCommand-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PositionCommand-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PositionCommand)))
  'PositionCommand-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PositionCommand)))
  'PositionCommand-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PositionCommand)))
  "Returns string type for a service object of type '<PositionCommand>"
  "tanpack/PositionCommand")