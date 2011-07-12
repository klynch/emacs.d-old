;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Latex Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(eval-when-compile (require 'cl))

(set-variable (quote latex-run-command) "pdflatex")
(set-variable (quote tex-dvi-view-command) "open")

(autoload 'tex-mode-flyspell-verify "flyspell" "" t)
(add-hook 'LaTeX-mode-hook 'flyspell-mode) ;;LaTeX
(when (load "flyspell" t)
  (setq flyspell-issue-message-flag nil))

(provide 'conf-latex)
