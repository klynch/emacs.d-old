;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Additional functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'cl)

(defun recompile-init ()
  "Byte-compile all your dotfiles again."
  (interactive)
  (if (file-newer-than-file-p "~/.emacs" "~/.emacs.elc")
      (byte-compile-file "~/.emacs"))
  (if (file-newer-than-file-p "~/.emacs-private.el" "~/.emacs-private.elc")
      (byte-compile-file "~/.emacs-private.el"))
  (byte-recompile-directory elisp-dir 0))

(defun electric-pair ()
  "If at end of line, insert character pair without surrounding spaces.
   Otherwise, just insert the typed character."
  (interactive)
  (if (eolp) (let (parens-require-spaces) (insert-pair))
    (self-insert-command 1)))

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

(provide 'config-defuns)
