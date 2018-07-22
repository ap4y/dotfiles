;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 100000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 101
      scroll-preserve-screen-position t)

;; seems pointless to warn. There's always undo.
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
(put 'scroll-left 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;; enable startup screen
(setq inhibit-startup-screen t)

;; for m-x shell-command
(if (eq system-type "berkeley-unix")
    (setq shell-file-name (executable-find "ksh"))
  (setq shell-file-name (executable-find "bash")))


;; for m-x shell
(if (eq system-type "berkeley-unix")
    (setq explicit-shell-file-name (executable-find "ksh"))
  (setq shell-file-name (executable-find "bash")))


;; encoding settings
(set-language-environment      "English")
(prefer-coding-system          'utf-8-unix)
(setq                          buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system    'utf-8)
(set-keyboard-coding-system    'utf-8)
(set-clipboard-coding-system   'utf-8)

;; log settings
(setq message-log-max 10000)
(setq history-length 1000)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 8)            ;; but maintain correct appearance

;; Newline at end of file
(setq require-final-newline t)

;; delete selection with a keypress
(delete-selection-mode t)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

;; ediff - don't start another frame
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; clean up obsolete buffers automatically
(require 'midnight)

;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defadvice switch-to-buffer (before save-buffer-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-window (before other-window-now activate)
  (when buffer-file-name (save-buffer)))
(defadvice other-frame (before other-frame-now activate)
  (when buffer-file-name (save-buffer)))

;; saveplace remembers your location in a file when saving files
(require 'saveplace)
(setq save-place-file (expand-file-name "saveplace" custom-savefile-dir))
(setq-default save-place t) ;; activate it for all buffers

;; savehist keeps track of some history
(require 'savehist)
(setq savehist-file (expand-file-name "savehist" custom-savefile-dir)
      enable-recursive-minibuffers t ; Allow commands in minibuffers
      history-length 1000
      savehist-additional-variables '(mark-ring
                                      global-mark-ring
                                      search-ring
                                      regexp-search-ring
                                      extended-command-history)
      savehist-autosave-interval 60)
(savehist-mode +1)

;; Use different save directory for eshell
(require 'eshell)
(setq eshell-directory-name (expand-file-name "eshell" custom-savefile-dir))

;; Set some common auto-modes
(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-mode))

;; enable winner mode
(winner-mode 1)

;; use ssh with tramp
(setq tramp-default-method "ssh")

;; disable all dialogs
(setq use-dialog-box nil)

(use-package rainbow-mode
  :ensure t
  :commands rainbow-mode)

(use-package rainbow-delimiters
  :ensure t
  :commands rainbow-delimiters-mode)

(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))

(use-package ledger-mode
  :ensure t
  :mode "\\.ledger\\'")

(use-package password-store
  :ensure t
  :commands (password-store-copy password-store-generate)
  :bind (("C-x p" . password-store-copy))
  :config
  (setq password-store-password-length 10))

(use-package buffer-move
  :ensure t
  :bind (("s-J" . buf-move-left)
         ("s-K" . buf-move-down)
         ("s-L" . buf-move-up)
         ("s-:" . buf-move-right)))

(use-package fringe-helper
  :ensure t)

(use-package windmove
  :bind (("C-x k" . windmove-down)
         ("C-x l" . windmove-up)
         ("C-x ;" . windmove-right)
         ("C-x j" . windmove-left)))

(use-package winner
  :bind (("C-c l" . winner-undo)
         ("C-c ;" . winner-redo)))

(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))

(use-package ag
  :ensure t
  :commands ag)

;; Support for Emacs pinentry.
(setq epa-pinentry-mode 'loopback)
(when (require 'pinentry nil t)
  (pinentry-start))

;; Display time in mode line
(setq display-time-format "%a %d %b %H:%M")
(setq display-time-default-load-average nil)
(display-time-mode 1)
