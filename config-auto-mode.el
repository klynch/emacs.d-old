;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Additional modes
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'cl)

(add-to-list 'auto-mode-alist '("Makefile$"    . makefile-mode))

(autoload 'zencoding-mode "zencoding-mode" nil t)
(add-hook 'sgml-mode-hook 'zencoding-mode)

(autoload 'actr-mode "actr-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.actr$"     . actr-mode))
(add-to-list 'auto-mode-alist '("\\.act$"      . actr-mode))

(autoload 'stratego-mode "stratego" nil t)
(add-to-list 'auto-mode-alist '("\\.cltx$"     . stratego-mode))
(add-to-list 'auto-mode-alist '("\\.cr$"       . stratego-mode))
(add-to-list 'auto-mode-alist '("\\.r$"        . stratego-mode))
(add-to-list 'auto-mode-alist '("\\.ss$"       . stratego-mode))
(add-to-list 'auto-mode-alist '("\\.str$"      . stratego-mode))
(add-to-list 'auto-mode-alist '("\\.sdf$"      . stratego-mode))

(add-to-list 'auto-mode-alist '("\\.stk$"      . scheme-mode))

(add-to-list 'auto-mode-alist '("\\.t2t$"      . text2tags-mode))

(add-to-list 'auto-mode-alist '("\\.spu.c$"    . c-mode))
(add-to-list 'auto-mode-alist '("\\.spuc$"     . c-mode))

(add-to-list 'auto-mode-alist '("\\.org$"      . org-mode))
(add-to-list 'auto-mode-alist '("\\.org.txt$"  . org-mode))

(add-to-list 'auto-mode-alist '("/.?zsh.d/"    . shell-script-mode))

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text$"     . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdwn$"     . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$"       . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdt$"      . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

(provide 'config-auto-mode)
