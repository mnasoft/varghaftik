;;;; varghaftik.lisp

(defpackage :varghaftik
  (:use #:cl)
  (:export n-sazerlend
	   k
	   mu
           R-mu)
  (:export gases-list)
  (:export k-data
           mu-data))

(in-package :varghaftik)

(defparameter |air-η[t(C),p=1atm][p565]|
  '((   0.0 171.0)
    ( 100.0 219.0)
    ( 200.0 260.0)
    ( 300.0 297.0)
    ( 400.0 330.0)
    ( 500.0 362.0)
    ( 600.0 391.0)
    ( 700.0 417.0)
    ( 800.0 443.0)
    ( 900.0 466.0)
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
  '(("Воздух" 	        111 	273.15 	17.12)
    ("Азот"             104 	273.15 	16.60)
    ("Кислород"	        125 	273.15 	19.20)
    ("Углекислый газ" 	254     273.15 	13.80)
    ("Угарный газ"      100     273.15 	16.80)
    ("Водород"         	71      273.15 	8.40)
    ("Аммиак" 	        503 	273.15 	9.30)
    ("Оксид серы(IV)" 	306 	273.15 	11.60)
    ("Гелий" 	        100     273.15 	18.60))
  "Газ 	                C[K]    T0[K]   η0[мкПа*с]
Коэффициенты для формулы Сазерленда,
которая может быть использована для определения 
динамической вязкости идеального газа в зависимости от температуры.
Эту формулу можно применять для температур в диапазоне 0 < T < 555 K 
и при давлениях менее 3,45 МПа с ошибкой менее 10 %, 
обусловленной зависимостью вязкости от давления."
  )

(defun n-sazerlend (aT &key (gas_name "Воздух"))
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
(n-sazerlend (+ 273 0) :gas_name \"Азот\")
=> 1.6524342e-5, \"Азот\"

Коэффициент динамической вязкости для некоторых газов в зависимости от абсолютной температуры по формуле Сазерленда
"
  (multiple-value-bind (name C T0 μ0)
      (values-list (assoc gas_name Sazerlend_koeff :test #'equal))
;;;;    (format T "~A ~A ~A ~A ~A " name aT T0 C μ0)
    (values (* 0.000001 μ0 (/ (+ T0 C) (+ aT C)) (expt (/ aT T0) 3/2)) name)))

(defun n-sazerlend-list()
  )

;;;;(mapcar #'(lambda (el) (list el(n-sazerlend (+ 273.15 el) :gas_name "Аммиак"))) '(-20.0 0.0 20. 40. 60. 80. 100. 150. 200. 300. 400.  600.0 800.0))

(defparameter mu-data
  '(("Воздух"                   0.02896)
    ("Азот"                     0.028)
    ("Кислород"                 0.032)
    ("Углекислый газ"           0.044)
    ("Угарный газ"              0.028)
    ("Водород"                  0.002)
    ("Аммиак"                   0.017)
    ("Оксид серы(IV)"           0.064)
    ("Гелий" 	                0.004)
    ("Метан" 	                0.016)
    ("Газ природный"            0.017)
    ("Газ попутный нефтяной"    0.0223)
    ("Газ природный_2010-08-20" 0.02103)
    ("Водород=40% Метан=60%"    0.0104318)
    ("Way-Chzou"                0.0201957)
    ("Way-Chzou-1"              0.0243857)
    ("Way-Chzou-2"              0.0245973)
    ("Way-Chzou-3"              0.0182722)
    ("China-01"                 0.0222418)
    )
  "Газ mu[kg/mol]
Молекулярные массы некоторых газов")

(defun mu (&key (gas_name "Воздух"))
"Возвращает молекулярную массу газа [kg/mol]"
  (nth 1 (assoc gas_name mu-data :test #'equal)))

(defparameter k-data
  '(("Воздух" 	                1.4)
    ("Азот"                     1.4)
    ("Кислород"	                1.4)
    ("Углекислый газ" 	        1.3)
    ("Угарный газ"              1.4)
    ("Водород"         	        1.41)
    ("Аммиак" 	                1.3)
    ("Оксид серы(IV)" 	        1.3)
    ("Гелий" 	                1.666)
    ("Метан" 	                1.3)
    ("Газ природный"            1.3)
    ("Газ попутный нефтяной"    1.3)
    ("Газ природный_2010-08-20" 1.29)
    ("Водород=40% Метан=60%"    1.34088596)
    ("Way-Chzou"                1.25968076)
    ("Way-Chzou-1"              1.21145303)
    ("Way-Chzou-2"              1.20909449)
    ("Way-Chzou-3"              1.28683442)
    ("China-01"                 1.3)
    )
  "Газ mu[kg/mol]
Коэффициент адиабаты некоторых газов")

(defun k (&key (gas_name "Воздух"))
"Возвращает показатель адиабаты газа [1]"
  (nth 1 (assoc gas_name k-data :test #'equal)))

(defconstant R-mu 8.314
  "@b(Описание:) Константа @b(R-mu) является универсальной газовой постоянной [J/(mol*K)]")

(defun gases-list ()
"Таблица с газами"
  (delete-duplicates
   (append (mapcar #'first k-data)
	   (mapcar #'first mu-data)
	   (mapcar #'first Sazerlend_koeff))))
