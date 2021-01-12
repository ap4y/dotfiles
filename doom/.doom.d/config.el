;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Arthur Evstifeev"
      user-mail-address "mail@ap4y.me")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Tamzen" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defun ap4y/toggle-buffer ()
  "Switch to previously open buffer.
     Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

;; keybinds
(map! "C-c b" #'ap4y/toggle-buffer)
(map! "C-c g" #'counsel-git)
(map! "C-c s" #'counsel-rg)
(map! "C-c i" #'counsel-imenu)
(map! "C-s" #'swiper)
(map! "C-c p" #'password-store-copy)
(map! "C-c c" #'magit-status)
(map! "C-c d" #'dired-jump)

;; flycheck
(map! :map flycheck-mode-map
      "M-n" #'flycheck-next-error
      "M-p" #'flycheck-previous-error)

;; reformatter
(reformatter-define ruby-format
  :program "prettier"
  :args '("--parser" "ruby" "--stdin"))
(reformatter-define go-format
  :program "goimports")
(reformatter-define format-css
  :group 'formatter
  :program "prettier"
  :args '("--parser" "css" "--stdin"))
(reformatter-define format-js
  :group 'formatter
  :program "prettier"
  :args '("--parser" "babel" "--stdin"))
(reformatter-define format-html
  :group 'formatter
  :program "prettier"
  :args '("--parser" "html" "--stdin"))
(reformatter-define format-shell
  :group 'formatter
  :program "shfmt")

;; ruby
(add-hook! ruby-mode
  (subword-mode +1)
  (ruby-format-on-save-mode 1))
(map! :map ruby-mode-map
      "C-c m" #'ruby-test-run
      "C-c ." #'ruby-test-run-at-point
      "C-c /" #'ruby-test-toggle-implementation-and-specification)

;; golang
(add-hook! go-mode
  (subword-mode +1)
  (go-format-on-save-mode 1))
(map! :map go-mode-map
      "C-c a" #'go-test-current-project
      "C-c m" #'go-test-current-file
      "C-c ." #'go-test-current-test
      "C-c /" #'ff-find-other-file)

;; web
(add-hook! web-mode
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-script-padding 2)
  (setq web-mode-code-indent-offset 2))

;; password-store
(use-package! password-store
  :config
  (setq password-store-password-length 30))

;; mu4e
(use-package! mu4e
  :config
  (setq mu4e-sent-folder "/Sent")
  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-trash-folder "/Trash")

  (setq mu4e-get-mail-command "mbsync ap4y")
  (setq mu4e-change-filenames-when-moving t)

  (setq smtpmail-smtp-server "mail.ap4y.me"
        smtpmail-smtp-service 587
        smtpmail-stream-type  'starttls)

  (setq message-kill-buffer-on-exit t)
  ;; (add-hook 'message-send-hook 'mml-secure-message-sign-pgpmime)

  (setq mu4e-view-prefer-html t)
  (setq mu4e-html2text-command "w3m -T text/html")
  (add-to-list 'mu4e-view-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t)

  (setq mu4e-bookmarks
        '((:name  "Inbox"
           :query "not g:list m:/Inbox"
           :key   ?i)
          (:name  "openbsd lists"
           :query "v:/.*.openbsd.org/ m:/Inbox"
           :key   ?b)))
  )

;; elfeed
(use-package! elfeed
  :config
  (setq-default elfeed-search-filter "@1-week-ago +unread")
  (setq elfeed-feeds
        '(("https://github.com/ruby/ruby/commits/master.atom" ruby-devel)
          ("https://github.com/rails/rails/commits/master.atom" rails-devel)
          ("https://www.reddit.com/r/emacs.rss" reddit emacs)
          ("https://this-week-in-rust.org/rss.xml" reddit rust)
          ("https://www.reddit.com/r/selfhosted.rss" reddit selfhosted)
          ("https://www.reddit.com/r/kubernetes.rss" reddit k8s)
          ("http://rubyweekly.com/rss" ruby)
          ("http://www.dragonflydigest.com/feed" bsd)
          ("http://golangweekly.com/rss" go)
          ("http://javascriptweekly.com/rss" js)
          ("http://iosdevweekly.com/issues.rss" ios)
          ("https://newsletter.nixers.net/feed.xml" linux))))
