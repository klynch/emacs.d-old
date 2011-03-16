(eval-when-compile (require 'cl))
(defvar *emacs-load-start* (current-time))

;; Remove all toolbars if they are bound
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(unless window-system
  (if (fboundp 'menu-bar-mode) (menu-bar-mode -1)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Loading Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun expand-file-name-dotemacs (name)
  "Converts NAME to absolute, and canonicalize it. If NAME is not
absolute, then it expands to the file NAME inside `user-emacs-directory'."
  (expand-file-name name user-emacs-directory))

(defun add-subdirs-to-load-path (dir)
  "Adds the subdirectories to the list if possible."
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (let* ((my-lisp-dir dir)
             (default-directory my-lisp-dir))
        (add-to-list 'load-path my-lisp-dir)
        (normal-top-level-add-subdirs-to-load-path))))

(defun update-autoloads ()
  "Iterates through all elisp files under the
`user-emacs-directory' to update any autoloads"
  (interactive)
  (dolist (dir load-path)
    (when (string-match (concat "^" (expand-file-name user-emacs-directory)) dir)
      (update-directory-autoloads dir)))
  (load generated-autoload-file 'noerror))

(defun load-conf-file (file)
  "Loads the config file located in conf-enabled directory"
  (require (intern (file-name-sans-extension file))
           (expand-file-name file conf-enabled)))

(defun load-conf-enabled ()
 "Loads all of the configuration files linked in
~/.emacs.d/conf-enabled from ~/.emacs.d/conf-available"
 (make-directory conf-enabled t)
 (make-directory conf-available t)
 (mapcar 'load-conf-file
         (delete ".." (delete "." (directory-files conf-enabled)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Loading Variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ~/.emacs.d/ should be added
(add-to-list 'load-path user-emacs-directory)

(defvar conf-available (expand-file-name-dotemacs "conf-available")
  "Contains all custom emacs configuration files available.")
(defvar conf-enabled (expand-file-name-dotemacs "conf-enabled")
  "Contains all emacs config files from `conf-enabled' that are
  to be loaded at startup.")

(add-to-list 'load-path conf-available)

;; We don't want the custom file cluttering our beautiful .emacs file
(setq custom-file (expand-file-name-dotemacs "custom.el"))

;; Specify our own file to prevent emacs from using a system one
(setq generated-autoload-file (expand-file-name-dotemacs "loaddefs.el"))
(load generated-autoload-file 'noerror)

;; Let's not share our private stuff
(defvar conf-private (expand-file-name-dotemacs "private.el")
  "Contains all private settings that should not be shared with others.")
(load conf-private 'noerror)

;; Where all of our custom extensions and what not go
(defvar elisp-dir (expand-file-name-dotemacs "elisp"))
(add-subdirs-to-load-path elisp-dir)

;; We should add our custom image path to the front. This guarantees that we
;; have a modifiable directory
(add-to-list 'image-load-path (expand-file-name-dotemacs "images/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Set Color Theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'color-theme)
(color-theme-tty-dark)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Load Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load up ELPA, the package manager
(require 'conf-elpa)

;; Use our own CEDET
;;(add-to-list 'load-path (expand-file-name-dotemacs "cedet/common"))
;;(require 'conf-cedet)

;;TODO umask!

(require 'conf-blog)
;;(require 'conf-registers)
(require 'conf-message)
;;(require 'conf-twit)
(require 'conf-defuns)
(require 'conf-shell)
(require 'conf-bindings)
(require 'conf-misc)
(require 'conf-complete)
;;(require 'conf-muse)
(require 'conf-compile)
(require 'conf-diff)
(require 'conf-text)
(require 'conf-c)
(require 'conf-matlab)
(require 'conf-latex)
(require 'conf-lisp)
(require 'conf-ruby)
(require 'conf-python)
(require 'conf-org)
(require 'conf-auto-mode)

(todochiku-message "Emacs"
                   (format ".emacs loaded in %ds"
                           (destructuring-bind (hi lo ms) (current-time)
                             (- (+ hi lo)
                                (+ (first *emacs-load-start*)
                                   (second *emacs-load-start*)))))
                   (todochiku-icon 'check))
(put 'upcase-region 'disabled nil)
