;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Python Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when-compile (require 'cl))

;;; Electric Pairs
(add-hook 'python-mode-hook
          (lambda ()
            (define-key py-mode-map "\"" 'electric-pair)
            (define-key py-mode-map "\'" 'electric-pair)
            (define-key py-mode-map "(" 'electric-pair)
            (define-key py-mode-map "[" 'electric-pair)
            (define-key py-mode-map "{" 'electric-pair)
            (define-key py-mode-map "\C-m" 'newline-and-indent)
            ;; (define-key py-mode-map ")" 'electric-pair-close-paren)
            ;; (define-key py-mode-map "]" 'electric-pair-close-bracket)
            ;; (define-key py-mode-map "}" 'electric-pair-close-brace)

            (setq indent-tabs-mode nil)
            (setq tab-width 4)))

;;(autoload 'rst-mode "rst-mode" "RST Mode." t)
;;(add-to-list 'auto-mode-alist '("\\.rst$"  . rst-mode))
;;(add-to-list 'auto-mode-alist '("\\.rest$" . rst-mode))

;;(autoload 'doctest-mode "doctest-mode" "doctest mode" t)
;;(add-to-list 'auto-mode-alist '("\\.doctest$" . doctest-mode))

;;(eval-when-compile (require 'python-mode))
;;(autoload 'python-mode "python-mode" "Python Mode." t)
;;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;;(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             (set-variable 'py-indent-offset 4)
;;             ;; (set-variable 'py-smart-indentation nil)
;;             (set-variable 'indent-tabs-mode nil)
;;             (define-key py-mode-map (kbd "RET") 'newline-and-indent)
;;             (define-key py-mode-map [f8]        'flymake-mode)
;;             (define-key py-mode-map [f9]        'python-mode)
;;             (define-key py-mode-map [f10]       'doctest-mode)
;;             (define-key py-mode-map [f11]       'rst-mode)
;;             ;; (define-key py-mode-map [tab] 'yas/expand)
;;             ;; (setq yas/after-exit-snippet-hook 'indent-according-to-mode)
;;             ;; (smart-operator-mode-on)
;;             ))

;; (eval-when-compile (require 'flymake))
;; ;; code checking via flymake
;; ;; set code checker here from "epylint", "pyflakes"
;; (defvar pycodechecker "pyflakes")
;; (when (load "flymake" t)
;;   (defun flymake-pycodecheck-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list pycodechecker (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pycodecheck-init)))

;; (add-hook 'find-file-hook 'flymake-find-file-hook)

(provide 'conf-python)
