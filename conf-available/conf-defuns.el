;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Additional functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when-compile (require 'cl))

(defun compile-file (file)
  (if (file-newer-than-file-p file (concat file "c"))
      (byte-compile-file file)))

;;TODO get rid of compile-file. Should look in ~/.emacs.d
(defun compile-emacs-d ()
  "Byte-compile all your dotfiles again."
  (interactive)
  (compile-file "~/.emacs.d/init.el")
  (compile-file "~/.emacs.d/private.el")
  (compile-file "~/.emacs.d/conf-auto-mode.el")
  (compile-file "~/.emacs.d/conf-bindings.el")
  (compile-file "~/.emacs.d/conf-cedet.el")
  (compile-file "~/.emacs.d/conf-c.el")
  (compile-file "~/.emacs.d/conf-compile.el")
  (compile-file "~/.emacs.d/conf-complete.el")
  (compile-file "~/.emacs.d/conf-defuns.el")
  (compile-file "~/.emacs.d/conf-diff.el")
  (compile-file "~/.emacs.d/conf-elpa.el")
  (compile-file "~/.emacs.d/conf-latex.el")
  (compile-file "~/.emacs.d/conf-lisp.el")
  (compile-file "~/.emacs.d/conf-matlab.el")
  (compile-file "~/.emacs.d/conf-message.el")
  (compile-file "~/.emacs.d/conf-misc.el")
  (compile-file "~/.emacs.d/conf-muse.el")
  (compile-file "~/.emacs.d/conf-python.el")
  (compile-file "~/.emacs.d/conf-registers.el")
  (compile-file "~/.emacs.d/conf-ruby.el")
  (compile-file "~/.emacs.d/conf-shell.el")
  (compile-file "~/.emacs.d/conf-text.el")
  (compile-file "~/.emacs.d/conf-twit.el")
  (byte-recompile-directory elisp-dir 0))

(defun electric-pair ()
  "Insert character pair without sournding spaces"
  (interactive)
  (let (parens-require-spaces)
    (insert-pair)))


;; (defun electric-pair ()
;;   "If at end of line, insert character pair without surrounding spaces.
;;    Otherwise, just insert the typed character."
;;   (interactive)
;;   (if (eolp) (let (parens-require-spaces) (insert-pair))
;;     (self-insert-command 1)))

(defun indent-page ()
  "Indent the entire buffer."
  (interactive)
  (save-excursion
    (push-mark (point-min) t t)
    (goto-char (point-max))
    (indent-region (mark) (point) nil)))

(autoload 'ascii-table         "ascii-table" nil t)
(autoload 'ascii-table-decimal "ascii-table" nil t)
(autoload 'ascii-table-octal   "ascii-table" nil t)
(autoload 'ascii-table-hex     "ascii-table" nil t)

(autoload 'count-words-region "count-words" nil t)
(autoload 'count-words-page   "count-words" nil t)

;;TODO add this to a mode that can be enabled / disabled
(autoload 'nuke-trailing-whitespace "whitespace" nil t)
(add-hook 'write-file-functions 'nuke-trailing-whitespace)

;;Make file executable according to umask if not already executable. If file
;;already has any execute bits set at all, do not change existing file modes.
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))


;;;TODO
;; (defun copy-to-register-1 (p1 p2)
;;   "Copy text selection to register named “1”."
;;   (interactive "r")
;;   (copy-to-register ?1 p1 p2 )
;;   )

;; (defun insert-register-content-1 ()
;;   "Insert register named “1”'s content."
;;   (interactive)
;;   (insert-register ?1)
;;   )

;; (global-set-key (kbd "<f7>") 'copy-to-register-1)
;; (global-set-key (kbd "<f8>") 'insert-register-content-1)


;;; ALIASES
(defalias 'gf 'grep-find)
(defalias 'fd 'find-dired)
(defalias 'sh 'shell)

(defalias 'qrr 'query-replace-regexp)
(defalias 'lml 'list-matching-lines)
(defalias 'dml 'delete-matching-lines)
(defalias 'rof 'recentf-open-files)

(defalias 'eb 'eval-buffer)
(defalias 'er 'eval-region)
(defalias 'ee 'eval-expression)

(defalias 'cr 'comment-region)
(defalias 'ur 'comment-region)

(defalias 'open 'find-file)
(defalias 'openo 'find-file-other-window)
(defalias 'o 'open)
(defalias 'oo 'openo)


(provide 'conf-defuns)
