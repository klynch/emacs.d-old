(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; C/C++ Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Customizations for all modes in CC Mode.
(eval-when-compile (require 'cc-mode))
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq show-trailing-whitespace t)
            (c-toggle-electric-state 1)
            ;;            (c-toggle-hungry-state 1)
            ;;            (c-toggle-auto-newline 1)
            ))

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; Set the indentation width for C-style programming languages
(setq-default c-basic-offset 2)

(provide 'config-c)
