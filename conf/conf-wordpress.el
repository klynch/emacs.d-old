(defun parse-wp-config-db (wpconfig-path)
  "Read in and parse the DB settings from a WordPress config file; binds 'global' vars for use by sql-mode"
  (save-excursion ;; will restore current buffer and default dir afterwards
    (set-buffer (get-buffer-create (generate-new-buffer-name " wp-config.php")))
    (insert-file-contents wpconfig-path)
    ;; in regex: subexpr 1 is variable name, subexpr 3 is value: DB_{HOST,NAME,PASSWORD,USER}
    (while (search-forward-regexp "define\s*(\s*['\"]\\(DB_\\(HOST\\|NAME\\|PASSWORD\\|USER\\)\\)['\"]\s*,\s*['\"]\\([^'\"]*\\)['\"]\s*)" (point-max) 42   )
      (cond
       ((equal "DB_HOST" (match-string-no-properties 1))
        (setq sql-server (match-string-no-properties 3)))
       ((equal "DB_NAME" (match-string-no-properties 1))
        (setq sql-database (match-string-no-properties 3)))
       ((equal "DB_PASSWORD" (match-string-no-properties 1))
        (setq sql-password (match-string-no-properties 3)))
       ((equal "DB_USER" (match-string-no-properties 1))
        (setq sql-user (match-string-no-properties 3)))))
    (kill-buffer)))

(defun sql-mysql-wordpress ()
  "Find WordPress config file in current tree, log into WP database if found."
  (interactive)
  (let ((mypath (locate-dominating-file default-directory "wp-config.php")))
    (if mypath
        (progn
          (parse-wp-config-db (concat (file-name-as-directory mypath) "wp-config.php"))
          (pop-to-buffer (sql-connect-mysql))
          (setq sql-interactive-product 'mysql)
          (setq sql-buffer (current-buffer))
          (sql-interactive-mode)
          (let* ((match (string-match (nth 0 tramp-file-name-structure) mypath))
                 (myformat (if (eq nil match)
                               (format " WordPress: local; %s; dbhost %s "
                                       mypath
                                       sql-server
                                       )
                             (format " WordPress: Remote %s@%s %s; dbhost %s "
                                     (match-string (nth 2 tramp-file-name-structure) mypath)
                                     (match-string (nth 3 tramp-file-name-structure) mypath)
                                     (match-string (nth 4 tramp-file-name-structure) mypath)
                                     sql-server))))
            (setq header-line-format myformat))
          )
      (message "Did not find wp-config.php in current path"))
    ))
