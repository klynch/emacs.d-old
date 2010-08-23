(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Company Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when-compile (require 'company))

(autoload 'company-mode "company" nil t)
(setq company-backends nil)
(defun complete-or-indent ()
  (interactive)
  (if (company-manual-begin)
      (company-complete-common)
    (indent-according-to-mode)))

(defun indent-or-complete ()
  (interactive)
  (if (looking-at "\\_>")
      (company-complete-common)
    (indent-according-to-mode)))

(define-key k-minor-mode-map (kbd "\t")  'indent-or-complete)
(define-key k-minor-mode-map (kbd "\M-/")  'company-complete-common)

(defun add-company-backend (hook backends)
  "Adds a list of backends to the backendlist for a mode"
  (interactive)
  (add-hook 'hook (lambda ()
                    (set (make-local-variable 'company-backends) 'backend))))

(add-hook 'emacs-lisp-mode-hook (lambda () (set (make-local-variable 'company-backends) '(company-elisp))))
;;(add-company-backend 'emacs-lisp-mode-hook '(company-elisp))

(add-hook 'python-mode-hook (lambda () (set (make-local-variable 'company-backends) '(company-ropemacs company-pysmell))))
;;(add-company-backend 'python-mode-hook '(company-ropemacs company-pysmell))

;;TODO finish hooks
;;TODO automatically start
;;TODO bind TAB to YaSnippet -> Company Mode -> Indent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; YaSnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvar snippets-dir (concat dotemacs-dir "snippets"))

(require 'yasnippet)
(yas/initialize)
(yas/load-directory snippets-dir)

;;(add-to-list 'auto-mode-alist '(snippets-dir . snippet-mode))

;;(remove-hook 'write-file-functions 'nuke-trailing-whitespace t)

;; Enable versioning with default values (keep five last versions, I think!)
;;(setq version-control t)
;; Save all backup file in this directory.
;;(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-Complete Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'auto-complete-config)
;;(require 'auto-complete)
;; (global-auto-complete-mode t)

;; (setq ac-auto-start nil)
;; (global-set-key "\M-/" 'ac-start)
;; (define-key ac-complete-mode-map "\M-/" 'ac-stop)
;; ;;(define-key ac-complete-mode-map "\C-n" 'ac-next)
;; ;;(define-key ac-complete-mode-map "\C-p" 'ac-previous)
;; (define-key ac-complete-mode-map "\t" 'ac-complete)
;; ;;(define-key ac-complete-mode-map "\r" nil)
;; (setq ac-dwim t)

(provide 'config-complete)
