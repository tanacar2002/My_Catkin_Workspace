; Auto-generated. Do not edit!


(cl:in-package tanpack-srv)


;//! \htmlinclude Battery-request.msg.html

(cl:defclass <Battery-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Battery-request (<Battery-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Battery-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Battery-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tanpack-srv:<Battery-request> is deprecated: use tanpack-srv:Battery-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Battery-request>) ostream)
  "Serializes a message object of type '<Battery-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Battery-request>) istream)
  "Deserializes a message object of type '<Battery-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Battery-request>)))
  "Returns string type for a service object of type '<Battery-request>"
  "tanpack/BatteryRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Battery-request)))
  "Returns string type for a service object of type 'Battery-request"
  "tanpack/BatteryRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Battery-request>)))
  "Returns md5sum for a message object of type '<Battery-request>"
  "df7f08c1443b38b4ac0bbc90dbc93e28")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Battery-request)))
  "Returns md5sum for a message object of type 'Battery-request"
  "df7f08c1443b38b4ac0bbc90dbc93e28")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Battery-request>)))
  "Returns full string definition for message of type '<Battery-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Battery-request)))
  "Returns full string definition for message of type 'Battery-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Battery-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Battery-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Battery-request
))
;//! \htmlinclude Battery-response.msg.html

(cl:defclass <Battery-response> (roslisp-msg-protocol:ros-message)
  ((voltage
    :reader voltage
    :initarg :voltage
    :type cl:float
    :initform 0.0)
   (current
    :reader current
    :initarg :current
    :type cl:float
    :initform 0.0)
   (remaining
    :reader remaining
    :initarg :remaining
    :type cl:float
    :initform 0.0))
)

(cl:defclass Battery-response (<Battery-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Battery-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Battery-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tanpack-srv:<Battery-response> is deprecated: use tanpack-srv:Battery-response instead.")))

(cl:ensure-generic-function 'voltage-val :lambda-list '(m))
(cl:defmethod voltage-val ((m <Battery-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:voltage-val is deprecated.  Use tanpack-srv:voltage instead.")
  (voltage m))

(cl:ensure-generic-function 'current-val :lambda-list '(m))
(cl:defmethod current-val ((m <Battery-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:current-val is deprecated.  Use tanpack-srv:current instead.")
  (current m))

(cl:ensure-generic-function 'remaining-val :lambda-list '(m))
(cl:defmethod remaining-val ((m <Battery-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:remaining-val is deprecated.  Use tanpack-srv:remaining instead.")
  (remaining m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Battery-response>) ostream)
  "Serializes a message object of type '<Battery-response>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'voltage))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'current))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'remaining))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Battery-response>) istream)
  "Deserializes a message object of type '<Battery-response>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'voltage) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'current) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'remaining) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Battery-response>)))
  "Returns string type for a service object of type '<Battery-response>"
  "tanpack/BatteryResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Battery-response)))
  "Returns string type for a service object of type 'Battery-response"
  "tanpack/BatteryResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Battery-response>)))
  "Returns md5sum for a message object of type '<Battery-response>"
  "df7f08c1443b38b4ac0bbc90dbc93e28")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Battery-response)))
  "Returns md5sum for a message object of type 'Battery-response"
  "df7f08c1443b38b4ac0bbc90dbc93e28")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Battery-response>)))
  "Returns full string definition for message of type '<Battery-response>"
  (cl:format cl:nil "float32 voltage~%float32 current~%float32 remaining~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Battery-response)))
  "Returns full string definition for message of type 'Battery-response"
  (cl:format cl:nil "float32 voltage~%float32 current~%float32 remaining~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Battery-response>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Battery-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Battery-response
    (cl:cons ':voltage (voltage msg))
    (cl:cons ':current (current msg))
    (cl:cons ':remaining (remaining msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Battery)))
  'Battery-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Battery)))
  'Battery-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Battery)))
  "Returns string type for a service object of type '<Battery>"
  "tanpack/Battery")