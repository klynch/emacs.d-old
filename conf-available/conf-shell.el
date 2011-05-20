(eval-when-compile (require 'cl))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; EShell Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setenv "EDITOR" "eshell/emacs")

;; All config files should be contained in `user-emacs-directory'
(setq eshell-directory-name (expand-file-name-dotemacs "eshell/"))

;;;;;; ESHELL COLOR

;; (require 'ansi-color)
;; (require 'eshell)
;; (ansi-color-for-comint-mode-on)
;; (defun eshell-handle-ansi-color ()
;;   (ansi-color-apply-on-region eshell-last-output-start
;;                              eshell-last-output-end))
;;(add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)


;;;;;; ESHELL COMMANDS

(defun eshell/pwd-short ()
  "Returns just the top directory from `eshell/pwd'"
  (car (last (split-string (eshell/pwd) "/"))))

(defun eshell/clear ()
  "04Dec2001 - sailor, to clear the eshell buffer."
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

(defun eshell/emacs (&rest args)
  "Open a file in emacs. Some habits die hard."
  (if (null args)
      (bury-buffer)
    (mapc #'find-file (mapcar #'expand-file-name (eshell-flatten-list (reverse args))))))

(defun eshell/ec (&rest args)
  "Use `compile' to do background makes."
  (if (eshell-interactive-output-p)
      (let ((compilation-process-setup-function
             (list 'lambda nil
                   (list 'setq 'process-environment
                         (list 'quote (eshell-copy-environment))))))
        (compile (eshell-flatten-and-stringify args))
        (pop-to-buffer compilation-last-buffer))
    (throw 'eshell-replace-command
           (let ((l (eshell-stringify-list (eshell-flatten-list args))))
             (eshell-parse-command (car l) (cdr l))))))
(put 'eshell/ec 'eshell-no-numeric-conversions t)

(defun eshell-view-file (file)
  "A version of `view-file' which properly respects the eshell prompt."
  (interactive "fView file: ")
  (unless (file-exists-p file) (error "%s does not exist" file))
  (let ((had-a-buf (get-file-buffer file))
        (buffer (find-file-noselect file)))
    (if (eq (with-current-buffer buffer (get major-mode 'mode-class))
            'special)
        (progn
          (switch-to-buffer buffer)
          (message "Not using View mode because the major mode is special"))
      (let ((undo-window (list (window-buffer) (window-start)
                               (+ (window-point)
                                  (length (funcall eshell-prompt-function))))))
        (switch-to-buffer buffer)
        (view-mode-enter (cons (selected-window) (cons nil undo-window))
                         'kill-buffer)))))

;;TODO `eshell/vi' is the the same as `eshell/less' except with `find-file'
;;     instead of `eshell-view-file' ... Should Rewrite.

(defun eshell/less (&rest args)
  "Invoke `view-file' on a file. \"less +42 foo\" will go to line 42 in
    the buffer for foo."
  (while args
    (if (string-match "\\`\\+\\([0-9]+\\)\\'" (car args))
        (let* ((line (string-to-number (match-string 1 (pop args))))
               (file (pop args)))
          (eshell-view-file file)
          (goto-line line))
      (eshell-view-file (pop args)))))

(defalias 'eshell/more 'eshell/less)

(defun eshell/vi (&rest args)
  "Invoke `find-file' on the file.
\"vi +42 foo\" also goes to line 42 in the buffer."
  (while args
    (if (string-match "\\`\\+\\([0-9]+\\)\\'" (car args))
        (let* ((line (string-to-number (match-string 1 (pop args))))
               (file (pop args)))
          (find-file file)
          (goto-line line))
      (find-file (pop args)))))

(defalias 'eshell/vim 'eshell/vi)

(defun eshell/info (&optional subject)
  "Invoke `info', optionally opening the Info system to SUBJECT."
  (let ((buf (current-buffer)))
    (Info-directory)
    (if (not (null subject))
        (let ((node-exists (ignore-errors (Info-menu subject))))
          (if (not node-exists)
              (format "No menu item `%s' in node `(dir)Top'." subject))))))

;; ;;;###autoload
;; (defun bol-maybe-general-my (prompt &optional alt-bol-fcn)
;;   ""
;;   (interactive)
;;   (if (and (string-match (concat "^" (regexp-quote prompt)
;; 				 " *$")
;; 			 (buffer-substring-no-properties
;; 			  (line-beginning-position)
;; 			  (point)))
;; 	   (not (bolp)))
;;       (beginning-of-line)
;;     (if alt-bol-fcn
;; 	(funcall alt-bol-fcn)
;;       (beginning-of-line)
;;       (search-forward-regexp prompt))))

;; ;;;###autoload
;; (defun eshell-bol-maybe-my ()
;;   ""
;;   (interactive)
;;   (bol-maybe-general-my (funcall eshell-prompt-function)))

(defun eshell/maybe-bol ()
  "Make C-a go to the beginning of the command line, unless it
  is already there, in which case it goes to the beginning of the
  line. So if you are at the end of the command line and want to
  go to the real beginning of line, hit C-a twice."
  (interactive)
  (let ((p (point)))
    (eshell-bol)
    (if (= p (point))
        (beginning-of-line))))

(defun eshell-insert-last-word (n)
  (interactive "p")
  (insert (car (reverse
                (split-string
                 (eshell-previous-input-string (- n 1)))))))

(defun my-eshell-mode-map-hook ()
  "Binds useful keys to `eshell-mode-map'"
  (define-key eshell-mode-map (kbd "C-a") 'eshell/maybe-bol)
  (define-key eshell-mode-map (kbd "M-_") 'eshell-insert-last-word))

(add-hook 'eshell-mode-hook 'my-eshell-mode-map-hook)




;;;;;; ESHELL PROMPT

;; Returns the short propmpt string for eshell
(defun eshell-prompt-function-short ()
  "Makes a short eshell prompt to avoid moving out of the window"
  (concat (eshell/pwd-short)
          (if (= (user-uid) 0) " # " " $ ")))

;; Returns the long prompt string for eshell
(defun eshell-prompt-function-long ()
"Makes a long standard eshell prompt"
  (concat (getenv "USER") "@" (getenv "HOSTNAME") ":"
	  (eshell/pwd-short) (if (= (user-uid) 0) " # " " $ ")))

;; Returns the long prompt string for eshell
(defun eshell-prompt-function-time ()
"Makes a long standard eshell prompt"
  (concat (format-time-string "%l:%M %p") " | "
	  (getenv "USER") "@" (getenv "HOSTNAME") ":"
	  (eshell/pwd-short) (if (= (user-uid) 0) " # " " $ ")))

(setq eshell-prompt-function 'eshell-prompt-function-short)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ANSI Term
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar term-cmd (getenv "SHELL"))
(autoload 'term-check-proc "term")
(defun visit-ansi-term ()
  "If the current buffer is:
     1) a running ansi-term named *ansi-term*, rename it.
     2) a stopped ansi-term, kill it and create a new one.
     3) a non ansi-term, go to an already running ansi-term
        or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                (call-interactively 'rename-buffer)
              (if anon-term
                  (switch-to-buffer "*ansi-term*")
                (ansi-term term-cmd)))
          (kill-buffer (buffer-name))
          (ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (switch-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (ansi-term term-cmd))
        (ansi-term term-cmd)))))


(provide 'conf-shell)
