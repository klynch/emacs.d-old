;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LISP Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when-compile (require 'cl))

;; Parenthesis highlighting for LISP/SCHEME
(autoload 'cparen-activate "cparen" nil t)
(add-hook 'lisp-mode-hook 'cparen-activate)
(add-hook 'lisp-interaction-mode-hook 'cparen-activate)
(add-hook 'emacs-lisp-mode-hook 'cparen-activate)

(put 'lambda 'lisp-indent-function 'defun)
(put 'autoload 'lisp-indent-function 'defun)
(put 'progn 'lisp-indent-function 0)
(put 'prog1 'lisp-indent-function 1)
(put 'prog2 'lisp-indent-function 2)
(put 'save-excursion 'lisp-indent-function 0)
(put 'save-window-excursion 'lisp-indent-function 0)
(put 'save-restriction 'lisp-indent-function 0)
(put 'save-match-data 'lisp-indent-function 0)
(put 'let 'lisp-indent-function 1)
(put 'let* 'lisp-indent-function 1)
(put 'while 'lisp-indent-function 1)
(put 'if 'lisp-indent-function 2)
;;(put 'if 'lisp-indent-function nil)
(put 'unless 'lisp-indent-function 1)
(put 'when 'lisp-indent-function 1)
(put 'catch 'lisp-indent-function 1)
(put 'condition-case 'lisp-indent-function 2)
(put 'unwind-protect 'lisp-indent-function 1)
(put 'with-output-to-temp-buffer 'lisp-indent-function 1)
(put 'do 'lisp-indent-function 2)
(put 'do* 'lisp-indent-function 2)

;; (setq lisp-indent-function 'common-lisp-indent-function)

(provide 'conf-lisp)
