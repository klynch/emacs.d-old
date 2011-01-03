(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; YaSnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar snippets-dir (concat dotemacs-dir "snippets"))

(require 'yasnippet)
(yas/initialize)
(yas/load-directory snippets-dir)

;;(add-to-list 'auto-mode-alist '(snippets-dir . snippet-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-Complete Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(when (require 'auto-complete-config nil 'noerror) ;; don't break if not installed
  (add-to-list 'ac-dictionary-directories (concat dotemacs-dir "elisp/auto-complete/dict"))
  (setq ac-comphist-file  "~/.emacs.d/ac-comphist.dat")
  (ac-config-default))
(require 'auto-complete-config)

;; (add-hook 'c++-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-semantic)))

;;(ac-set-trigger-key "TAB")
;;(setq ac-auto-start nil)
;;(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

;; Complete member name by C-c . for C++ mode.
;; (add-hook 'c++-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "C-c .") 'ac-complete-semantic)))

;; (setq ac-dwim t)

(provide 'config-complete)
