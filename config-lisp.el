;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LISP Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'cl)

;; Parenthesis highlighting for LISP/SCHEME
(autoload 'cparen-activate "cparen" nil t)
;; (add-hook 'lisp-mode-hook 'cparen-activate)
;; (add-hook 'lisp-interaction-mode-hook 'cparen-activate)
;; (add-hook 'emacs-lisp-mode-hook 'cparen-activate)

(provide 'config-lisp)
