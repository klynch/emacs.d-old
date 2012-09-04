;;; symbols-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (list-symbols symbols-undefined-symbols-only symbols-demangle-names
;;;;;;  symbols-values-radix symbols-values-type) "symbols-mode"
;;;;;;  "symbols-mode.el" (20549 20878))
;;; Generated autoloads from symbols-mode.el

(defvar symbols-values-type 16 "\
Symbol values are printed on 16 or 8 columns depending on the
the type of the targeted os, 64 bits or 32 bits os.")

(custom-autoload 'symbols-values-type "symbols-mode" nil)

(defvar symbols-values-radix "x" "\
Radix to use for printing the symbol values.")

(custom-autoload 'symbols-values-radix "symbols-mode" nil)

(defvar symbols-demangle-names t "\
Non-nil means decode low-level symbol names into user-level names.")

(custom-autoload 'symbols-demangle-names "symbols-mode" nil)

(defvar symbols-undefined-symbols-only nil "\
Non-nil means display only undefined symbols.")

(custom-autoload 'symbols-undefined-symbols-only "symbols-mode" nil)

(autoload 'list-symbols "symbols-mode" "\
Display the list of symbols in FILE.

The return is always nil.

\(fn FILE)" t nil)

;;;***

;;;### (autoloads nil nil ("symbols-mode-pkg.el") (20549 20878 773804))

;;;***

(provide 'symbols-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; symbols-mode-autoloads.el ends here
