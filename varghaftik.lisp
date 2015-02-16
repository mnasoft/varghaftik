;;;; varghaftik.lisp

(in-package #:varghaftik)

;;; "varghaftik" goes here. Hacks and glory await!

(defparameter |air-η[t(C),p=1atm][p565]|
  '((0.0 171.0)
    (100.0 219.0)
    (200.0 260.0)
    (300.0 297.0)
    (400.0 330.0)
    (500.0 362.0)
    (600.0 391.0)
    (700.0 417.0)
    (800.0 443.0)
    (900.0 466.0)
    (1000.0 490.0)
    (1100.0 512.0)
    (1200.0 534.0)
    (1400.0 576.0)
    (1600.0 616.0)
    (1800.0 655.0)
    (2000.0 618.0)
    )
  "Зависимость коэффициента динамической вязкости воздуха от температуры в цельсиях [C] при атмосферном давлении
10e-6*г/см*с
"
  )

(defparameter Sazerlend_koeff
  '(
    ("Воздух" 	        120 	291.15 	18.27)
    ("Азот"             111 	300.55 	17.81)
    ("Кислород"	        127 	292.25 	20.18)
    ("Углекислый газ" 	240 	293.15 	14.8)
    ("Угарный газ"      118 	288.15 	17.2)
    ("Водород"         	72 	293.85 	8.76)
    ("Аммиак" 	        370 	293.15 	9.82)
    ("Оксид серы(IV)" 	416 	293.65 	12.54)
    ("Гелий" 	        79.4    273 	19)
    )
  "Газ 	                C[K]    T0[K]   μ0[мкПа*с]
Коэффициенты для формулы Сазерленда,
которая может быть использована для определения 
динамической вязкости идеального газа в зависимости от температуры.
Эту формулу можно применять для температур в диапазоне 0 < T < 555 K 
и при давлениях менее 3,45 МПа с ошибкой менее 10 %, 
обусловленной зависимостью вязкости от давления."
  )

(defun η_sazerlend (aT &key (gas_name "Воздух"))
  "Формула Сазерленда может быть использована для определения 
динамической вязкости идеального газа в зависимости от температуры.
Эту формулу можно применять для температур в диапазоне 0 < T < 555 K 
и при давлениях менее 3,45 МПа с ошибкой менее 10 %, 
обусловленной зависимостью вязкости от давления.
aT[K] - температура 
T0 - 291.15
C  - 120.0
μ0 - 18.27
gas_name - \"Воздух\" \"Азот\" \"Кислород\" 
           \"Углекислый газ\" \"Угарный газ\" 
           \"Водород\" \"Аммиак\" \"Оксид серы(IV)\" 
           \"Гелий\"
Пример использования:
(η_sazerlend (+ 273 0) :gas_name \"Азот\")
=> 1.6524342e-5, \"Азот\"
"
  (multiple-value-bind (name C T0 μ0)
      (values-list (assoc gas_name Sazerlend_koeff :test #'equal))
    (format T "~A ~A ~A ~A ~A " name aT T0 C μ0)
    (values (* 0.000001 μ0 (/ (+ T0 C) (+ aT C)) (expt (/ aT T0) 3/2)) name)))






