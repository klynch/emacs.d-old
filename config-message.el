(require 'cl)

;; GROWL or its alternatives. must set directory first
(autoload 'todochiku-message "todochiku")
(autoload 'todochiku-icon "todochiku")
(autoload 'todochiku-in "todochiku" nil t)

;;TODO try setvar... see if its overrided?
;; (custom-set-variables
;;  '(todochiku-icons-directory (concat dotemacs-dir "todochiku-icons"))
;;  '(todochiku-message-too t)
;; )

(defvar todochiku-icons-directory (concat dotemacs-dir "todochiku-icons"))
(defvar todochiku-message-too t)

(provide 'config-message)
