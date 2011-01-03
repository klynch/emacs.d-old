;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CEDET
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; JDEE
;; http://www.emacswiki.org/emacs/JavaDevelopmentEnvironment
;; https://github.com/espenhw/malabar-mode

;; http://stackoverflow.com/questions/3075993/emacs-using-and-initializing-cedet
;; http://alexott.net/en/writings/emacs-devenv/EmacsCedet.html
;; https://github.com/alexott/emacs-configs/blob/master/rc/emacs-rc-cedet.el
;; http://cxwangyi.wordpress.com/2010/08/21/using-cedet-with-emacs/

(require 'cedet)
(global-ede-mode 1)

(require 'semantic-decorate-include)
(require 'semantic-gcc)
(require 'semantic-ia)
(require 'semanticdb)

(defun my-cedet-hook ()
  (semantic-load-enable-excessive-code-helpers)
  ;;(setq senator-minor-mode-name "SN")
  ;;(setq semantic-imenu-auto-rebuild-directory-indexes nil)
  ;;(srecode-minor-mode 1)
  ;;(semantic-mru-bookmark-mode 1)
  ;;(semanticdb-minor-mode 1)
  ;;(semantic-tag-folding-mode 1)

  (local-set-key (kbd "C-:") 'semantic-ia-complete-symbol-menu) ; set shortcut for auto completion.
  (local-set-key (kbd "C-.") 'ac-complete-semantic)

  ;; (local-set-key [(control return)] 'semantic-ia-complete-symbol)
  ;; (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  ;; (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
  ;; (local-set-key "\C-c=" 'semantic-decoration-include-visit)
  ;; (local-set-key "\C-cj" 'semantic-ia-fast-jump)
  ;; (local-set-key "\C-cq" 'semantic-ia-show-doc)
  ;; (local-set-key "\C-cs" 'semantic-ia-show-summary)
  ;; (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
  ;; (local-set-key "\C-c+" 'semantic-tag-folding-show-block)
  ;; (local-set-key "\C-c-" 'semantic-tag-folding-fold-block)
  ;; (local-set-key "\C-c\C-c+" 'semantic-tag-folding-show-all)
  ;; (local-set-key "\C-c\C-c-" 'semantic-tag-folding-fold-all)
  )
(add-hook 'c++-mode-hook 'my-cedet-hook)

;; (require 'eassist)
;; ;(concat essist-header-switches ("hh" "cc"))
;; (defun alexott/c-mode-cedet-hook ()
;;   (local-set-key "\C-ct" 'eassist-switch-h-cpp)
;;   (local-set-key "\C-xt" 'eassist-switch-h-cpp)
;;   (local-set-key "\C-ce" 'eassist-list-methods)
;;   (local-set-key "\C-c\C-r" 'semantic-symref)
;;   )
;; (add-hook 'c-mode-common-hook 'alexott/c-mode-cedet-hook)

;; gnu global support
;; (require 'semanticdb-global)
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)

;;(custom-set-variables
;; '(semantic-idle-scheduler-idle-time 3)
;; '(semantic-self-insert-show-completion-function (lambda nil (semantic-ia-complete-symbol-menu (point))))
;; '(global-semantic-tag-folding-mode t nil (semantic-util-modes)))
;;(global-semantic-folding-mode 1)
;;(global-semantic-idle-tag-highlight-mode 1)

;; ;; Enable the Project management system
;; (setq semantic-default-submodes '(global-semanticdb-minor-mode
;;                                   global-semantic-idle-scheduler-mode
;;                                   global-semantic-idle-summary-mode
;;                                   global-semantic-idle-completions-mode
;;                                   global-semantic-decoration-mode
;;                                   global-semantic-highlight-func-mode
;;                                   global-semantic-stickyfunc-mode
;;                                   global-semantic-mru-bookmark-mode))
;; ;;(global-semantic-idle-completions-mode 1)

;; (setq ede-simple-save-directory "~/.emacs.d/ede")

;; (setq semantic-load-turn-everything-on t)
;; (semantic-mode 1)

;; (require 'semantic/wisent)
;; (require 'semantic/wisent/java-tags)
;; (autoload 'wisent-java-default-setup "wisent" "Hook run to setup Semantic in 'java-mode'." nil nil)
;; (setq jde-auto-parse-enable nil)
;; (setq jde-enable-senator nil)
;; (load "jde-autoload")

;; Enable template insertion menu
;;(global-srecode-minor-mode 1)

;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)

(setq speedbar-mode-hook '(lambda ()
                            (interactive)
                            (other-frame 0)))

;; (add-to-list 'load-path (concat dotemacs-dir "elisp/jdee/lisp"))
;; (autoload 'jde-mode "jde" "JDE mode." t)
;; (add-to-list 'auto-mode-alist '("\\.java$"      . jde-mode))

;; (when window-system
;;   (speedbar t))

(provide 'config-cedet)
