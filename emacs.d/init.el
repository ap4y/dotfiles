;; Enable cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)

;; Load configuration files
(require 'init-loader)
(custom-set-variables
 ;; '(init-loader-byte-compile 't)
 '(init-loader-show-log-after-init 'error-only))
(init-loader-load (expand-file-name "~/.emacs.d/config"))
