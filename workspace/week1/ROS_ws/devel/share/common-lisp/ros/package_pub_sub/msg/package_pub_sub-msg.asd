
(cl:in-package :asdf)

(defsystem "package_pub_sub-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "randomdata" :depends-on ("_package_randomdata"))
    (:file "_package_randomdata" :depends-on ("_package"))
  ))