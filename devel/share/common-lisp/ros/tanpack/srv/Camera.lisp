; Auto-generated. Do not edit!


(cl:in-package tanpack-srv)


;//! \htmlinclude Camera-request.msg.html

(cl:defclass <Camera-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass Camera-request (<Camera-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Camera-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Camera-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tanpack-srv:<Camera-request> is deprecated: use tanpack-srv:Camera-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Camera-request>) ostream)
  "Serializes a message object of type '<Camera-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Camera-request>) istream)
  "Deserializes a message object of type '<Camera-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Camera-request>)))
  "Returns string type for a service object of type '<Camera-request>"
  "tanpack/CameraRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Camera-request)))
  "Returns string type for a service object of type 'Camera-request"
  "tanpack/CameraRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Camera-request>)))
  "Returns md5sum for a message object of type '<Camera-request>"
  "a8c7a5d1cecba3ff861f52d5345675c3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Camera-request)))
  "Returns md5sum for a message object of type 'Camera-request"
  "a8c7a5d1cecba3ff861f52d5345675c3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Camera-request>)))
  "Returns full string definition for message of type '<Camera-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Camera-request)))
  "Returns full string definition for message of type 'Camera-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Camera-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Camera-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Camera-request
))
;//! \htmlinclude Camera-response.msg.html

(cl:defclass <Camera-response> (roslisp-msg-protocol:ros-message)
  ((height
    :reader height
    :initarg :height
    :type cl:integer
    :initform 0)
   (width
    :reader width
    :initarg :width
    :type cl:integer
    :initform 0)
   (step
    :reader step
    :initarg :step
    :type cl:integer
    :initform 0)
   (encoding
    :reader encoding
    :initarg :encoding
    :type cl:string
    :initform "")
   (is_bigendian
    :reader is_bigendian
    :initarg :is_bigendian
    :type cl:fixnum
    :initform 0)
   (data
    :reader data
    :initarg :data
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass Camera-response (<Camera-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Camera-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Camera-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name tanpack-srv:<Camera-response> is deprecated: use tanpack-srv:Camera-response instead.")))

(cl:ensure-generic-function 'height-val :lambda-list '(m))
(cl:defmethod height-val ((m <Camera-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:height-val is deprecated.  Use tanpack-srv:height instead.")
  (height m))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <Camera-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:width-val is deprecated.  Use tanpack-srv:width instead.")
  (width m))

(cl:ensure-generic-function 'step-val :lambda-list '(m))
(cl:defmethod step-val ((m <Camera-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:step-val is deprecated.  Use tanpack-srv:step instead.")
  (step m))

(cl:ensure-generic-function 'encoding-val :lambda-list '(m))
(cl:defmethod encoding-val ((m <Camera-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:encoding-val is deprecated.  Use tanpack-srv:encoding instead.")
  (encoding m))

(cl:ensure-generic-function 'is_bigendian-val :lambda-list '(m))
(cl:defmethod is_bigendian-val ((m <Camera-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:is_bigendian-val is deprecated.  Use tanpack-srv:is_bigendian instead.")
  (is_bigendian m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <Camera-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader tanpack-srv:data-val is deprecated.  Use tanpack-srv:data instead.")
  (data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Camera-response>) ostream)
  "Serializes a message object of type '<Camera-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'height)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'height)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'height)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'height)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'width)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'width)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'width)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'width)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'step)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'step)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'step)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'step)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'encoding))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'encoding))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'is_bigendian)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Camera-response>) istream)
  "Deserializes a message object of type '<Camera-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'height)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'height)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'height)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'height)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'width)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'width)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'width)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'width)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'step)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'step)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'step)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'step)) (cl:read-byte istream))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'encoding) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'encoding) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'is_bigendian)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'data) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'data)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Camera-response>)))
  "Returns string type for a service object of type '<Camera-response>"
  "tanpack/CameraResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Camera-response)))
  "Returns string type for a service object of type 'Camera-response"
  "tanpack/CameraResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Camera-response>)))
  "Returns md5sum for a message object of type '<Camera-response>"
  "a8c7a5d1cecba3ff861f52d5345675c3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Camera-response)))
  "Returns md5sum for a message object of type 'Camera-response"
  "a8c7a5d1cecba3ff861f52d5345675c3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Camera-response>)))
  "Returns full string definition for message of type '<Camera-response>"
  (cl:format cl:nil "uint32 height  ~%uint32 width~%uint32 step~%string encoding~%uint8 is_bigendian~%uint8[] data~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Camera-response)))
  "Returns full string definition for message of type 'Camera-response"
  (cl:format cl:nil "uint32 height  ~%uint32 width~%uint32 step~%string encoding~%uint8 is_bigendian~%uint8[] data~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Camera-response>))
  (cl:+ 0
     4
     4
     4
     4 (cl:length (cl:slot-value msg 'encoding))
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'data) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Camera-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Camera-response
    (cl:cons ':height (height msg))
    (cl:cons ':width (width msg))
    (cl:cons ':step (step msg))
    (cl:cons ':encoding (encoding msg))
    (cl:cons ':is_bigendian (is_bigendian msg))
    (cl:cons ':data (data msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Camera)))
  'Camera-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Camera)))
  'Camera-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Camera)))
  "Returns string type for a service object of type '<Camera>"
  "tanpack/Camera")