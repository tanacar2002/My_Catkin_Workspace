;; Auto-generated. Do not edit!


(when (boundp 'tanpack::Camera)
  (if (not (find-package "TANPACK"))
    (make-package "TANPACK"))
  (shadow 'Camera (find-package "TANPACK")))
(unless (find-package "TANPACK::CAMERA")
  (make-package "TANPACK::CAMERA"))
(unless (find-package "TANPACK::CAMERAREQUEST")
  (make-package "TANPACK::CAMERAREQUEST"))
(unless (find-package "TANPACK::CAMERARESPONSE")
  (make-package "TANPACK::CAMERARESPONSE"))

(in-package "ROS")





(defclass tanpack::CameraRequest
  :super ros::object
  :slots ())

(defmethod tanpack::CameraRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass tanpack::CameraResponse
  :super ros::object
  :slots (_height _width _step _encoding _is_bigendian _data ))

(defmethod tanpack::CameraResponse
  (:init
   (&key
    ((:height __height) 0)
    ((:width __width) 0)
    ((:step __step) 0)
    ((:encoding __encoding) "")
    ((:is_bigendian __is_bigendian) 0)
    ((:data __data) (make-array 0 :initial-element 0 :element-type :char))
    )
   (send-super :init)
   (setq _height (round __height))
   (setq _width (round __width))
   (setq _step (round __step))
   (setq _encoding (string __encoding))
   (setq _is_bigendian (round __is_bigendian))
   (setq _data __data)
   self)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:step
   (&optional __step)
   (if __step (setq _step __step)) _step)
  (:encoding
   (&optional __encoding)
   (if __encoding (setq _encoding __encoding)) _encoding)
  (:is_bigendian
   (&optional __is_bigendian)
   (if __is_bigendian (setq _is_bigendian __is_bigendian)) _is_bigendian)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:serialization-length
   ()
   (+
    ;; uint32 _height
    4
    ;; uint32 _width
    4
    ;; uint32 _step
    4
    ;; string _encoding
    4 (length _encoding)
    ;; uint8 _is_bigendian
    1
    ;; uint8[] _data
    (* 1    (length _data)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _height
       (write-long _height s)
     ;; uint32 _width
       (write-long _width s)
     ;; uint32 _step
       (write-long _step s)
     ;; string _encoding
       (write-long (length _encoding) s) (princ _encoding s)
     ;; uint8 _is_bigendian
       (write-byte _is_bigendian s)
     ;; uint8[] _data
     (write-long (length _data) s)
     (princ _data s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _height
     (setq _height (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _width
     (setq _width (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _step
     (setq _step (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _encoding
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _encoding (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint8 _is_bigendian
     (setq _is_bigendian (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8[] _data
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _data (make-array n :element-type :char))
     (replace _data buf :start2 ptr-) (incf ptr- n))
   ;;
   self)
  )

(defclass tanpack::Camera
  :super ros::object
  :slots ())

(setf (get tanpack::Camera :md5sum-) "a8c7a5d1cecba3ff861f52d5345675c3")
(setf (get tanpack::Camera :datatype-) "tanpack/Camera")
(setf (get tanpack::Camera :request) tanpack::CameraRequest)
(setf (get tanpack::Camera :response) tanpack::CameraResponse)

(defmethod tanpack::CameraRequest
  (:response () (instance tanpack::CameraResponse :init)))

(setf (get tanpack::CameraRequest :md5sum-) "a8c7a5d1cecba3ff861f52d5345675c3")
(setf (get tanpack::CameraRequest :datatype-) "tanpack/CameraRequest")
(setf (get tanpack::CameraRequest :definition-)
      "---
uint32 height  
uint32 width
uint32 step
string encoding
uint8 is_bigendian
uint8[] data

")

(setf (get tanpack::CameraResponse :md5sum-) "a8c7a5d1cecba3ff861f52d5345675c3")
(setf (get tanpack::CameraResponse :datatype-) "tanpack/CameraResponse")
(setf (get tanpack::CameraResponse :definition-)
      "---
uint32 height  
uint32 width
uint32 step
string encoding
uint8 is_bigendian
uint8[] data

")



(provide :tanpack/Camera "a8c7a5d1cecba3ff861f52d5345675c3")


