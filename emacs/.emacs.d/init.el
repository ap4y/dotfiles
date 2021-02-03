;;; init.el --- description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Arthur Evstifeev
;;
;; Author: Arthur Evstifeev <http://github/ap4y>
;; Maintainer: Arthur Evstifeev <mail@ap4y.me>
;; Created: January 19, 2021
;; Modified: January 19, 2021
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/ap4y/init
;; Package-Requires: ((emacs 27.1) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  description
;;
;;; Code:
(add-to-list 'load-path (expand-file-name "scripts" user-emacs-directory))

;;; Better defaults
(require 'better-defaults)

;;; General tweaks
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))
(fset 'yes-or-no-p 'y-or-n-p)         ;; enable y/n answers
(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 8)            ;; but maintain correct appearance

;;; Modeline config
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; Code settings
(global-hl-line-mode +1)
(defun ap4y/prog-mode-defaults ()
  "Default settings for the 'prog-mode' based modes."
  (flycheck-mode)
  (flyspell-prog-mode)
  (evil-local-mode))
(add-hook 'prog-mode-hook 'ap4y/prog-mode-defaults)

;; Support for Emacs pinentry.
(setq epg-pinentry-mode 'loopback)

;;; Keybinds
(defun ap4y/toggle-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun ap4y/kill-whole-line (&optional arg)
  "A simple wrapper around command `kill-whole-line' that respects indentation.
Passes ARG to command `kill-whole-line' when provided."
  (interactive "p")
  (kill-whole-line arg)
  (back-to-indentation))

(global-set-key (kbd "C-c b") 'ap4y/toggle-buffer)
(global-set-key (kbd "C-c k") 'ap4y/kill-whole-line)

;;; Ivy
(use-package counsel
  :bind (("\C-s" . swiper)
         ("C-c C-r" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("M-y" . counsel-yank-pop)
         ("C-x C-f" . counsel-find-file)
         ("C-c f" . counsel-recentf)
         ("C-c i" . counsel-imenu)
         ("C-c g" . counsel-git)
         ("C-c s" . counsel-rg)
         ("C-c p f" . counsel-fzf)
         ("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil))

;;;; reformatter
(reformatter-define format-ruby
  :group 'formatter
  :program "prettier"
  :args '("--parser" "ruby" "--stdin"))
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
(reformatter-define format-go
  :group 'formatter
  :program "goimports")
(reformatter-define format-python
  :group 'formatter
  :program "yapf")
(reformatter-define format-shell
  :group 'formatter
  :program "shfmt")

;;;; flycheck
(use-package flycheck
  :commands flycheck-mode
  :bind (:map flycheck-mode-map
              ("M-n" . flycheck-next-error)
              ("M-p" . flycheck-previous-error))
  :config
  (setq flycheck-indication-mode nil)
  ;; disable checkers
  (setq-default flycheck-disabled-checkers '(go-megacheck go-errcheck go-unconvert go-gofmt go-vet)))

;;;; Evil
(use-package evil ;; only use evil-local-mode
  :commands (evil-local-mode))

;;;; magit
(use-package magit
  :bind (("C-c c" . magit-status))
  :config
  (setq git-commit-summary-max-length 80)
  (setq vc-handled-backends nil))

;;;; timemachine
(use-package git-timemachine
  :commands git-timemachine)

;;;; ruby
(use-package ruby-test-mode
  :commands (ruby-test-run ruby-test-run-at-point ruby-test-toggle-implementation-and-specification))
(use-package ruby-mode
  :mode "\\(?:\\.rb\\|ru\\|rake\\|jbuilder\\|gemspec\\|podspec\\|Gemfile\\)\\'"
  :bind (:map ruby-mode-map
              ("C-c m" . ruby-test-run)
              ("C-c ." . ruby-test-run-at-point)
              ("C-c /" . ruby-test-toggle-implementation-and-specification))
  :preface
  (defun ap4y/ruby-mode-defaults ()
    (format-ruby-on-save-mode)
    (subword-mode +1))
  :config
  (add-hook 'ruby-mode-hook 'ap4y/ruby-mode-defaults))

;;;; javascript
(use-package js2-mode
  :mode "\\.js\\'"
  :preface
  (defun ap4y/js-mode-defaults ()
    (setq js2-basic-offset 2)
    (format-js-on-save-mode)
    (subword-mode +1))
  :config
  (add-hook 'js2-mode-hook 'ap4y/js-mode-defaults))

;;;; golang
(use-package gotest
  :commands (go-test-current-project go-test-current-file go-test-current-test))
(use-package go-mode
  :mode "\\.go\\'"
  :bind (:map go-mode-map
              ("C-c a" . go-test-current-project)
              ("C-c m" . go-test-current-file)
              ("C-c ." . go-test-current-test)
              ("C-c s" . go-run)
              ("C-c /" . ff-find-other-file)
              ("C-h f" . godoc-at-point))
  :preface
  (defun ap4y/go-mode-defaults ()
    (setq-default tab-width 2)
    (format-go-on-save-mode)
    (subword-mode +1))
  :config
  (add-hook 'go-mode-hook 'ap4y/go-mode-defaults))

;;;; web-mode
(use-package web-mode
  :mode "\\.erb\\|.html?\\'"
  :preface
  (defun ap4y/web-mode-defaults ()
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-code-indent-offset 2))
  :config
  (add-hook 'web-mode-hook 'ap4y/web-mode-defaults))

;;;; yaml
(use-package yaml-mode
  :mode "\\.ya?ml\\'"
  :preface
  (defun ap4y/yaml-mode-defaults ()
    (subword-mode +1))
  :config
  (add-hook 'yaml-mode-hook 'ap4y/yaml-mode-defaults))

;;;; eshell
(use-package eshell
  :commands (eshell eshell-command)
  :bind (("C-x m" . eshell)))

;;;; Dired
(use-package dired
  :bind ("C-x C-j" . dired-jump)
  :config
  (setq dired-listing-switches "-lXGh --group-directories-first"))

;;;; mu4e
(use-package mu4e
  :commands mu4e
  :load-path "/usr/share/emacs/site-lisp/mu"
  :config
  (setq mu4e-sent-folder "/Sent")
  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-trash-folder "/Trash")
  (setq mu4e-archive-folder "/Archive")

  (setq mu4e-get-mail-command "mbsync ap4y")
  (setq mu4e-change-filenames-when-moving t)

  (require 'smtpmail)
  (setq message-send-mail-function 'smtpmail-send-it
        user-full-name "Arthur Evstifeev"
        user-mail-address "mail@ap4y.me"
        smtpmail-smtp-server "mail.ap4y.me"
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
                  :key   ?b)
          (:name  "emacs lists"
                  :query "v:/Emacs.*/ m:/Inbox"
                  :key   ?e))))

;;;; Elfeed
(use-package elfeed
  :commands elfeed
  :config
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

;;;; Accounting
(use-package ledger-mode
  :mode "\\.ledger\\'")

;;;; Password management
(use-package password-store
  :commands (password-store-copy password-store-generate)
  :bind (("C-c p" . password-store-copy))
  :config
  (setq password-store-password-length 30))

(provide 'init)
;;; init.el ends here
