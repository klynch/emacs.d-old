(require 'cl)

(autoload 'twit-show-recent-tweets              "twit" nil t)
(autoload 'twit-show-at-tweets                  "twit" nil t)
(autoload 'twit-show-friends                    "twit" nil t)
(autoload 'twit-show-followers                  "twit" nil t)
(autoload 'twit-follow-recent-tweets            "twit" nil t)
(autoload 'twit-post                            "twit" nil t)
(autoload 'twit-post-region                     "twit" nil t)
(autoload 'twit-post-buffer                     "twit" nil t)
(autoload 'twit-direct                          "twit" nil t)
(autoload 'twit-add-favorite                    "twit" nil t)
(autoload 'twit-remove-favorite                 "twit" nil t)
(autoload 'twit-add-friend                      "twit" nil t)
(autoload 'twit-remove-friend                   "twit" nil t)
(autoload 'twit-show-direct-tweets-with-account "twit" nil t)
(autoload 'twit-show-at-tweets-with-account     "twit" nil t)
(eval-after-load "twit"
  '(if window-system (setq twit-show-user-images t)))

(global-set-key "\C-cTT"  'twit-follow-recent-tweets) ; (s)how (T)weets
(global-set-key "\C-cTst" 'twit-show-recent-tweets)   ; (s)how (t)weets
(global-set-key "\C-cTsa" 'twit-show-at-tweets)       ; (s)how (a)t
(global-set-key "\C-cTsf" 'twit-show-friends)         ; (s)how (f)riends
(global-set-key "\C-cTsl" 'twit-show-followers)       ; (s)how fo(l)lowers
(global-set-key "\C-cTpp" 'twit-post)		              ; (p)ost
(global-set-key "\C-cTpr" 'twit-post-region)	        ; (p)ost (r)egion
(global-set-key "\C-cTpb" 'twit-post-buffer)	        ; (p)ost (b)uffer
(global-set-key "\C-cTpr" 'twit-direct)		            ; (p)ost (d)irect
(global-set-key "\C-cTfa" 'twit-add-favorite)	        ; (f)avorite (a)dd
(global-set-key "\C-cTfr" 'twit-remove-favorite)      ; (f)avorite (r)emove

(provide 'config-twit)
