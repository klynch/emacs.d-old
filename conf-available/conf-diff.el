;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Ediff Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when-compile (require 'cl))

(eval-after-load 'diff-mode
  '(progn
     (set-face-attribute 'diff-added             nil :foreground "green4")
     (set-face-attribute 'diff-file-header       nil :foreground "blue1")
     (set-face-attribute 'diff-hunk-header       nil :foreground "cyan3")
     ;;(set-face-attribute 'diff-indicator-changed nil :foreground "green4")
     ;;(set-face-attribute 'diff-refine-change     nil :foreground "green4")
     (set-face-attribute 'diff-changed           nil :foreground "yellow")
     (set-face-attribute 'diff-function          nil :foreground "green4")
     (set-face-attribute 'diff-index             nil :foreground "white" :weight 'bold)
     ;;(set-face-attribute 'diff-indicator-removed nil :foreground "green4")
     (set-face-attribute 'diff-removed           nil :foreground "red4")
     (set-face-attribute 'diff-context           nil :foreground "OliveDrab1")
     (set-face-attribute 'diff-header            nil :foreground "aquamarine1")
     ;;(set-face-attribute 'diff-indicator-added   nil :foreground "red4")
     ;;(set-face-attribute 'diff-nonexistent       nil :foreground "red4")
     ))


(eval-after-load 'magit
  '(progn
     (set-face-attribute 'magit-diff-add         nil :foreground "green4")
     (set-face-attribute 'magit-diff-file-header nil :foreground "blue1")
     ;;(set-face-attribute 'magit-diff-none        nil :inherit 'diff-added)
     (set-face-attribute 'magit-diff-del         nil :foreground "red4") ;;OrangeRed
     (set-face-attribute 'magit-diff-hunk-header nil :foreground "cyan3")
     ))


;; http://www.emacswiki.org/emacs/EdiffMode
;; (setq ediff-split-window-function 'split-window-horizontally)
;; (setq ediff-split-window-function (lambda (&optional arg)
;;                                     (if (> (frame-width) 150)
;;                                         (split-window-horizontally arg)
;;                                       (split-window-vertically arg))))

;; ediff-make-wide-display-function
;; ediff-toggle-read-only-function

;; Usage: emacs -diff file1 file2
(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
        (file2 (pop command-line-args-left)))
    (ediff file1 file2)))

(add-to-list 'command-switch-alist '("diff" . command-line-diff))

(provide 'conf-diff)
