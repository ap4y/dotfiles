;;; Setup package system
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

;; install required packages
(setq ap4y/package-list
      '(ag
        alert
        all-the-icons
        all-the-icons-ivy
        all-the-icons-dired
        avy
        buffer-move
        company
        counsel
        doom-modeline
        doom-themes
        dumb-jump
        eglot
        elfeed
        expand-region
        exwm
        flycheck
        flx
        fringe-helper
        git-gutter-fringe
        git-timemachine
        go-eldoc
        go-mode
        gotest
        inf-ruby
        js2-mode
        ledger-mode
        magit
        nord-theme
        outshine
        password-store
        prodigy
        projectile
        rainbow-delimiters
        rainbow-mode
        reformatter
        rjsx-mode
        ruby-test-mode
        scrollkeeper
        smartparens
        use-package
        web-mode
        undo-tree
        winum
        yaml-mode
        yari
        yasnippet
        zoom))

;; fetch the list of packages available
(unless (file-exists-p package-user-dir)
  (package-refresh-contents))

;; install the missing packages
(dolist (package ap4y/package-list)
  (unless (package-installed-p package)
    (message "Installing %s" package)
    (package-install package)))

;;; Emacs tweaks
;; custom savedir
(defvar custom-savefile-dir (expand-file-name "savefile" user-emacs-directory)
  "This folder stores all the automatically generated save/history-files.")

(unless (file-exists-p custom-savefile-dir)
  (make-directory custom-savefile-dir))

