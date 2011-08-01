;;; conf-elpals.el --- Install a base set of packages automatically.
;;
;; Part of the Emacs Starter Kit

(eval-when-compile (require 'cl))

(defvar packages (list 'idle-highlight
                       'ruby-mode
                       'inf-ruby
                       'css-mode
                       'yaml-mode
                       'find-file-in-project
                       ;; 'magit
                       'gist
                       'muse
                       )
  "Libraries that should be installed by default.")

(when (require 'package (path "elpa" "package.el") 'noerror)
  (package-initialize))
(require 'package)


;;;###autoload
(defun conf-elpa-load ()
  "Configure ELPA and initialize all packages"
  (interactive)
  ;;(setq package-user-dir (path "elpa"))
  ;;(add-to-list 'load-path package-user-dir) ;; TODO is this necessary?
  (require 'package)
  (package-initialize))

;;(conf-elpa-load)



;; On your first run, this should pull in all the base packages.
;; (when (esk-online?)
;;   (unless package-archive-contents (package-refresh-contents))
;;   (config-elpa-install))
(defun elpa-install ()
  "Install all config packages that aren't installed."
  (interactive)
  (dolist (package config-packages)
    (unless (or (member package package-activated-list)
                (functionp package))
      (message "Installing %s" (symbol-name package))
      (package-install package))))

(defun esk-online? ()
  "See if we're online.

Windows does not have the network-interface-list function, so we
just have to assume it's online."
  ;; TODO how could this work on Windows?
  (if (and (functionp 'network-interface-list)
           (network-interface-list))
      (some (lambda (iface) (unless (equal "lo" (car iface))
                              (member 'up (first (last (network-interface-info
                                                        (car iface)))))))
            (network-interface-list))
    t))

;; Workaround for an ELPA bug that people are reporting but I've been
;; unable to reproduce:
(autoload 'paredit-mode "paredit" "" t)

;; Workaround for bug in the ELPA package for yaml-mode
(autoload 'yaml-mode "yaml-mode" "" t)

(provide 'conf-elpa)
