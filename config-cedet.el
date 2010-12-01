(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CEDET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load CEDET
(add-to-list 'load-path (concat dotemacs-dir "elisp/cedet/common"))
(require 'cedet)

;;(add-to-list 'load-path (concat dotemacs-dir "elisp/cedet/ecb"))
;;(load-file "~/.emacs.d/ecb/ecb.el")
;;(require 'ecb)

;;(require 'ecb-autoloads)

(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)



(setq speedbar-mode-hook '(lambda ()
                            (interactive)
                            (other-frame 0)))

;; (when window-system          ; start speedbar if we're using a window system
;;   (speedbar t))


(provide 'config-cedet)
