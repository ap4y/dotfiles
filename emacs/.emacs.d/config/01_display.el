;; hide toolbar
(tool-bar-mode 0)

;; hide menubar
(menu-bar-mode 0)

;; hide scroll bar
(set-scroll-bar-mode nil)

;; font
(set-face-attribute 'default nil :font "Iosevka-10")
(set-frame-font "Iosevka-10")

;; theme
(use-package eziam-theme
  :ensure t
  :defer t
  :init
  (use-package eziam-ap4y-theme
    :load-path "themes"
    :config
    (load-theme 'eziam-ap4y t)))

;; highlight the current line
(global-hl-line-mode +1)

;; (use-package volatile-highlights
;;   :ensure t
;;   :config
;;   (volatile-highlights-mode t))

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; stop blink cursor
(blink-cursor-mode 0)

;; make the fringe (gutter) smaller
;; the argument is a width in pixels (the default is 8)
(fringe-mode '(15 . 0))

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " " (:eval (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b"))))

;; modeline
;; (use-package spaceline
;;   :ensure t
;;   :config
;;   (require 'spaceline-config)
;;   (spaceline-emacs-theme)
;;   (setq-default powerline-default-separator 'nil)
;;   (spaceline-toggle-minor-modes-off)
;;   (spaceline-compile))
(use-package powerline
  :ensure t
  :init
  (defun shell-string (cmd)
    (string-trim
     (shell-command-to-string cmd)))
  (defun powerline-ap4y-theme ()
    "Custom setup the mode-line."
    (interactive)
    (setq-default mode-line-format
                  '("%e"
                    (:eval
                     (let* ((active (powerline-selected-window-active))
                            (mode-line-buffer-id (if active 'mode-line-buffer-id 'mode-line-buffer-id-inactive))
                            (mode-line (if active 'mode-line 'mode-line-inactive))

                            (face0 (if active 'powerline-active0 'powerline-inactive0))
                            (face1 (if active 'powerline-active1 'powerline-inactive1))
                            (face2 (if active 'powerline-active2 'powerline-inactive2))

                            (lhs (list
                                  (when active
                                    (concat
                                     (powerline-raw "  " (if (eq exwm-workspace-current-index 0) face1 face2))
                                     (powerline-raw "  " (if (eq exwm-workspace-current-index 1) face1 face2))
                                     (powerline-raw "  " (if (eq exwm-workspace-current-index 2) face1 face2))
                                     (powerline-raw "  " (if (eq exwm-workspace-current-index 3) face1 face2))))

                                  (powerline-raw " " face0)
                                  (powerline-buffer-id `(mode-line-buffer-id ,face0) 'l)

                                  (when (and (not (eq major-mode 'exwm-mode)) active)
                                    (concat
                                     (when powerline-display-buffer-size
                                       (powerline-buffer-size face0 'l))
                                     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format face0 'l))))

                                  (unless (eq major-mode 'exwm-mode)
                                    (powerline-major-mode face0 'l))

                                  (powerline-raw " " face0)

                                  (when (and (boundp 'erc-track-minor-mode) erc-track-minor-mode)
                                    (powerline-raw erc-modified-channels-object face1 'l))
                                  ))
                            (center (list
                                     ;; (let ((song (truncate-string-to-width (shell-string "mpc current") 100)))
                                     ;;   (when (and active (> (length song) 0))
                                     ;;     (powerline-raw (concat "  " song) face1 'l)))
                                     (unless active
                                       (when (and (fboundp 'org-clocking-p) (org-clocking-p))
                                         (powerline-raw (substring-no-properties (org-clock-get-clock-string)) face1 'l)))
                                     ))
                            (rhs (list
                                  ;; (powerline-vc face0 'r)

                                  ;; (when active
                                  ;;   (concat
                                  ;;    (powerline-raw "  " face2)
                                  ;;    (powerline-raw
                                  ;;     (shell-string "xset -q | grep LED | awk '$10==\"00000000\"{print \"us\"} $10==\"00001000\"{print \"ru\"}'")
                                  ;;     face2)))

                                  (powerline-raw " " face2)
                                  ;; (unless (equal (shell-string "ls ~/Maildir/INBOX/new | wc -w") "0")
                                  ;;   (powerline-raw " " face2))
                                  (powerline-raw display-time-string face2 'r)
                                  (powerline-raw " " face2)
                                  )))
                       (concat (powerline-render lhs)
                               (powerline-fill-center face1 (/ (powerline-width center) 2.0))
                               (powerline-render center)
                               (powerline-fill face1 (powerline-width rhs))
                               (powerline-render rhs)))))))
  (powerline-ap4y-theme)
  (setq-default powerline-default-separator 'nil))

;; window margins
;; (defun adjust-window-margins ()
;;   (set-frame-parameter nil 'internal-border-width 0))

;; (add-hook 'window-configuration-change-hook #'adjust-window-margins)
;; (adjust-window-margins)

;; theme customization
