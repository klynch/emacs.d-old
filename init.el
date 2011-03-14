(eval-when-compile (require 'cl))
(defvar *emacs-load-start* (current-time))

(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless window-system
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Emacs Loading
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun expand-file-name-dotemacs (name)
  "Converts NAME to absolute, and canonicalize it. If NAME is not
absolute, then it expands to the file NAME inside `user-emacs-directory`."
  (expand-file-name name user-emacs-directory))

(defvar conf-enabled (expand-file-name-dotemacs "conf-enabled"))
(defvar conf-available (expand-file-name-dotemacs "conf-available"))

(defun add-subdirs-to-load-path (dir)
  "Adds the subdirectories to the list if possible."
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (let* ((my-lisp-dir dir)
             (default-directory my-lisp-dir))
        (add-to-list 'load-path my-lisp-dir)
        (normal-top-level-add-subdirs-to-load-path))))

(add-to-list 'load-path user-emacs-directory)

;; We don't want the custom file cluttering our beautiful .emacs file
(setq custom-file (expand-file-name-dotemacs "custom.el"))

;; Specify our own file to prevent emacs from using a system one
(setq generated-autoload-file (expand-file-name-dotemacs "loaddefs.el"))
(load generated-autoload-file 'noerror)

;; Let's not share our private stuff
(defvar private-file (expand-file-name-dotemacs "private.el"))
(load private-file 'noerror)

;; Where all of our custom extensions and what not go
(defvar elisp-dir (expand-file-name-dotemacs "elisp"))
(add-subdirs-to-load-path elisp-dir)

;;We should add our custom image path to the front.
;;This guarantees that we have a modifiable directory
(add-to-list 'image-load-path (expand-file-name-dotemacs "images/"))

(require 'color-theme)
(color-theme-tty-dark)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Load Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load up ELPA, the package manager
(add-to-list 'load-path (expand-file-name-dotemacs "elpa"))
(require 'package)
(package-initialize)
(require 'config-elpa)

(autoload 'magit-status "magit" nil t)

;; Use our own CEDET
;;(add-to-list 'load-path (expand-file-name-dotemacs "cedet/common"))
;;(require 'config-cedet)

;;TODO umask!

(defun load-conf-file (file)
  "Loads the config file located in conf-enabled directory"
  (require (intern (file-name-sans-extension file))
           (concat conf-enabled "/" file)))

(defun load-conf-enabled ()
 "Loads all of the configuration files linked in
~/.emacs.d/conf-enabled from ~/.emacs.d/conf-available"
 (make-directory conf-enabled t)
 (make-directory conf-available t)
 (mapcar 'load-conf-file
         (delete ".." (delete "." (directory-files conf-enabled)))))

(require 'config-blog)
(require 'config-registers)
(require 'config-message)
;;(require 'config-twit)
(require 'config-defuns)
(require 'config-shell)
(require 'config-bindings)
(require 'config-misc)
(require 'config-complete)
;;(require 'config-muse)
(require 'config-compile)
(require 'config-diff)
(require 'config-text)
(require 'config-c)
(require 'config-matlab)
(require 'config-latex)
(require 'config-lisp)
(require 'config-ruby)
(require 'config-python)
(require 'config-org)
(require 'config-auto-mode)

(todochiku-message "Emacs"
                   (format ".emacs loaded in %ds"
                           (destructuring-bind (hi lo ms) (current-time)
                             (- (+ hi lo)
                                (+ (first *emacs-load-start*)
                                   (second *emacs-load-start*)))))
                   (todochiku-icon 'check))
(put 'upcase-region 'disabled nil)
