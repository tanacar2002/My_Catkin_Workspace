
(cl:in-package :asdf)

(defsystem "tanpack-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "tanmsg" :depends-on ("_package_tanmsg"))
    (:file "_package_tanmsg" :depends-on ("_package"))
  ))