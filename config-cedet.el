(require 'cl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CEDET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (concat dotemacs-dir "cedet/common"))
;;(require 'cedet)

(add-to-list 'load-path (concat dotemacs-dir "ecb"))
;;(load-file "~/.emacs.d/ecb/ecb.el")
;;(require 'ecb)

;;(require 'ecb-autoloads)


(setq speedbar-mode-hook '(lambda ()
                            (interactive)
                            (other-frame 0)))

;; (when window-system          ; start speedbar if we're using a window system
;;   (speedbar t))


(provide 'config-cedet)
