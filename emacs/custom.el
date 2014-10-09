;;; custom.el --- Emacs Prelude: custom package configuration.

;;; Commentary:

;;; Code:

;; visual settings
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq default-frame-alist '((font . "Ubuntu Mono-13")))
;; (setq-default line-spacing 3)

;; tabs settings (mostly for go)
(setq-default tab-width 2)

;; mac os meta rebind
;; (setq mac-command-modifier 'meta)
;; (setq mac-option-modifier 'super)

;; additional packages
(prelude-ensure-module-deps '(dash-at-point handlebars-mode
                                            elixir-mode ag
                                            rspec-mode js2-mode
                                            rust-mode))

;; multi-term settings
(setq multi-term-program "/bin/zsh")
(global-set-key (kbd "C-c T") 'multi-term)

;; js2-mode settings
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq js2-basic-offset 2)
(add-hook 'js2-mode-hook 'subword-mode)

;; don't use rake in rspec-mode
(setq rspec-use-rake-when-possible nil)
(setq rspec-use-zeus-when-possible t)

;; enforcing utf-8 in terminal
(add-hook 'term-exec-hook
          (function
           (lambda ()
             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))))

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

;; sass-mode
(add-hook 'scss-mode-hook 'whitespace-mode)

;; erc
(require 'erc-dcc)
(setq erc-nick "ap4y")
(setq erc-autojoin-channels-alist
      '(("freenode.net" "#emberjs" "##objc" "#macdev" "#swift-lang"
         "#iphonedev" "#coreaudio" "#ruby-lang" "#mongodb"
         "#coreos" "#RubyOnRails" "#go-nuts")))
(setq erc-hide-list '("JOIN" "PART" "QUIT"))
; Make erc tracking come after everything else
(setq erc-track-position-in-mode-line 'after-modes)

;; web-mode
(defun custom-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2))
(add-hook 'web-mode-hook 'custom-web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))

;; setting line width to 120 for rust and objc modes
(defun custom-ws-line-column-hook ()
  "Setting whitespace column to 120."
  (setq whitespace-line-column 120))
(add-hook 'rust-mode-hook 'custom-ws-line-column-hook)
(add-hook 'objc-mode-hook 'custom-ws-line-column-hook)

;; swift-mode
(add-hook 'swift-mode-hook 'subword-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-swift-executable nil)
 '(flycheck-swift-linked-source "/Users/arthurevstifeev/github/Leaf/Leaf/**/*.swift")
 '(flycheck-swift-linked-sources "/Users/arthurevstifeev/github/Leaf/Leaf/**/*.swift")
 '(flycheck-swift-sdk-path
   (quote
    ("/Users/arthurevstifeev/Downloads/Xcode6-Beta3.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator8.0.sdk"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; Local Variables:
;; byte-compile-warnings: (not cl-functions)
;; End:

;;; custom.el ends here
