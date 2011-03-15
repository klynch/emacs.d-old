(eval-when-compile (require 'cl))

(require 'conf-bindings)
(define-key k-minor-mode-map (kbd "\C-c e")  'weblogger-start-entry)

;; we want our drafts hidden away. Default is ~/Mail/drafts
(setq message-auto-save-directory (expand-file-name-dotemacs "drafts"))

(eval-after-load 'weblogger
  '(progn
     (todochiku-message "Weblogger" "Loaded weblogger and executing load-hook"
                        (todochiku-icon 'check))

     ;; Load the login credentials
     (require 'secrets "secrets.el.gpg")

     ;; We don't want a bunch of line breaks spread across our
     ;; posts. auto-fill-mode inserts line breaks, while truncate-lines=nil
     ;; allows the lines to wrap
     (add-hook 'weblogger-entry-mode-hook (lambda ()
                                            (auto-fill-mode -1)
                                            (set-default 'truncate-lines nil)))
     ))

(provide 'conf-blog)
