;;;; package.lisp

(defpackage #:varghaftik
  (:use #:cl)
  (:export η_sazerlend) ; Коэффициент динамической вязкости для некоторых газов в зависимости от абсолютной температуры по формуле Сазерленда
  (:export k)
  (:export μ)
  (:export  Rμ)
  )

;;;;(declaim (optimize (space 0) (compilation-speed 0)  (speed 0) (safety 3) (debug 3)))
