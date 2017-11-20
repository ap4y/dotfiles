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
(setq shell-file-name (executable-find "bash"))

;; for m-x shell
(setq explicit-shell-file-name (executable-find "bash"))

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

;; sensible undo
(global-undo-tree-mode)

;; diminish keeps the modeline tidy
(require 'diminish)

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

;; smooth scrolling
(smooth-scrolling-mode 1)
