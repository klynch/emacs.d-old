;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Ruby Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when-compile (require 'cl))

(add-to-list 'auto-mode-alist '("\\.rake$"     . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$"    . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$"  . ruby-mode))

(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))

(add-to-list 'auto-mode-alist '("\\.irbrc$"    . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rvmrc$"    . ruby-mode))

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$"      . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$"     . yaml-mode))

;; (add-hook 'yaml-mode-hook
;;           '(lambda ()
;;              (define-key yaml-mode-map "\C-m" 'newline-and-indent)))


;; We never want to edit Rubinius bytecode
(add-to-list 'completion-ignored-extensions ".rbc")



(setq rsense-home (path "rsense"))
(add-to-list 'load-path (path rsense-home "etc"))
(require 'rsense)

;; ;; Complete by C-c .
(add-hook 'ruby-mode-hook
          (lambda ()
            ;; (setq ruby-deep-arglist t)
            ;; (setq ruby-deep-indent-paren nil)
            ;; (setq c-tab-always-indent nil)
            ;; (require 'inf-ruby)
            ;; (require 'ruby-compilation)
            (local-set-key (kbd "C-c .") 'ac-complete-rsense)))

(add-hook 'ruby-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))

(provide 'conf-ruby)
