;; Enable cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)

(defvar emacs-config-dir (file-name-directory load-file-name)
  "The root dir of the Emacs configuration.")

(defvar custom-savefile-dir (expand-file-name "savefile" emacs-config-dir)
  "This folder stores all the automatically generated save/history-files.")

(unless (file-exists-p custom-savefile-dir)
  (make-directory custom-savefile-dir))

;; Load configuration files
(require 'init-loader)
(custom-set-variables
 ;; '(init-loader-byte-compile 't)
 '(init-loader-show-log-after-init 'error-only))
(init-loader-load (expand-file-name "config" emacs-config-dir))
