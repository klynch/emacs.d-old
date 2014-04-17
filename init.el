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

(defun path (&rest subdirs)
  "Concatenates all of the arguments into a single path. If the
path is absolute, then it returns the absolute canonical path
representation. Otherwise, it is interpreted relative to
`user-emacs-directory'. If the path signifies an existing
directory, the returned string will end in a slash.

Examples:
  (path \"elisp\" \"org-mode\")
    => \"/home/uid/.emacs.d/elisp/org-mode/\"

  (path \"init.el\")
    => \"/home/uid/.emacs.d/init.el\"

  (path \"~\" \"foo\")
    => \"/home/uid/foo/\""
  (let ((p (reduce 'expand-file-name (reverse subdirs)
                   :from-end t
                   :initial-value user-emacs-directory)))
    (if (file-directory-p p) (file-name-as-directory p) p)))

(defun add-subdirs-to-load-path (dir)
  "Adds the subdirectories to the list if possible."
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (let* ((my-lisp-dir dir)
             (default-directory my-lisp-dir))
        (add-to-list 'load-path my-lisp-dir)
        (normal-top-level-add-subdirs-to-load-path))))

(defvar elisp-dir (path "elisp")
  "Where all of our custom extensions and what not go")
(add-subdirs-to-load-path elisp-dir)

(defun update-autoloads ()
  "Iterates through all elisp files under the
`user-emacs-directory' to update any autoloads"
  (interactive)
  (dolist (dir load-path)
    (when (string-match (concat "^" (path)) dir)
      (update-directory-autoloads dir)))
  (load generated-autoload-file 'noerror))

(defun do-if-require (feature func &optional filename)
  "Calls `func' when feature is loaded. If filename is provided,
  then feature is loaded from there. Otherwise, quietly indicate
  a failure to load."
  (if (require feature filename 'noerror)
      (if func (funcall func))
    (message (format "Failed to load: %s" feature))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Loading Variables
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ~/.emacs.d/ should be added
(add-to-list 'load-path (path))

(defvar conf-dir (path "conf")
  "Contains all custom emacs configuration files available.")

(add-to-list 'load-path conf-dir)

;; We don't want the custom file cluttering our beautiful .emacs file
(setq custom-file (path "custom.el"))

;; Specify our own file to prevent emacs from using a system one
(setq generated-autoload-file (path "loaddefs.el"))
(load generated-autoload-file 'noerror)

(defvar conf-private (path "private.el")
  "Contains private settings. Must not be shared with others.")
(load conf-private 'noerror)

;; Add our custom image path to the front to guarantee that we have a
;; modifiable directory
(add-to-list 'image-load-path (path "images"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Load Packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load up ELPA, the package manager
(if (fboundp 'package-initialize)
    (package-initialize)
  (require 'conf-elpa))

;; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))

(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Set Color Theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'color-theme)
(color-theme-tty-dark)



;; Use our own CEDET
;;(add-to-list 'load-path (path "cedet" "common"))
;;(require 'conf-cedet)

;;TODO umask!

(require 'conf-layout)
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
;;(require 'conf-org)
(require 'conf-auto-mode)
(require 'conf-scheme)
;; (require 'less-mode)
(require 'conf-web)


;; (todochiku-message "Emacs"
;;                    (format ".emacs loaded in %ds"
;;                            (destructuring-bind (hi lo ms) (current-time)
;;                              (- (+ hi lo)
;;                                 (+ (first *emacs-load-start*)
;;                                    (second *emacs-load-start*)))))
;;                    (todochiku-icon 'check))

(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
