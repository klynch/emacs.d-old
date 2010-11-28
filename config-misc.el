;;; config-misc.el --- Tweaks Emacs behavioural configuration flags

(require 'cl)

(if (eq system-type 'darwin)
    (setq
     ns-pop-up-frames nil))

;; We want to uniquify names instead of foo<1> foo<2>
(require 'uniquify)
(setq
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")

(setq tramp-default-method "ssh")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Display
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Color syntax
(global-font-lock-mode t)

;; Column/line numbering in status line
(setq-default column-number-mode t)
(setq-default line-number-mode t)

;; Highlight matches from searches
(setq-default isearch-highlight t)
(setq-default query-replace-highlight t)
(setq-default search-highlight t)

;; Highlight marked block
(setq-default transient-mark-mode t)

;; Highlight paren matching
(show-paren-mode t)

;; Do not fold lines
(set-default 'truncate-lines t)
(set-default 'case-fold-search t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Behaviour
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Replace highlighted text with typed text
(delete-selection-mode t)

;; Set the line-wrapping width
(set-default 'fill-column 79)

;; Set the frame title
(setq-default frame-title-format (concat "%b - %F@" system-name))

;; Use spaces instead of tabs in general
(setq-default indent-tabs-mode nil)

;; Don't show the GNU splash screen
(setq-default inhibit-startup-message t)

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop adding newlines to the end of files when moving down
(setq-default next-line-add-newlines nil)

;; Resize the mini-buffer  necessary
(setq-default resize-minibuffer-mode t)

;; Scroll just one line when point passes off the screen
(setq-default scroll-conservatively 7)

;; stop forcing me to spell out "yes"
(fset 'yes-or-no-p 'y-or-n-p)

;; Stop that annoying beep
(setq visible-bell 'top-bottom)

;;Do not ask for "confirm" when creating new buffer
(setq confirm-nonexistent-file-or-buffer nil)

;;http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
(ido-mode 1)

;;(setq ido-use-filename-at-point 'guess)
;;ido-use-url-at-point
;;completion-ignored-extensions

(setq default-tab-width 2)
(setq tab-width 2)

(remove-hook 'kill-buffer-query-functions 'process-kill-buffer-query-function)


(provide 'config-misc)
