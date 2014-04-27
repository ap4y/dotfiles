;;; custom.el --- Emacs Prelude: custom package configuration.

;;; Commentary:

;;; Code:

;; visual settings
(menu-bar-mode -1)
(scroll-bar-mode -1)
(setq default-frame-alist '((font . "Anonymous Pro-14")))
(setq-default line-spacing 3)

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
      '(("freenode.net" "#emberjs" "##objc" "#macdev"
         "#iphonedev" "#coreaudio" "#ruby-lang" "#mongodb"
         "#hbase" "#RubyOnRails" "#broccolijs")))

;; rust-mode
(add-hook 'rust-mode-hook 'subword-mode)

;; Local Variables:
;; byte-compile-warnings: (not cl-functions)
;; End:

;;; custom.el ends here
