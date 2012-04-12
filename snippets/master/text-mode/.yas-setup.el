(defun yas/begin-comment-region () (setq snippet-begin (point)) nil)

(defun yas/end-comment-region () (comment-region snippet-begin (point)))

(defun empty-or-nil (OBJECT)
  "Returns t if ``OBJECT'' is an empty string or nil"
  (or (not OBJECT) (string= OBJECT "")))

(defun yas/email (email)
  "Encloses the email address with < and > if address is
non-empty"
  (interactive)
  (if (or (not email) (string= email ""))
      ""
      (format " <%s> " email)))

(defun yas/name (name &optional email)
  "Formats the name and email address as 'Name <Email> ' if email
is non-empty. Otherwise it returns 'name '"
  (interactive)
  (if (or (not email) (string= email ""))
              (concat name " ")
              (format "%s <%s> " name email)))

;; (defvar yas/licenses "GPL"

;; (defun yas/choose-license ()
;;   "Chooses a license out of the list of licenses"
;;   (yas/choose-value
