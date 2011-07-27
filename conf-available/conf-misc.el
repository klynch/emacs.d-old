;;; conf-misc.el --- Tweaks Emacs behavioural configuration flags

(eval-when-compile (require 'cl))

(if (eq system-type 'darwin)
    (setq
     ns-pop-up-frames nil))

(setq default-tab-width 2)
(setq tab-width 2)

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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Buffers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Use TRAMP to open buffers over SSH
(setq tramp-default-method "ssh")

;;We want to uniquify names instead of foo<1> foo<2>
(require 'uniquify)
(setq
 uniquify-buffer-name-style 'post-forward
 uniquify-separator ":")

;;Do not ask before killing a buffer that has a running process
(remove-hook 'kill-buffer-query-functions 'process-kill-buffer-query-function)

;;Do not ask for "confirm" when creating new buffer
(setq confirm-nonexistent-file-or-buffer nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Interactively Do Things
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Sources:
;;  http://www.masteringemacs.org/articles/2010/10/10/introduction-to-ido-mode/
;;  http://www.emacswiki.org/emacs/InteractivelyDoThings

(setq ido-save-directory-list-file (expand-dotemacs "ido.last"))
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-create-new-buffer 'always)
;;(setq ido-use-filename-at-point 'guess)

;;Amount of time to wait until auto-searching for a file
(setq ido-auto-merge-delay-time 3)



;;ido-use-url-at-point
;;completion-ignored-extensions

;; ;;Display ido results vertically, rather than horizontally
;; (setq ido-decorationsq (quote ("\n-> "  ""   "\n "  "\n ..."  "["  "]"  "[No match]"   " [Matched]"  " [Not readable]"  " [Too big]"  "[Confirm]")))
;; (defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
;; (add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

;; ;; sort ido filelist by mtime instead of alphabetically
;; (add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
;; (add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
;; (defun ido-sort-mtime ()
;;   (setq ido-temp-list
;;         (sort ido-temp-list
;;               (lambda (a b)
;;                 (let ((ta (nth 5 (file-attributes (concat ido-current-directory a))))
;;                       (tb (nth 5 (file-attributes (concat ido-current-directory b)))))
;;                   (if (= (nth 0 ta) (nth 0 tb))
;;                       (> (nth 1 ta) (nth 1 tb))
;;                     (> (nth 0 ta) (nth 0 tb)))))))
;;   (ido-to-end  ;; move . files to end (again)
;;    (delq nil (mapcar
;;               ;;(lambda (x) (if (string-equal (substring x 0 1) ".") x))
;;               (lambda (x) (if (and (not (string-equal x ".")) (string-equal (substring x 0 1) ".")) x)) ;; We don't want to bury '.'
;;               ido-temp-list))))

(ido-mode 1)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; AceJump
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(provide 'conf-misc)
