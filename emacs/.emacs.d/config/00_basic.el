;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 50000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

;; nice scrolling
(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

;; enable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)

;; disable startup screen
(setq inhibit-startup-screen t)

;; for m-x shell-command
(setq shell-file-name "/bin/bash")

;; for m-x shell
(setq explicit-shell-file-name "/bin/bash")

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

;; disable annoying blink-matching-paren
(setq blink-matching-paren nil)

;; upcase and downcase
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 8)            ;; but maintain correct appearance

;; Newline at end of file
(setq require-final-newline t)

;; delete the selection with a keypress
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

;; diminish keeps the modeline tidy
(require 'diminish)

;; Emacs extension to increase selected region by semantic units.
(require 'expand-region)

;; ediff - don't start another frame
(require 'ediff)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; clean up obsolete buffers automatically
(require 'midnight)

;; smarter kill-ring navigation
(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defmacro advise-commands (advice-name commands class &rest body)
  "Apply advice named ADVICE-NAME to multiple COMMANDS.

The body of the advice is in BODY."
  `(progn
     ,@(mapcar (lambda (command)
                 `(defadvice ,command (,class ,(intern (concat (symbol-name command) "-" advice-name)) activate)
                    ,@body))
               commands)))

;; advise all window switching functions
(advise-commands "auto-save"
                 (switch-to-buffer other-window windmove-up windmove-down windmove-left windmove-right)
                 before
                 (auto-save-command))

;; Make some commands work on empty region
(defmacro with-region-or-buffer (func)
  "When called with no active region, call FUNC on current buffer."
  `(defadvice ,func (before with-region-or-buffer activate compile)
     (interactive
      (if mark-active
          (list (region-beginning) (region-end))
        (list (point-min) (point-max))))))

(with-region-or-buffer indent-region)
(with-region-or-buffer untabify)

;; sensible undo
(global-undo-tree-mode)
(diminish 'undo-tree-mode)

;; saveplace remembers your location in a file when saving files
(require 'saveplace)
(setq save-place-file (expand-file-name "saveplace" custom-savefile-dir))
(setq-default save-place t) ;; activate it for all buffers

;; savehist keeps track of some history
(require 'savehist)
(setq savehist-additional-variables
      '(search-ring regexp-search-ring) ;; search entries
      savehist-autosave-interval 60     ;; save every minute
      savehist-file (expand-file-name "savehist" custom-savefile-dir))
(savehist-mode +1)

;; Use different save directory for eshell
(require 'eshell)
(setq eshell-directory-name (expand-file-name "eshell" custom-savefile-dir))

;; Set some common auto-modes
(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-mode))

;; enable winner mode
(winner-mode 1)
