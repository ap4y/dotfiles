(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(defvar custom-savefile-dir (expand-file-name "savefile" user-emacs-directory)
  "This folder stores all the automatically generated save/history-files.")

(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "scripts/use-package" user-emacs-directory))

(unless (file-exists-p custom-savefile-dir)
  (make-directory custom-savefile-dir))

(use-package init-loader
  :ensure t
  :config
  ;; (setq init-loader-byte-compile t)
  (setq init-loader-show-log-after-init 'error-only)
  (init-loader-load (expand-file-name "config" user-emacs-directory)))
