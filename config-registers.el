;;; config-registers.el --- Set up registers
;;
;; Part of the Emacs Starter Kit

;; Registers allow you to jump to a file or other location
;; quickly. Use C-x j ('C-x r j' is the default, but 'C-x r'
;; is bound to read-only) followed by the letter of the
;; register (i for init.el, r for this file) to jump to it.

;; You should add registers here for the files you edit most often.

(eval-when-compile (require 'cl))

(dolist (r `((?i (file . ,(expand-file-name-dotemacs"init.el")))
             (?b (file . ,(expand-file-name-dotemacs "config-bindings.el")))
             (?r (file . ,(expand-file-name-dotemacs "config-registers.el")))))
  (set-register (car r) (cadr r)))

(provide 'config-registers)
;;; config-registers.el ends here
