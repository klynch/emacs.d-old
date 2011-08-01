(eval-when-compile (require 'cl))

(add-to-list 'load-path (path elisp-dir "org-mode" "lisp"))

(require 'org-install)
s
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; not needed when global-font-lock-mode is on
(add-hook 'org-mode-hook 'turn-on-font-lock)

;; org-indent-mode can crash Emacs 23.1, so org-mode refuses to enabled
(setq org-startup-indented t)

;;org-M-RET-may-split-line

;;;;Sparse Trees
;;org-show-hierarchy-above
;;org-show-following-heading
;;org-show-siblings
;;org-show-entry-below

(provide 'conf-org)