;; custom themes folder
(add-to-list 'custom-theme-load-path (expand-file-name "themes" user-emacs-directory))

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(setq gc-cons-threshold 100000000)

;; warn when opening files bigger than 100MB
(setq large-file-warning-threshold 100000000)

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

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

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

;; enable winner mode
(winner-mode 1)

;; disable all dialogs
(setq use-dialog-box nil)

;; Support for Emacs pinentry.
(setq epa-pinentry-mode 'loopback)
(when (require 'pinentry nil t)
  (pinentry-start))
(defun pinentry-emacs (desc prompt ok error)
  (let ((str (read-passwd (concat (replace-regexp-in-string "%22" "\"" (replace-regexp-in-string "%0A" "\n" desc)) prompt ": "))))
    str))

;; Display time in mode line
(setq display-time-format "%a %d %b %H:%M")
(setq display-time-default-load-average nil)
(display-time-mode 1)

;; org-mode tab behaviour
(setq org-src-tab-acts-natively t)

;; set eww as a default url browser
(setq browse-url-browser-function 'eww-browse-url)

;; colorise string literals
(use-package rainbow-mode
  :commands rainbow-mode)

;; better delimiters hightling
(use-package rainbow-delimiters
  :commands rainbow-delimiters-mode)

;; fringe glyphs
(use-package fringe-helper)

;; buffer management
(use-package buffer-move
  :bind (("s-J" . buf-move-left)
         ("s-K" . buf-move-down)
         ("s-L" . buf-move-up)
         ("s-:" . buf-move-right)))

(use-package windmove
  :bind (("C-x k" . windmove-down)
         ("C-x l" . windmove-up)
         ("C-x ;" . windmove-right)
         ("C-x j" . windmove-left)))

(use-package winner
  :bind (("C-c l" . winner-undo)
         ("C-c ;" . winner-redo)))

(use-package zoom
  :bind ("C-x +" . zoom)
  :config
  (custom-set-variables
   '(zoom-size '(0.618 . 0.618))))

(use-package winum
  :config
  (setq window-numbering-scope            'global
        winum-auto-assign-0-to-minibuffer t)
  (winum-mode)
  (winum-set-keymap-prefix (kbd "s-r")))

;; code navigation
(use-package ibuffer
  :bind ("C-x C-b" . ibuffer))

;; better version of grep
(use-package ag
  :commands ag)

;; unique buffer name
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)
  (setq uniquify-ignore-buffers-re "^\\*"))

;; better undo behaviour
(use-package undo-tree
  :config
  (global-undo-tree-mode))

;;; UI Settings
;;;; Reduce clutter
(tool-bar-mode 0)
(menu-bar-mode 0)
(set-scroll-bar-mode nil)
(tooltip-mode -1)
(blink-cursor-mode 0)

;;;; Typography
(set-face-attribute 'default nil :font "Iosevka-10")
(set-frame-font "Iosevka-10")

;;;; all-the-icons
(use-package all-the-icons
  :config
  (use-package all-the-icons-ivy
    :init
    (setq all-the-icons-ivy-file-commands
          '(counsel-find-file counsel-fzf counsel-ag))
    :config
    (all-the-icons-ivy-setup))

  (use-package all-the-icons-dired
    :preface
    (defun dired-mode-setup ()
      (font-lock-mode 0)
      (all-the-icons-dired-mode))
    :init
    (add-hook 'dired-mode-hook 'dired-mode-setup)))

;;;; Color theme
(use-package doom-themes
  :config
  (load-theme 'doom-nord t))

;;;; Highlight
(global-hl-line-mode +1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(setq show-paren-delay 0)
(show-paren-mode 1)

;;;; Fringe
(fringe-mode '(8 . 8))

;;;; Frame
(setq frame-title-format
      '("" invocation-name " " (:eval (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b"))))

;;;; Modeline
(use-package doom-modeline
  :init
  (setq doom-modeline-height 40)
  :hook (after-init . doom-modeline-init))

;;;; Better scrolling
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

;;;; Compilation buffer
(use-package compile
  :commands compile
  :preface
  (defun ap4y/colorize-compilation-buffer ()
    "Colorize a compilation mode buffer."
    (interactive)
    ;; we don't want to mess with child modes such as grep-mode, ack, ag, etc
    (when (eq major-mode 'compilation-mode)
      (let ((inhibit-read-only t))
        (ansi-color-apply-on-region (point-min) (point-max)))))
  :config
  (setq compilation-ask-about-save nil
        compilation-always-kill t
        compilation-scroll-output 'first-error)

  (require 'ansi-color)
  (add-hook 'compilation-filter-hook #'ap4y/colorize-compilation-buffer))


;;; Custom key bindings
;;;; Alignment
(global-set-key (kbd "C-x \\") 'align-regexp)

;; custom align-regexp rules
(defun  align-commas (beg end)
  (interactive "r")
  (align-regexp beg end ",\\(\\s-*\\)" 1 1 t))

(defun align-colons (beg end)
  (interactive "r")
  (align-regexp beg end ":\\(\\s-*\\)" 1 1 t))

(defun align-hash (beg end)
  (interactive "r")
  (align-regexp beg end "\\(\\s-*\\)\=\>\\(\\s-*\\)" 1 1 t))

;;;; Buffer management
(defun ap4y/toggle-buffer ()
  "Switch to previously open buffer.
     Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(global-set-key (kbd "C-c b") 'ap4y/toggle-buffer)

(defun ap4y/rename-buffer-and-file ()
  "Rename current buffer and if the buffer is visiting a file, rename it too."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (rename-buffer (read-from-minibuffer "New name: " (buffer-name)))
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(global-set-key (kbd "C-c r") 'ap4y/rename-buffer-and-file)

;;;; Navigation and kill ring
(defun ap4y/top-join-line ()
  "Join the current line with the line beneath it."
  (interactive)
  (delete-indentation 1))

(global-set-key (kbd "C-c j") 'ap4y/top-join-line)

(defun ap4y/kill-whole-line (&optional arg)
  "A simple wrapper around command `kill-whole-line' that respects indentation.
                    Passes ARG to command `kill-whole-line' when provided."
  (interactive "p")
  (kill-whole-line arg)
  (back-to-indentation))

(global-set-key (kbd "C-c k") 'ap4y/kill-whole-line)
(global-set-key (kbd "C-z") 'ap4y/kill-whole-line)

;; Adaptive beginning of the line
(defun ap4y/move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

               Move point to the first non-whitespace character on this line.
               If point is already there, move to the beginning of the line.
               Effectively toggle between the first non-whitespace character and
               the beginning of the line.

               If ARG is not nil or 1, move forward ARG - 1 lines first.  If
               point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line] 'ap4y/move-beginning-of-line)

;; auto indent yanked text
(global-set-key (kbd "C-M-y") (lambda ()
                                (interactive)
                                (yank)
                                (indent-region (region-beginning) (region-end))))

;; jump to lines/chars faster
(use-package avy
  :bind (("M-g l" . avy-goto-line)
         ("M-g c" . avy-goto-char-timer)))

;; jump to definition
(use-package dumb-jump
  :bind (("M-g j" . dumb-jump-go)
         ("M-g o" . dumb-jump-go-other-window)))

;; region manipulation
(use-package expand-region
  :bind (("C-=" . er/expand-region)
         ("C--" . er/contract-region)))

(use-package scrollkeeper
  :bind (([remap scroll-down-command] . scrollkeeper-contents-down)
         ([remap scroll-up-command] . scrollkeeper-contents-up)))

;;; EXWM
(use-package exwm
  :ensure t
  :commands exwm-enable
  :config
  ;; Fix problems with Ido
  (require 'exwm-config)
  (exwm-config-ido)

  ;; auto-hide minibuffer
  ;; (setq exwm-workspace-minibuffer-position 'bottom)

  ;; force tiling
  ;; (setq exwm-manage-force-tiling nil)
  ;; (setq exwm-workspace-show-all-buffers t)
  ;; (setq exwm-layout-show-all-buffers t)

  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (exwm-workspace-rename-buffer exwm-class-name)))
  (add-hook 'exwm-update-title-hook
            (lambda ()
              (exwm-workspace-rename-buffer exwm-title)))

  ;; toggle passthrough
  (defun toggle-exwm-input-line-mode-passthrough ()
    (interactive)
    (if exwm-input-line-mode-passthrough
        (progn
          (setq exwm-input-line-mode-passthrough nil)
          (message "App receives all the keys now (with some simulation)"))
      (progn
        (setq exwm-input-line-mode-passthrough t)
        (message "emacs receives all the keys now")))
    (force-mode-line-update))
  (setq exwm-input-line-mode-passthrough nil)

  ;; We always need a way to go back to line-mode from char-mode
  (exwm-input-set-key (kbd "s-R") #'exwm-reset)
  (exwm-input-set-key (kbd "s-q") #'toggle-exwm-input-line-mode-passthrough)
  (exwm-input-set-key (kbd "s-w") #'kill-this-buffer)
  (exwm-input-set-key (kbd "s-f") #'exwm-layout-toggle-fullscreen)
  (exwm-input-set-key (kbd "s-m") #'exwm-workspace-move-window)

  (exwm-input-set-key (kbd "s-j") 'windmove-left)
  (exwm-input-set-key (kbd "s-k") 'windmove-down)
  (exwm-input-set-key (kbd "s-l") 'windmove-up)
  (exwm-input-set-key (kbd "s-;") 'windmove-right)

  (exwm-input-set-key (kbd "s-J") 'buf-move-left)
  (exwm-input-set-key (kbd "s-K") 'buf-move-down)
  (exwm-input-set-key (kbd "s-L") 'buf-move-up)
  (exwm-input-set-key (kbd "s-:") 'buf-move-right)

  (exwm-input-set-key (kbd "M-s-j") 'shrink-window-horizontally)
  (exwm-input-set-key (kbd "M-s-k") 'shrink-window)
  (exwm-input-set-key (kbd "M-s-l") 'enlarge-window)
  (exwm-input-set-key (kbd "M-s-;") 'enlarge-window-horizontally)

  ;; Bind "s-1" to "s-5" to switch to the corresponding workspace.
  (setq exwm-workspace-number 4)
  (add-hook 'exwm-workspace-list-change-hook
            (lambda ()
              (xcb:+request exwm--connection
                  (make-instance 'xcb:ewmh:set-_NET_DESKTOP_NAMES
                                 :window exwm--root :data "term\0browser\0file\0etc"))
              (xcb:flush exwm--connection)))

  (dotimes (i 4)
    (exwm-input-set-key (kbd (format "S-<f%d>" (+ i 1)))
                        `(lambda ()
                           (interactive)
                           (exwm-workspace-move-window ,i)))
    (exwm-input-set-key (kbd (format "<f%d>" (+ i 1)))
                        `(lambda ()
                           (interactive)
                           (exwm-workspace-switch-create ,i))))

  (exwm-input-set-key (kbd "s-d")
                      (lambda (command)
                        (interactive (list (read-shell-command "~ » ")))
                        (start-process-shell-command command nil command)))

  (exwm-input-set-key (kbd "s-<return>")
                      (lambda () (interactive)
                        (start-process-shell-command "" nil "alacritty")))

  (exwm-input-set-key (kbd "<XF86AudioLowerVolume>")
                      (lambda () (interactive)
                        (start-process-shell-command "" nil "pactl set-sink-volume 0 -5%")))

  (exwm-input-set-key (kbd "<XF86AudioRaiseVolume>")
                      (lambda () (interactive)
                        (start-process-shell-command "" nil "pactl set-sink-volume 0 +5%")))

  ;; Set up emacs emulation bindings for line mode.
  (exwm-input-set-simulation-keys
   `(([?\C-b] . left)
     ([?\C-f] . right)
     ([?\C-p] . up)
     ([?\C-n] . down)
     ([?\M-<] . home)
     ([?\M->] . end)
     ([?\C-w] . ?\C-x)
     ([?\M-w] . ?\C-c)
     ([?\C-y] . ?\C-v)))

  (dolist (k '(XF86AudioLowerVolume
               XF86AudioRaiseVolume
               XF86AudioMute
               XF86AudioPlay
               XF86AudioStop
               XF86AudioPrev
               XF86AudioNext
               ?\s-r))
    (cl-pushnew k exwm-input-prefix-keys))

  ;; multi-monitor
  (require 'exwm-randr)
  (setq exwm-randr-workspace-output-plist '(3 "HDMI-A-0" 4 "HDMI-A-0" 0 "DisplayPort-1" 1 "DisplayPort-1" 2 "DisplayPort-1"))
  (add-hook 'exwm-randr-screen-change-hook
            (lambda ()
              (start-process-shell-command "xrandr" nil "xrandr --output DisplayPort-1 --auto --rotate right --output HDMI-A-0 --auto --left-of DisplayPort-1 --primary")
              ))
  (exwm-randr-enable))

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
         ("C-c C-s" . counsel-ag)
         ("C-c p f" . counsel-fzf)
         ("C-c v" . counsel-push-view)
         ("C-c V" . counsel-pop-view)
         ("C-x b" . ivy-switch-buffer))
  :config
  (use-package flx
    :ensure t)

  (ivy-mode 1)
  (setq ivy-use-virtual-buffers nil)
  (setq ivy-count-format "%d/%d ")
  (setq enable-recursive-minibuffers t)
  (setq ivy-re-builders-alist
        '((swiper . ivy--regex-plus)
          (t      . ivy--regex-fuzzy))))

;;; System
;;;; Eshell
(use-package eshell
  :commands (eshell eshell-command)
  :bind (("C-x m" . eshell))
  :preface
  (defun ap4y/truncate-eshell-buffers ()
    "Truncates all eshell buffers"
    (interactive)
    (save-current-buffer
      (dolist (buffer (buffer-list t))
        (set-buffer buffer)
        (when (eq major-mode 'eshell-mode)
          (eshell-truncate-buffer)))))
  :config
  (setq eshell-prompt-function (lambda nil
                                 (concat
                                  (car (last (split-string (eshell/pwd) "/")))
                                  " » ")))
  (setq eshell-prompt-regexp "^[^#$»\n]*[#$»] ")
  (setq eshell-scroll-to-bottom-on-input 'this)
  (setq eshell-glob-case-insensitive t)
  (setq eshell-error-if-no-glob t)
  (setq eshell-history-size (* 10 1024))
  (setq eshell-hist-ignoredups t)

  (push 'eshell-tramp eshell-modules-list)

  (setq ap4y/eshell-truncate-timer
        (run-with-idle-timer 5 t #'ap4y/truncate-eshell-buffers)))

;;;; Tramp
(use-package tramp
  :config
  ;; use ssh with tramp
  (setq tramp-default-method "ssh")

  (add-to-list 'tramp-methods
               '("doas"
                 (tramp-login-program        "doas")
                 (tramp-login-args           (("-u" "%u") ("-s")))
                 (tramp-remote-shell         "/bin/sh")
                 (tramp-remote-shell-args    ("-c"))
                 (tramp-connection-timeout 10))))

;;;; Dired
(use-package dired
  :bind ("C-x C-j" . dired-jump)
  :init
  (load "dired-x")
  :config
  (setq image-dired-external-viewer "feh")
  (setq dired-listing-switches "-lXGh --group-directories-first")

  ;;; recursive copy & delete
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always)

  (setq enable-remote-dir-locals t))

;;;; Prodigy
(use-package prodigy
  :commands prodigy
  :config
  (prodigy-define-service
    :name "Knowlabel app"
    :cwd "/home/ap4y/git/knowlabel_app"
    :path "/home/ap4y/git/knowlabel_app/bin"
    :command "rails"
    :args '("s")
    :port 3000)

  (prodigy-define-service
    :name "Postgres container"
    :command "docker"
    :args '("run" "--rm" "-p" "5432:5432" "postgres"))

  (prodigy-define-service
    :name "Redis container"
    :command "docker"
    :args '("run" "--rm" "-p" "6379:6379" "redis")))

;;;; mu4e
(use-package mu4e
  :commands mu4e
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :config
  (setq mu4e-sent-folder "/Sent")
  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-trash-folder "/Trash")

  (setq mu4e-get-mail-command "offlineimap")

  (require 'smtpmail)
  (setq message-send-mail-function 'smtpmail-send-it
        user-full-name "Arthur Evstifeev"
        user-mail-address "mail@ap4y.me"
        smtpmail-smtp-server "cloud.ap4y.me"
        smtpmail-smtp-service 587
        smtpmail-stream-type  'starttls)

  (setq message-kill-buffer-on-exit t)
  ;; (add-hook 'message-send-hook 'mml-secure-message-sign-pgpmime)

  (setq mu4e-view-prefer-html t)
  (setq mu4e-html2text-command "w3m -T text/html")
  (add-to-list 'mu4e-view-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t))

;;;; ERC
;;;;; Core settings
(use-package erc
  :commands start-irc
  :preface
  (defun ap4y/filter-server-buffers ()
    (delq nil
          (mapcar
           (lambda (x) (and (erc-server-buffer-p x) x))
           (buffer-list))))

  (defun start-irc ()
    "Connect to IRC?"
    (interactive)
    (when (y-or-n-p "Do you want to start IRC? ")
      ;; (erc-tls :server "irc.freenode.net" :port 6697 :nick "ap4y")
      (erc :server "nas" :port 6667 :nick "ap4y")))

  (defun stop-irc ()
    "Disconnects from all irc servers"
    (interactive)
    (dolist (buffer (filter-server-buffers))
      (message "Server buffer: %s" (buffer-name buffer))
      (with-current-buffer buffer
        (erc-quit-server "Asta la vista"))))
  :config
  (require 'erc-log)
  (require 'erc-notify)
  (require 'erc-spelling)
  (require 'erc-autoaway)
  (require 'erc-match)

  ;; notification settings
  (setq erc-pals '("j0li"))
  (defun erc-global-notify (match-type nick message)
    "Notify when a message is recieved."
    (alert message :title nick))
  (add-hook 'erc-text-matched-hook 'erc-global-notify)

  ;; erc buffer behavior
  (setq erc-join-buffer 'bury)

  ;; Interpret mIRC-style color commands in IRC chats
  (setq erc-interpret-mirc-color t)

  ;; The following are commented out by default, but users of other
  ;; non-Emacs IRC clients might find them useful.
  ;; Kill buffers for channels after /part
  (setq erc-kill-buffer-on-part t)
  ;; Kill buffers for private queries after quitting the server
  (setq erc-kill-queries-on-quit t)
  ;; Kill buffers for server messages after quitting the server
  (setq erc-kill-server-buffer-on-quit t)

  ;; open query buffers in the current window
  (setq erc-query-display 'buffer)

  ;; exclude boring stuff from tracking
  (erc-track-mode t)
  (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                  "324" "329" "332" "333" "353" "477"))

  ;; logging
  (setq erc-log-channels-directory "~/.erc/logs/")

  (if (not (file-exists-p erc-log-channels-directory))
      (mkdir erc-log-channels-directory t))

  (setq erc-save-buffer-on-part t)

  ;; truncate long irc buffers
  (erc-truncate-mode +1)

  ;; enable spell checking
  (erc-spelling-mode 1)

  ;; autoaway setup
  (setq erc-auto-discard-away t)
  (setq erc-autoaway-idle-seconds 600)
  (setq erc-autoaway-idle-method 'emacs)

  ;; utf-8 always and forever
  (setq erc-server-coding-system '(utf-8 . utf-8))

  (setq erc-autojoin-channels-alist
        '(("freenode.net" "#ruby-lang" "#openbsd" "#voidlinux" "#go-nuts")
          ("ap4y.me" "#thelounge")))
  (setq erc-hide-list '("JOIN" "PART" "QUIT" "MODE"))

  ;; Dynamically fill buffers
  (add-hook 'window-configuration-change-hook
            '(lambda ()
               (setq erc-fill-column (- (window-width) 2))))

  ;; Make erc tracking come after everything else
  (setq erc-track-position-in-mode-line 'after-modes))

;;;;; SASL
(use-package erc-sasl
  :load-path "scripts"
  :commands erc-login
  :preface
  (defun erc-login ()
    "Perform user authentication at the IRC server."
    (erc-log (format "login: nick: %s, user: %s %s %s :%s"
                     (erc-current-nick)
                     (user-login-name)
                     (or erc-system-name (system-name))
                     erc-session-server
                     erc-session-user-full-name))
    (if erc-session-password
        (erc-server-send (format "PASS %s" erc-session-password))
      (message "Logging in without password"))
    (when (and (featurep 'erc-sasl) (erc-sasl-use-sasl-p))
      (erc-server-send "CAP REQ :sasl"))
    (erc-server-send (format "NICK %s" (erc-current-nick)))
    (erc-server-send
     (format "USER %s %s %s :%s"
             ;; hacked - S.B.
             (if erc-anonymous-login erc-email-userid (user-login-name))
             "0" "*"
             erc-session-user-full-name))
    (erc-update-mode-line))
  :config
  (add-to-list 'erc-sasl-server-regexp-list "irc\\.freenode\\.net"))

;;;;; Notifications
(use-package alert
  :commands alert
  :config
  (setq alert-default-style 'libnotify)
  (setq alert-default-icon ""))

;;;; Elfeed
(use-package elfeed
  :commands elfeed
  :config
  (setq elfeed-feeds
        '(("http://rubyweekly.com/rss" dev)
          ("http://www.dragonflydigest.com/feed" bsd)
          ("http://golangweekly.com/rss" dev)
          ("http://javascriptweekly.com/rss" dev)
          ("http://iosdevweekly.com/issues.rss" dev)
          ("https://newsletter.nixers.net/feed.xml" linux))))

;;; Text
;;;; flyspell
(add-hook 'text-mode-hook 'flyspell-mode)
(setq ispell-program-name "aspell"
      ispell-extra-args '("--sug-mode=ultra"))

;;;; outline
(use-package outshine
  :hook (outline-minor-mode . outshine-hook-function))

;;; Programming
;;;; company
(use-package company
  :commands company-mode
  :config
  (global-set-key (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-idle-delay nil)
  (setq company-tooltip-limit 10)
  (setq company-minimum-prefix-length 2)
  (setq company-tooltip-flip-when-above nil))

;;;; reformatter
(use-package reformatter
  :config
  (reformatter-define format-ruby
    :group 'formatter
    :program "rufo"
    :args '("--simple-exit"))
  (reformatter-define format-ruby-prettier
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
    :args '("--parser" "html" "--stdin")))

;;;; flycheck
(use-package flycheck
  :commands flycheck-mode
  :bind (:map flycheck-mode-map
              ("M-n" . flycheck-next-error)
              ("M-p" . flycheck-previous-error))
  :config
  ;; disable checkers
  (setq-default flycheck-disabled-checkers '(go-megacheck go-errcheck go-unconvert go-gofmt go-vet))

  ;; because git-gutter is in the left fringe
  (setq flycheck-indication-mode 'right-fringe)
  ;; A non-descript, left-pointing arrow
  (fringe-helper-define 'flycheck-fringe-bitmap-double-arrow 'center
    "...X...."
    "..XX...."
    ".XXX...."
    "XXXX...."
    ".XXX...."
    "..XX...."
    "...X...."))

;;;; git
;;;;; magit
(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-x G" . magit-status-with-prefix))
  :config
  (setq magit-push-always-verify nil)
  (setq git-commit-summary-max-length 80)
  (setq vc-handled-backends nil))

;;;;; timemachine
(use-package git-timemachine
  :commands git-timemachine)

;;;;; gutter
(use-package git-gutter-fringe
  :config
  (setq-default fringes-outside-margins t)
  ;; thin fringe bitmaps
  (fringe-helper-define 'git-gutter-fr:added '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
    "XXX.....")
  (fringe-helper-define 'git-gutter-fr:deleted 'bottom
    "X......."
    "XX......"
    "XXX....."
    "XXXX...."))

;;;; smartparens
(use-package smartparens
  :commands smartparens-mode
  :config
  (require 'smartparens-config))

;;;; whitespace
(use-package whitespace
  :commands (whitespace-buffer
             whitespace-cleanup
             whitespace-mode
             whitespace-mode)
  :config
  (setq whitespace-line-column 120)
  (setq whitespace-style '(face tabs empty trailing lines-tail)))

;;;; projectile
(use-package projectile
  :commands projectile-mode
  :bind (("C-c C-p p" . projectile-switch-project))
  :config
  (setq projectile-cache-file (expand-file-name  "projectile.cache" custom-savefile-dir))
  (setq projectile-completion-system 'ivy)
  (projectile-mode +1)
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map))

;;;; eglot
(use-package eglot
  :commands (eglot-ensure eglot)
  :bind (:map eglot-mode-map
              ("M-g h" . eglot-help-at-point)))
;;;; prog-mode
(defun ap4y/prog-mode-defaults ()
  (yas-minor-mode)
  (company-mode)
  (flycheck-mode)
  (flyspell-prog-mode)
  (smartparens-mode +1)
  (whitespace-mode)
  (git-gutter-mode)
  (setq comment-auto-fill-only-comments t)
  (display-line-numbers-mode)
  (add-hook 'before-save-hook 'whitespace-cleanup nil t))
(add-hook 'prog-mode-hook 'ap4y/prog-mode-defaults)

;;;; elisp
(use-package emacs-lisp-mode
  :mode "\\.el\\|Cask\\'"
  :preface
  (defun ap4y/elisp-mode-defaults ()
    (smartparens-strict-mode +1)
    (rainbow-delimiters-mode +1)
    (eldoc-mode)
    (rainbow-mode +1)
    (outline-minor-mode)
    (setq mode-name "EL"))
  :config
  (add-hook 'emacs-lisp-mode-hook 'ap4y/elisp-mode-defaults))

;;;; ruby
(use-package ruby-mode
  :mode "\\(?:\\.rb\\|ru\\|rake\\|jbuilder\\|gemspec\\|podspec\\|Gemfile\\)\\'"
  :bind (:map ruby-mode-map
              ("C-c m" . ruby-test-run)
              ("C-c ." . ruby-test-run-at-point)
              ("C-c /" . ruby-test-toggle-implementation-and-specification))
  :preface
  (defun ap4y/ruby-mode-defaults ()
    (subword-mode +1)

    (add-hook 'before-save-hook 'format-ruby-prettier nil t))
  :init
  (use-package ruby-test-mode)
  :config
  (add-hook 'ruby-mode-hook 'ap4y/ruby-mode-defaults))

;;;;; inf-ruby
(use-package inf-ruby
  :commands (inf-ruby inf-ruby-console-auto))

;;;;; yari
(use-package yari
  :commands yari)

;;;; golang
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
    ;; Prefer goimports to gofmt if installed
    (let ((goimports (executable-find "goimports")))
      (when goimports
        (setq gofmt-command goimports)))

    ;; format on save
    (add-hook 'before-save-hook 'gofmt-before-save nil t)

    ;; stop whitespace being highlighted
    (whitespace-toggle-options '(tabs))
    (setq whitespace-line-column 120)
    (setq-default tab-width 2)

    ;; el-doc for Go
    ;; (go-eldoc-setup)

    ;; CamelCase aware editing operations
    (subword-mode +1))
  :config
  (use-package gotest)
  (add-hook 'go-mode-hook 'ap4y/go-mode-defaults))

;;;;; eldoc
(use-package go-eldoc
  :commands godoc-at-point)

;;;; javascript
(use-package js2-mode
  :mode "\\.js\\'"
  :preface
  (defun ap4y/js-mode-defaults ()
    ;; electric-layout-mode doesn't play nice with smartparens
    (setq-local electric-layout-rules '((?\; . after)))
    (setq mode-name "JS2")
    (js2-imenu-extras-mode +1)
    (subword-mode)

    (add-hook 'before-save-hook 'format-js nil t))
  :config
  (add-hook 'js2-mode-hook 'ap4y/js-mode-defaults)
  (setq js2-basic-offset 2))

;;;; web-mode
(use-package web-mode
  :mode "\\.erb\\|.html?\\'"
  :preface
  (defun ap4y/web-mode-defaults ()
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-script-padding 2)
    (setq web-mode-code-indent-offset 2))
  :config
  (add-hook 'web-mode-hook 'ap4y/web-mode-defaults)
  (setq web-mode-enable-auto-pairing nil))

;;;; css
(use-package scss-mode
  :ensure t
  :mode "\\.css\\|.scss\\|.sass\\'"
  :preface
  (defun ap4y/css-mode-defaults ()
    (rainbow-mode +1)
    (run-hooks 'ap4y/prog-mode-defaults)
    (add-hook 'before-save-hook 'format-css nil t))
  :config
  (add-hook 'css-mode-hook 'ap4y/css-mode-defaults)
  (setq css-indent-offset 2)
  (setq scss-compile-at-save nil))

;;;; yaml
(use-package yaml-mode
  :mode "\\.ya?ml\\'"
  :config
  (add-hook 'yaml-mode-hook 'whitespace-mode)
  (add-hook 'yaml-mode-hook 'subword-mode)
  (add-hook 'yaml-mode-hook
            (lambda () (add-hook 'before-save-hook 'whitespace-cleanup nil t))))

;;;; Makefile
(use-package makefile-mode
  :mode "Makefile\\'"
  :preface
  (defun ap4y/makefile-mode-defaults ()
    (whitespace-toggle-options '(tabs))
    (setq indent-tabs-mode t))
  :config
  (add-hook 'makefile-mode-hook 'ap4y/makefile-mode-defaults))

;;;; devdocs
(use-package devdocs-lookup
  :load-path "scripts"
  :bind (("C-c h g" . devdocs-lookup-go)
         ("C-c h j" . devdocs-lookup-javascript)
         ("C-c h r i" . devdocs-lookup-ruby)
         ("C-c h r a" . devdocs-lookup-rails)
         ("C-c h r e" . devdocs-lookup-react)
         ("C-c h r n" . devdocs-lookup-react_native))
  :config
  (setq devdocs-subjects '(("Go" "go") ("JavaScript" "javascript")
                           ("Ruby on Rails" "rails") ("React" "react")
                           ("React Native" "react_native")
                           ("Ruby" "ruby")))
  (devdocs-setup))

;;; Misc
;;;; Accounting
(use-package ledger-mode
  :mode "\\.ledger\\'")

;;;; Password management
(use-package password-store
  :commands (password-store-copy password-store-generate)
  :bind (("C-x p" . password-store-copy))
  :config
  (setq password-store-password-length 10))
