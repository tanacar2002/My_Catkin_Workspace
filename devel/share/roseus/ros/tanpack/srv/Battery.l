;; Auto-generated. Do not edit!


(when (boundp 'tanpack::Battery)
  (if (not (find-package "TANPACK"))
    (make-package "TANPACK"))
  (shadow 'Battery (find-package "TANPACK")))
(unless (find-package "TANPACK::BATTERY")
  (make-package "TANPACK::BATTERY"))
(unless (find-package "TANPACK::BATTERYREQUEST")
  (make-package "TANPACK::BATTERYREQUEST"))
(unless (find-package "TANPACK::BATTERYRESPONSE")
  (make-package "TANPACK::BATTERYRESPONSE"))

(in-package "ROS")





(defclass tanpack::BatteryRequest
  :super ros::object
  :slots ())

(defmethod tanpack::BatteryRequest
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

(defclass tanpack::BatteryResponse
  :super ros::object
  :slots (_voltage _current _remaining ))

(defmethod tanpack::BatteryResponse
  (:init
   (&key
    ((:voltage __voltage) 0.0)
    ((:current __current) 0.0)
    ((:remaining __remaining) 0.0)
    )
   (send-super :init)
   (setq _voltage (float __voltage))
   (setq _current (float __current))
   (setq _remaining (float __remaining))
   self)
  (:voltage
   (&optional __voltage)
   (if __voltage (setq _voltage __voltage)) _voltage)
  (:current
   (&optional __current)
   (if __current (setq _current __current)) _current)
  (:remaining
   (&optional __remaining)
   (if __remaining (setq _remaining __remaining)) _remaining)
  (:serialization-length
   ()
   (+
    ;; float32 _voltage
    4
    ;; float32 _current
    4
    ;; float32 _remaining
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _voltage
       (sys::poke _voltage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _current
       (sys::poke _current (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _remaining
       (sys::poke _remaining (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _voltage
     (setq _voltage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _current
     (setq _current (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _remaining
     (setq _remaining (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(defclass tanpack::Battery
  :super ros::object
  :slots ())

(setf (get tanpack::Battery :md5sum-) "df7f08c1443b38b4ac0bbc90dbc93e28")
(setf (get tanpack::Battery :datatype-) "tanpack/Battery")
(setf (get tanpack::Battery :request) tanpack::BatteryRequest)
(setf (get tanpack::Battery :response) tanpack::BatteryResponse)

(defmethod tanpack::BatteryRequest
  (:response () (instance tanpack::BatteryResponse :init)))

(setf (get tanpack::BatteryRequest :md5sum-) "df7f08c1443b38b4ac0bbc90dbc93e28")
(setf (get tanpack::BatteryRequest :datatype-) "tanpack/BatteryRequest")
(setf (get tanpack::BatteryRequest :definition-)
      "---
float32 voltage
float32 current
float32 remaining
")

(setf (get tanpack::BatteryResponse :md5sum-) "df7f08c1443b38b4ac0bbc90dbc93e28")
(setf (get tanpack::BatteryResponse :datatype-) "tanpack/BatteryResponse")
(setf (get tanpack::BatteryResponse :definition-)
      "---
float32 voltage
float32 current
float32 remaining
")



(provide :tanpack/Battery "df7f08c1443b38b4ac0bbc90dbc93e28")


