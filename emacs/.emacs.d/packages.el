;;; packages.el --- description -*- lexical-binding: t; -*-
;;
;;; Commentary:
;;
;;  description
;;
;;; Code:

(require 'package)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(package-refresh-contents)

(setq ap4y/package-list
      '(better-defaults
        counsel
        doom-themes
        elfeed
        evil
        flycheck
        go-mode
        gotest
        git-timemachine
        js2-mode
        ledger-mode
        magit
        password-store
        reformatter
        ruby-test-mode
        use-package
        web-mode
        yaml-mode))

(dolist (package ap4y/package-list)
  (unless (package-installed-p package)
    (message "Installing %s" package)
    (package-install package)))

;;; packages.el ends here
