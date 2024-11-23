
(cl:in-package :asdf)

(defsystem "service_pkg-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "TwoNumbers" :depends-on ("_package_TwoNumbers"))
    (:file "_package_TwoNumbers" :depends-on ("_package"))
  ))