(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Compile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Install mode-compile to give friendlier compiling support!
(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(define-key k-minor-mode-map (kbd "\C-c c")  'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
(define-key k-minor-mode-map (kbd "\C-c k")  'mode-compile-kill)


;;TODO
;;(setf 'compilation-buffer-name-function (lambda (mode) (concat "*" (downcase mode-name) "*"))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Debug
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'gdb-mode-hook
          (lambda ()
            (setq gdb-many-windows 't)
            (define-key gud-mode-map [f8] 'gdb-many-windows)
            (setq gdb-use-separate-io-buffer 't)
            (if (fboundp 'tool-bar-mode) (tool-bar-mode 't))
            ))
;;TODO remove tool-bar-mode after exit ?

;; (defvar gud-overlay
;;   (let* ((ov (make-overlay (point-min) (point-min))))
;;     (overlay-put ov 'face 'secondary-selection)
;;     ov)
;;   "Overlay variable for GUD highlighting.")

;; (defadvice gud-display-line (after my-gud-highlight act)
;;   "Highlight current line."
;;   (let* ((ov gud-overlay)
;;          (bf (gud-find-file true-file)))
;;     (save-excursion
;;       (set-buffer bf)
;;       (move-overlay ov
;;                     (line-beginning-position)
;;                     (line-end-position)
;;                     (current-buffer)))))

;; ;; Should be gud-kill-buffer-hook?
;; (defun gud-kill-buffer ()
;;   (if (eq major-mode 'gud-mode)
;;       (delete-overlay gud-overlay)))

;; (add-hook 'kill-buffer-hook 'gud-kill-buffer)

;; (require 'gud)
;; (require 'gdb-ui)
;; (setq gud-gdb-command-name "gdb --annotate=3 --fullname")
;; ;;(add-hook 'gdb-mode-hook '(lambda () (require 'gdb-highlight)))
;; (add-hook 'gud-mode-hook
;;           '(lambda ()
;;              ;; move to beginning of line, after prompt
;;              (local-set-key [home] 'comint-bol)
;;              ;; cycle backward through command history
;;              (local-set-key [up] '(lambda () (interactive)
;;                                     (if (comint-after-pmark-p)
;;                                         (comint-previous-input 1)
;;                                       (previous-line 1))))
;;              ;; cycle forward through command history
;;              (local-set-key [down] '(lambda () (interactive)
;;                                       (if (comint-after-pmark-p)
;;                                           (comint-next-input 1)
;;                                         (forward-line 1))))
;;              ))

;; (defun humble-gud ()
;;   "gdb if not already running, otherwise bring to front"
;;   (interactive)
;;   (require 'gud)
;;   ;;find running gdb process
;;   (if (and (boundp 'gud-comint-buffer)
;;            gud-comint-buffer
;;            (buffer-name gud-comint-buffer)
;;            (get-buffer-process gud-comint-buffer))
;;       (if (fboundp 'gdb-restore-windows)
;;           (gdb-restore-windows)
;;         (pop-to-buffer gud-comint-buffer))
;;     (call-interactively
;;      (or (cdr (assq major-mode preferred-debugger-alist))
;;          'gdb))))

;; (defun humble-recompile ()
;;   "recompile if possible"
;;   (interactive)
;;   (if (fboundp 'recompile)
;;       (recompile)
;;     (call-interactively 'compile)))


(provide 'config-compile)
