;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Layout Configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (fboundp 'winner-mode)
  (winner-mode 1))

(global-set-key (vector (list 'shift 'meta 'left))  'windmove-left)
(global-set-key (vector (list 'shift 'meta 'right)) 'windmove-right)
(global-set-key (vector (list 'shift 'meta 'up))    'windmove-up)
(global-set-key (vector (list 'shift 'meta 'down))  'windmove-down)

(provide 'conf-layout)
