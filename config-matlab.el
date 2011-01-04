;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MATLAB Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when-compile (require 'cl))

(require 'matlab)
;; (add-to-list 'auto-mode-alist '("\\.m$" . matlab-mode))
(setq matlab-shell-command-switches '("-nojvm" "-nodesktop" "-nodisplay" "-nosplash")
      matlab-shell-history-file "~/.matlab/R2009a/history.m")

(autoload 'octave-mode "octave-mod" nil t)
(autoload 'run-octave "octave-inf" nil t)
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))

(add-hook 'inferior-octave-mode-hook
          (lambda ()
            (turn-on-font-lock)
            (define-key inferior-octave-mode-map [up]
              'comint-previous-input)
            (define-key inferior-octave-mode-map [down]
              'comint-next-input)))

(provide 'config-matlab)
