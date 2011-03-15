(eval-when-compile (require 'cl))

(add-to-list 'load-path (expand-file-name-dotemacs "elisp/org-mode/lisp"))

(require 'org-install)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on

;;org-indent-mode can crash Emacs 23.1, so org-mode refuses to enabled
(setq org-startup-indented t)

;;org-M-RET-may-split-line

;;;;Sparse Trees
;;org-show-hierarchy-above
;;org-show-following-heading
;;org-show-siblings
;;org-show-entry-below

(provide 'conf-org)
