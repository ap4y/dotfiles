;;; early-init.el --- description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Arthur Evstifeev
;;
;; Author: Arthur Evstifeev <http://github/ap4y>
;; Maintainer: Arthur Evstifeev <mail@ap4y.me>
;; Created: January 19, 2021
;; Modified: January 19, 2021
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/ap4y/early-init
;; Package-Requires: ((emacs 27.1) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  description
;;
;;; Code:

;;; UI tweaks
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(setq inhibit-startup-screen t)       ;; scratch buffer on load

(add-to-list 'default-frame-alist '(internal-border-width . 15))
(add-to-list 'default-frame-alist '(font . "Iosevka Term-10"))
(set-face-attribute 'default nil :font "Iosevka Term-10")
(fringe-mode 0)

(add-to-list 'load-path (expand-file-name "themes" user-emacs-directory))
(require 'base16-nord-light-theme)
(load-theme 'base16-nord-light t)

(provide 'early-init)
;;; early-init.el ends here
