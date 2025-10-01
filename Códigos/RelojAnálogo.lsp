(defun actualizar-reloj (/ tiempo seg minu hor ang-seg ang-min ang-hor sel ent datos)
  (while T
    ;; ------------------------
    ;; 1. Obtener hora del sistema
    ;; ------------------------
    (setq tiempo (* 86400.0 (getvar "DATE"))) ; segundos desde medianoche
    (setq seg (rem (fix tiempo) 60))          ; segundos actuales
    (setq minu (rem (fix (/ tiempo 60)) 60))  ; minutos actuales
    (setq hor (rem (fix (/ tiempo 3600)) 12)) ; horas actuales (formato 12h)

    ;; ------------------------
    ;; 2. Calcular ángulos en radianes (sentido horario = negativo)
    ;; ------------------------
    (setq ang-seg (* -1 seg (/ pi 30.0)))   ; segundero
    (setq ang-min (* -1 (+ (* minu (/ pi 30.0))
                           (* seg (/ pi 1800.0))))) ; minutero
    (setq ang-hor (* -1 (+ (* hor (/ pi 6.0))
                           (* minu (/ pi 360.0))))) ; horario

    ;; ------------------------
    ;; 3. Actualizar bloque segundero
    ;; ------------------------
    (if (setq sel (ssget "X" '((2 . "segundero"))))
      (progn
        (setq ent (ssname sel 0))
        (setq datos (entget ent))
        (setq datos (subst (cons 50 ang-seg) (assoc 50 datos) datos))
        (entmod datos)
      )
    )

    ;; ------------------------
    ;; 4. Actualizar bloque minutero
    ;; ------------------------
    (if (setq sel (ssget "X" '((2 . "minutero"))))
      (progn
        (setq ent (ssname sel 0))
        (setq datos (entget ent))
        (setq datos (subst (cons 50 ang-min) (assoc 50 datos) datos))
        (entmod datos)
      )
    )

    ;; ------------------------
    ;; 5. Actualizar bloque horario
    ;; ------------------------
    (if (setq sel (ssget "X" '((2 . "horario"))))
      (progn
        (setq ent (ssname sel 0))
        (setq datos (entget ent))
        (setq datos (subst (cons 50 ang-hor) (assoc 50 datos) datos))
        (entmod datos)
      )
    )

    (command "REGEN")          ; refrescar pantalla
    (vl-cmdf "_.delay" 1000)   ; esperar 1 segundo
  )
)

(defun c:RELOJ ()
  (princ "\nReloj iniciado. Presiona ESC para detener.")
  (actualizar-reloj)
  (princ)
)
