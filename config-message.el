(require 'cl)

;; GROWL or its alternatives. must set directory first
(autoload 'todochiku-message "todochiku")
(autoload 'todochiku-icon "todochiku")
(autoload 'todochiku-in "todochiku" nil t)

(defvar todochiku-icons-directory (expand-file-name-dotemacs "todochiku-icons"))
(defvar todochiku-message-too t)

;;TODO make message alias functions like (msg ...)

(provide 'config-message)
