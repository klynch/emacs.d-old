(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Ediff Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

(provide 'config-diff)
