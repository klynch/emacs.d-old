(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Text Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Text mode is happier than Fundamental mode ;-)
(setq default-major-mode 'text-mode)

;; Activate word-wrapping for text mode
(add-hook 'text-mode-hook 'text-mode-hook-identify)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Allow tabs in text-mode
(add-hook 'text-mode-hook '(lambda () (setq indent-tabs-mode t)))

(provide 'config-text)
