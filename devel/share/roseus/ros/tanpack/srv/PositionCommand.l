;; Auto-generated. Do not edit!


(when (boundp 'tanpack::PositionCommand)
  (if (not (find-package "TANPACK"))
    (make-package "TANPACK"))
  (shadow 'PositionCommand (find-package "TANPACK")))
(unless (find-package "TANPACK::POSITIONCOMMAND")
  (make-package "TANPACK::POSITIONCOMMAND"))
(unless (find-package "TANPACK::POSITIONCOMMANDREQUEST")
  (make-package "TANPACK::POSITIONCOMMANDREQUEST"))
(unless (find-package "TANPACK::POSITIONCOMMANDRESPONSE")
  (make-package "TANPACK::POSITIONCOMMANDRESPONSE"))

(in-package "ROS")





(defclass tanpack::PositionCommandRequest
  :super ros::object
  :slots (_x _y _z ))

(defmethod tanpack::PositionCommandRequest
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

(defclass tanpack::PositionCommandResponse
  :super ros::object
  :slots ())

(defmethod tanpack::PositionCommandResponse
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

(defclass tanpack::PositionCommand
  :super ros::object
  :slots ())

(setf (get tanpack::PositionCommand :md5sum-) "cc153912f1453b708d221682bc23d9ac")
(setf (get tanpack::PositionCommand :datatype-) "tanpack/PositionCommand")
(setf (get tanpack::PositionCommand :request) tanpack::PositionCommandRequest)
(setf (get tanpack::PositionCommand :response) tanpack::PositionCommandResponse)

(defmethod tanpack::PositionCommandRequest
  (:response () (instance tanpack::PositionCommandResponse :init)))

(setf (get tanpack::PositionCommandRequest :md5sum-) "cc153912f1453b708d221682bc23d9ac")
(setf (get tanpack::PositionCommandRequest :datatype-) "tanpack/PositionCommandRequest")
(setf (get tanpack::PositionCommandRequest :definition-)
      "float32 x
float32 y
float32 z
---
")

(setf (get tanpack::PositionCommandResponse :md5sum-) "cc153912f1453b708d221682bc23d9ac")
(setf (get tanpack::PositionCommandResponse :datatype-) "tanpack/PositionCommandResponse")
(setf (get tanpack::PositionCommandResponse :definition-)
      "float32 x
float32 y
float32 z
---
")



(provide :tanpack/PositionCommand "cc153912f1453b708d221682bc23d9ac")


