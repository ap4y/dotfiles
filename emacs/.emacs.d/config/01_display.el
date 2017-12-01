;; hide toolbar
(tool-bar-mode 0)

;; hide menubar
(menu-bar-mode 0)

;; hide scroll bar
(set-scroll-bar-mode nil)

;; font
(if (featurep 'ns)
    (progn
      (set-face-attribute 'default nil :font "Source Code Pro-12")
      (set-frame-font "Source Code Pro-12" nil t))
  (progn
    (set-face-attribute 'default nil :font "Iosevka Medium-10")
    (set-frame-font "Iosevka Medium-10")
    ))

;; theme
(use-package spacemacs-theme
  :ensure t
  :defer t
  :init
  (load-theme 'spacemacs-light t))

;; highlight the current line
(global-hl-line-mode +1)

(use-package volatile-highlights
  :ensure t
  :config
  (volatile-highlights-mode t))

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; stop blink cursor
(blink-cursor-mode 0)

;; make the fringe (gutter) smaller
;; the argument is a width in pixels (the default is 8)
(fringe-mode '(8 . 0))

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " " (:eval (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b"))))

;; modeline
(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme)
  (setq-default powerline-default-separator 'wave)
  (spaceline-toggle-minor-modes-off)
  (spaceline-compile))

;; window margins
(defun adjust-window-margins ()
  (set-frame-parameter nil 'internal-border-width 15))

(add-hook 'window-configuration-change-hook #'adjust-window-margins)
(adjust-window-margins)
