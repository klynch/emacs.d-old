(eval-when-compile (require 'cl))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; YaSnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar snippets-dir (expand-file-name-dotemacs "snippets"))

(require 'yasnippet)
(yas/initialize)
(setq yas/root-directory (list (expand-file-name "master" snippets-dir)
                               (expand-file-name "licenses" snippets-dir) ))
;; (yas/load-directory snippets-dir)
;; (yas/load-directory yas/root-directory)
(yas/reload-all)

;;(add-to-list 'auto-mode-alist '(snippets-dir . snippet-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-Complete Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;don't break if not installed
(when (require 'auto-complete-config nil 'noerror)

  (add-to-list 'ac-dictionary-directories
               (expand-file-name-dotemacs "elisp/auto-complete/dict"))
  (setq ac-comphist-file
        (expand-file-name-dotemacs "ac-comphist.dat"))
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

(provide 'conf-complete)
