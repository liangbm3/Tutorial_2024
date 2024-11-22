
(cl:in-package :asdf)

(defsystem "packge_ser_cli-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "TwoNumbers" :depends-on ("_package_TwoNumbers"))
    (:file "_package_TwoNumbers" :depends-on ("_package"))
  ))