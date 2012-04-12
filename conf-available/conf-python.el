;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Python Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when-compile (require 'cl))


(eval-when-compile (require 'python-mode))
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;; (add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-to-list 'completion-ignored-extensions "\\.pyc\\")

(eval-when-compile (require 'cython-mode))
(autoload 'cython-mode "cython-mode" "Mode for editing Cython source files")
(add-to-list 'auto-mode-alist '("\\.pyx\\'" . cython-mode))
(add-to-list 'auto-mode-alist '("\\.pxd\\'" . cython-mode))
(add-to-list 'auto-mode-alist '("\\.pxi\\'" . cython-mode))


;;(autoload 'rst-mode "rst-mode" "RST Mode." t)
;;(add-to-list 'auto-mode-alist '("\\.rst$"  . rst-mode))
;;(add-to-list 'auto-mode-alist '("\\.rest$" . rst-mode))

;;(autoload 'doctest-mode "doctest-mode" "doctest mode" t)
;;(add-to-list 'auto-mode-alist '("\\.doctest$" . doctest-mode))


;; (global-set-key [f10] 'flymake-goto-prev-error)
;; (global-set-key [f11] 'flymake-goto-next-error)

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


(add-hook 'python-mode-hook
          (lambda ()
            (setq skeleton-pair t)
            (define-key python-mode-map "(" 'skeleton-pair-insert-maybe)
            (define-key python-mode-map "[" 'skeleton-pair-insert-maybe)
            (define-key python-mode-map "{" 'skeleton-pair-insert-maybe)
            (define-key python-mode-map "\"" 'skeleton-pair-insert-maybe)
            (define-key python-mode-map "'" 'skeleton-pair-insert-maybe)
            (define-key python-mode-map "\C-m" 'newline-and-indent)

            (set-variable 'py-indent-offset 4)
            (set-variable 'py-smart-indentation nil)
            (set-variable 'indent-tabs-mode nil)
            ;; (setq tab-width 4)

            ;; (highlight-beyond-fill-column)

            ;; (pabbrev-mode)
            ;; (abbrev-mode)
            ))


(defun python-auto-fill-comments-only ()
  "Autofill inside of comments"
  (auto-fill-mode 1)
  (set (make-local-variable 'fill-nobreak-predicate)
       (lambda ()
         (not (python-in-string/comment)))))

(add-hook 'python-mode-hook 'python-auto-fill-comments-only)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Pymacs
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'pymacs)

(defun setup-ropemacs ()
  "Setup the ropemacs harness"
  (let ((pythonpath (getenv "PYTHONPATH"))
        (newpath (path "python-libs")))
    (setenv "PYTHONPATH"
            (if (null pythonpath)
                newpath
                (concat newpath path-separator pythonpath)))
    (pymacs-load "ropemacs" "rope-")

    ;; Stops from erroring if there's a syntax err
    (setq ropemacs-codeassist-maxfixes 3)
    (setq ropemacs-guess-project t)
    (setq ropemacs-enable-autoimport t)

    ;; Adding hook to automatically open a rope project if there is one
    ;; in the current or in the upper level directory
    (add-hook 'python-mode-hook
              (lambda ()
                (cond ((file-exists-p ".ropeproject")
                       (rope-open-project default-directory))
                      ((file-exists-p "../.ropeproject")
                       (rope-open-project (concat default-directory "..")))
                      )))))

;;=========================================================
;; Flymake additions, I have to put this one somwhere else?
;;=========================================================

(defun flymake-create-copy-file ()
  "Create a copy local file"
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace)))
    (file-relative-name
     temp-file
     (file-name-directory buffer-file-name))))

(defun flymake-command-parse (cmdline)
  "Parses the command line CMDLINE in a format compatible
       with flymake, as:(list cmd-name arg-list)

The CMDLINE should be something like:

 flymake %f python custom.py %f

%f will be substituted with a temporary copy of the file that is
 currently being checked.
"
  (let ((cmdline-subst (replace-regexp-in-string "%f" (flymake-create-copy-file) cmdline)))
    (setq cmdline-subst (split-string-and-unquote cmdline-subst))
    (list (first cmdline-subst) (rest cmdline-subst))
    ))


(when (load-file (path elisp-dir "flymake-patch.el"))
  (setq flymake-info-line-regex
        (append flymake-info-line-regex '("unused$" "^redefinition" "used$"))))

(defun epy-setup-checker (cmdline)
  (add-to-list 'flymake-allowed-file-name-masks
               (list "\\.py\\'" (apply-partially 'flymake-command-parse cmdline)))
  )

;; ;; Python or python mode?
;; (eval-after-load 'python
;;   '(progn
;;      (setup-ropemacs)

;;      (autoload 'virtualenv-activate "virtualenv"
;;        "Activate a Virtual Environment specified by PATH" t)
;;      (autoload 'virtualenv-workon "virtualenv"
;;        "Activate a Virtual Environment present using virtualenvwrapper" t)


;;      (add-hook 'python-mode-hook 'flymake-find-file-hook)
;;      )
;;   )






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

;;(epy-setup-checker "pyflakes %f")




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-completion
;;;  Integrates:
;;;   1) Rope
;;;   2) Yasnippet
;;;   all with AutoComplete.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun prefix-list-elements (list prefix)
  (let (value)
    (nreverse
     (dolist (element list value)
      (setq value (cons (format "%s%s" prefix element) value))))))
(defvar ac-source-rope
  '((candidates
     . (lambda ()
         (prefix-list-elements (rope-completions) ac-target))))
  "Source for Rope")
(defun ac-python-find ()
  "Python `ac-find-function'."
  (require 'thingatpt)
  (let ((symbol (car-safe (bounds-of-thing-at-point 'symbol))))
    (if (null symbol)
        (if (string= "." (buffer-substring (- (point) 1) (point)))
            (point)
          nil)
      symbol)))
(defun ac-python-candidate ()
  "Python `ac-candidates-function'"
  (let (candidates)
    (dolist (source ac-sources)
      (if (symbolp source)
          (setq source (symbol-value source)))
      (let* ((ac-limit (or (cdr-safe (assq 'limit source)) ac-limit))
             (requires (cdr-safe (assq 'requires source)))
             cand)
        (if (or (null requires)
                (>= (length ac-target) requires))
            (setq cand
                  (delq nil
                        (mapcar (lambda (candidate)
                                  (propertize candidate 'source source))
                                (funcall (cdr (assq 'candidates source)))))))
        (if (and (> ac-limit 1)
                 (> (length cand) ac-limit))
            (setcdr (nthcdr (1- ac-limit) cand) nil))
        (setq candidates (append candidates cand))))
    (delete-dups candidates)))
(add-hook 'python-mode-hook
          (lambda ()
                 (auto-complete-mode 1)
                 (set (make-local-variable 'ac-sources)
                      (append ac-sources '(ac-source-rope)))
                 (set (make-local-variable 'ac-find-function) 'ac-python-find)
                 (set (make-local-variable 'ac-candidate-function) 'ac-python-candidate)
                 (set (make-local-variable 'ac-auto-start) nil)))

;;Ryan's python specific tab completion
  ; Try the following in order:
  ; 1) Try a yasnippet expansion without autocomplete
  ; 2) If at the beginning of the line, indent
  ; 3) If at the end of the line, try to autocomplete
  ; 4) If the char after point is not alpha-numerical, try autocomplete
  ; 5) Try to do a regular python indent.
  ; 6) If at the end of a word, try autocomplete.
(define-key python-mode-map "\t" 'yas/expand)
(add-hook 'python-mode-hook
          (lambda ()
            (set (make-local-variable 'yas/trigger-fallback) 'python-expand-after-yasnippet)))
(defun python-indent ()
  "Runs indent-for-tab-command but returns t if it actually did an indent; nil otherwise"
  (let ((prev-point (point)))
    (indent-for-tab-command)
    (if (eql (point) prev-point)
        nil
      t)))
(defun python-expand-after-yasnippet ()
  (interactive)
  ;;2) Try indent at beginning of the line
  (let ((prev-point (point))
        (beginning-of-line nil))
    (save-excursion
      (move-beginning-of-line nil)
      (if (eql 0 (string-match "\\W*$" (buffer-substring (point) prev-point)))
          (setq beginning-of-line t)))
    (if beginning-of-line
        (python-indent)))
  ;;3) Try autocomplete if at the end of a line, or
  ;;4) Try autocomplete if the next char is not alpha-numerical
  (if (or (string-match "\n" (buffer-substring (point) (+ (point) 1)))
          (not (string-match "[a-zA-Z0-9]" (buffer-substring (point) (+ (point) 1)))))
      (ac-start)
    ;;5) Try a regular indent
    (if (not (python-indent))
        ;;6) Try autocomplete at the end of a word
        (if (string-match "\\W" (buffer-substring (point) (+ (point) 1)))
            (ac-start)))))

;; End Tab completion


;;Workaround so that Autocomplete is by default is only invoked explicitly,
;;but still automatically updates as you type while attempting to complete.
(defadvice ac-start (before advice-turn-on-auto-start activate)
  (set (make-local-variable 'ac-auto-start) t))
(defadvice ac-cleanup (after advice-turn-off-auto-start activate)
  (set (make-local-variable 'ac-auto-start) nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; End Auto Completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Flymake with Pyflakes
;; Disabling for now, it's really quite buggy.

;; (require 'flymake)
;; (load-library "flymake-cursor")
;; (when (load "flymake" t)
;;   (defun flymake-pyflakes-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                        'flymake-create-temp-inplace))
;;            (local-file (file-relative-name
;;                         temp-file
;;                         (file-name-directory buffer-file-name))))
;;       (list "pyflakes" (list local-file))))
;;   (add-to-list 'flymake-allowed-file-name-masks
;;                '("\\.py\\'" flymake-pyflakes-init)))
;; (add-hook 'find-file-hook 'flymake-find-file-hook)
;; (custom-set-faces
;;  '(flymake-errline ((((class color)) (:background "DarkRed"))))
;;  '(flymake-warnline ((((class color)) (:background "DarkBlue")))))


;;Autofill comments
;;TODO: make this work for docstrings too.
;;      but docstrings just use font-lock-string-face unfortunately
(add-hook 'python-mode-hook
          (lambda ()
            (auto-fill-mode 1)
            (set (make-local-variable 'fill-nobreak-predicate)
                 (lambda ()
                   (not (eq (get-text-property (point) 'face)
                            'font-lock-comment-face))))))




(provide 'conf-python)
