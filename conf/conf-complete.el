(eval-when-compile (require 'cl))

;; TODO get TAB to properly indent

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; YaSnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun config-yasnippet ()
  (defvar snippets-dir (path "snippets")
    "The directory where all of our snippets are stored")

  (setq yas/prompt-functions '(yas/dropdown-prompt
                               yas/x-prompt
                               yas/ido-prompt
                               yas/completing-prompt))

  ;; (setq yas/wrap-around-region 'cua)

  ;; (yas/load-directory yas/snippet-dirs)
  (yas-global-mode 1) ;; or M-x yas-reload-all if you've started YASnippet already.

  (add-to-list 'auto-mode-alist '("\\.yasnippet$" . snippet-mode))
  (add-to-list 'auto-mode-alist '(".yas-setup$"   . emacs-lisp-mode))

  (defun yas/load-django-snippets ()
    "Load django snippets"
    (interactive)
    (yas/load-directory (path snippets-dir "django")))

  (defun new-snippet (&optional choose-instead-of-guess)
    "Create a new snippet"
    (interactive "P")
    (let ((guessed-directories (yas/guess-snippet-directories)))
      (switch-to-buffer "*new snippet*")
      (erase-buffer)
      (kill-all-local-variables)
      (snippet-mode)
      (set (make-local-variable 'yas/guessed-modes)
           (mapcar #'(lambda (d)
                       (intern (yas/table-name (car d))))
                   guessed-directories))
      (yas/expand-snippet "\
# -*- mode: snippet -*-
# name: $1
# key: $2
# binding: $3
# expand-env:
# type: ${4:snippet$$(yas/choose-value '(\"command\" \"snippet\"))}
# --
$0"))))

(do-if-require 'yasnippet 'config-yasnippet)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-Complete Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;don't break if not installed
(defun config-auto-complete-config ()
  (add-to-list 'ac-dictionary-directories (path "elisp"))
  (add-to-list 'ac-dictionary-directories (path "elisp" "auto-complete" "dict"))

  (setq ac-comphist-file (path "ac-comphist.dat"))
  (setq ac-dwim t)
  (ac-config-default)

  (ac-set-trigger-key "<tab>")
  (setq ac-auto-start nil)


  ;; set also the completion for eshell
  (add-hook 'eshell-mode-hook 'ac-eshell-mode-setup)

  ;; custom keybindings to use tab, enter and up and down arrows
  (define-key ac-complete-mode-map "\t" 'ac-expand)
  (define-key ac-complete-mode-map "\r" 'ac-complete)
  (define-key ac-complete-mode-map "\M-n" 'ac-next)
  (define-key ac-complete-mode-map "\M-p" 'ac-previous)

  ;; ;; Disabling Yasnippet completion
  ;; (defun epy-snips-from-table (table)
  ;;   (with-no-warnings
  ;;     (let ((hashtab (ac-yasnippet-table-hash table))
  ;;           (parent (ac-yasnippet-table-parent table))
  ;;           candidates)
  ;;       (maphash (lambda (key value)
  ;;                  (push key candidates))
  ;;                hashtab)
  ;;       (identity candidates)
  ;;       )))

  ;; (defun epy-get-all-snips ()
  ;;   (require 'yasnippet) ;; FIXME: find a way to conditionally load it
  ;;   (let (candidates)
  ;;     (maphash
  ;;      (lambda (kk vv) (push (epy-snips-from-table vv) candidates)) yas/tables)
  ;;     (apply 'append candidates))
  ;;   )


  ;; ;;(setq ac-ignores (concatenate 'list ac-ignores (epy-get-all-snips)))

  ;; ;; ropemacs Integration with auto-completion
  ;; (defun ac-ropemacs-candidates ()
  ;;   (mapcar (lambda (completion)
  ;;             (concat ac-prefix completion))
  ;;           (rope-completions)))

  ;; (ac-define-source nropemacs
  ;;   '((candidates . ac-ropemacs-candidates)
  ;;     (symbol     . "p")))

  ;; (ac-define-source nropemacs-dot
  ;;   '((candidates . ac-ropemacs-candidates)
  ;;     (symbol     . "p")
  ;;     (prefix     . c-dot)
  ;;     (requires   . 0)))

  ;; (defun ac-nropemacs-setup ()
  ;;   (setq ac-sources (append '(ac-source-nropemacs
  ;;                              ac-source-nropemacs-dot) ac-sources)))
  ;; (defun ac-python-mode-setup ()
  ;;   (add-to-list 'ac-sources 'ac-source-yasnippet))

  ;; (add-hook 'python-mode-hook 'ac-python-mode-setup)
  ;; (add-hook 'rope-open-project-hook 'ac-nropemacs-setup)

  )

(do-if-require 'auto-complete-config 'config-auto-complete-config)

;; (add-hook 'c++-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-semantic)))

;;(ac-set-trigger-key "TAB")
;;(setq ac-auto-start nil)
;;(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

;; Complete member name by C-c . for C++ mode.
;; (add-hook 'c++-mode-hook
;;           (lambda ()
;;             (local-set-key (kbd "C-c .") 'ac-complete-semantic)))


;; Eproject project management with emacs
(do-if-require 'eproject nil)


(provide 'conf-complete)
