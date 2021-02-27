;; Auto-generated. Do not edit!


(when (boundp 'tanpack::Position)
  (if (not (find-package "TANPACK"))
    (make-package "TANPACK"))
  (shadow 'Position (find-package "TANPACK")))
(unless (find-package "TANPACK::POSITION")
  (make-package "TANPACK::POSITION"))
(unless (find-package "TANPACK::POSITIONREQUEST")
  (make-package "TANPACK::POSITIONREQUEST"))
(unless (find-package "TANPACK::POSITIONRESPONSE")
  (make-package "TANPACK::POSITIONRESPONSE"))

(in-package "ROS")





(defclass tanpack::PositionRequest
  :super ros::object
  :slots ())

(defmethod tanpack::PositionRequest
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

(defclass tanpack::PositionResponse
  :super ros::object
  :slots (_x _y _z ))

(defmethod tanpack::PositionResponse
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:z __z) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _z (float __z))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:z
   (&optional __z)
   (if __z (setq _z __z)) _z)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _z
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _z
       (sys::poke _z (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _z
     (setq _z (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass tanpack::Position
  :super ros::object
  :slots ())

(setf (get tanpack::Position :md5sum-) "cc153912f1453b708d221682bc23d9ac")
(setf (get tanpack::Position :datatype-) "tanpack/Position")
(setf (get tanpack::Position :request) tanpack::PositionRequest)
(setf (get tanpack::Position :response) tanpack::PositionResponse)

(defmethod tanpack::PositionRequest
  (:response () (instance tanpack::PositionResponse :init)))

(setf (get tanpack::PositionRequest :md5sum-) "cc153912f1453b708d221682bc23d9ac")
(setf (get tanpack::PositionRequest :datatype-) "tanpack/PositionRequest")
(setf (get tanpack::PositionRequest :definition-)
      "---
float32 x
float32 y
float32 z
")

(setf (get tanpack::PositionResponse :md5sum-) "cc153912f1453b708d221682bc23d9ac")
(setf (get tanpack::PositionResponse :datatype-) "tanpack/PositionResponse")
(setf (get tanpack::PositionResponse :definition-)
      "---
float32 x
float32 y
float32 z
")



(provide :tanpack/Position "cc153912f1453b708d221682bc23d9ac")


