;; hide toolbar
(tool-bar-mode 0)

;; hide menubar
(menu-bar-mode 0)

;; hide scroll bar
(set-scroll-bar-mode nil)

;; suppress create new frame when open file from Finder.app
(setq ns-pop-up-frames nil)

;; font
(if (featurep 'ns)
    (progn
      (set-face-attribute 'default nil
                          :family "Source Code Pro"
                          :height 140))
  (progn
    (set-face-attribute 'default nil
                        :family "Source Code Pro"
                        :height 110)))

;; theme
(load-theme 'base16-eighties-dark t)

;; highlight the current line
(global-hl-line-mode +1)

(require 'volatile-highlights)
(volatile-highlights-mode t)
(diminish 'volatile-highlights-mode)

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; stop blink cursor
(blink-cursor-mode 0)

;; make the fringe (gutter) smaller
;; the argument is a width in pixels (the default is 8)
(if (fboundp 'fringe-mode)
    (fringe-mode 4))

;; more useful frame title, that show either a file or a
;; buffer name (if the buffer isn't visiting a file)
(setq frame-title-format
      '("" invocation-name " " (:eval (if (buffer-file-name)
                                          (abbreviate-file-name (buffer-file-name))
                                        "%b"))))

;; nyan-mode
(nyan-mode)
