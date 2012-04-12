;; (defun yas/sh-correct-optlist (optstr)
;;   "Replace contiguous colons in getopts list with a single colon"
;;   (let ((colon (string-to-char ":")))
;;     (string-to

;; (defun yas/sh-getopt-case-stmts (optstr)
;;   (let* ((colon (string-to-char ":"))
;;          ;; Remove a preceding colon from optstr to make our life easier.
;;          (silent (eq (string-to-char optstr) colon))
;;          (optslist (if silent (cdr (string-to-list optstr)) optstr))
;;          ;; Simplify optslist to a list of single characters representing
;;          ;; argument switches and single character lists representing arguments
;;          ;; with options
;;          ;; Example: ":h:elo:" ==> "h:elo:" ==> '((104) 101 108 (111))
;;          (charlist  (reduce '(lambda (l r) (if (eq (car r) colon)
;;                                                (if (eq l colon)
;;                                                    r ; drop contiguous colons
;;                                                    (cons (list l) (cdr r)))
;;                                                (cons l r)))
;;                             optslist
;;                             :from-end t :initial-value '())))
;;     charlist))

(defun yas/sh-getopt-case-stmts (optstr)
  (let* ((colon (string-to-char ":"))
         ;; Remove a preceding colon from optstr to make our life easier.
         (silent (eq (string-to-char optstr) colon))
         (optslist (if silent (cdr (string-to-list optstr)) optstr))
         ;; Simplify optslist to a list of single characters representing
         ;; argument switches and single character lists representing arguments
         ;; with options
         ;; Example: ":h:elo:" ==> "h:elo:" ==> '((104) 101 108 (111))
         (charlist  (reduce '(lambda (l r) (if (eq (car r) colon)
                                               (if (eq l colon)
                                                   r
                                                   (cons (list l) (cdr r)))
                                               (cons l r)))
                            optslist
                            :from-end t :initial-value '())))
    ;; Now we can map our character list
    (concat (mapconcat '(lambda (arg) (if (listp arg)
                                          (format "%c)  $optc=\"$OPTARG\" ;;" (car arg))
                                          (format "%c)  $optc=1 ;;" arg)))
                       charlist "\n")
            "\n"
            "?)  usage && exit 1 ;;")))

;; (yas/sh-getopt-case-stmts ":h:el::o::::::")
