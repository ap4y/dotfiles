;;; custom.el --- Emacs Prelude: custom package configuration.

;;; Commentary:

;;; Code:

;; visual settings
(menu-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(font . "Inconsolata dz-14"))
(setq-default line-spacing 4)

;; mac os meta rebind
;; (setq mac-command-modifier 'meta)
;; (setq mac-option-modifier 'super)

;; additional packages
(prelude-ensure-module-deps '(dash-at-point multi-term
                                            handlebars-mode auto-complete
                                            yasnippet elixir-mode ag
                                            rspec-mode js2-mode))

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

;; irony-mode
(add-to-list 'load-path (expand-file-name "~/.emacs.d/personal/irony-mode/elisp"))

(require 'auto-complete-config)
(ac-config-default)

(require 'auto-complete)
(require 'yasnippet)
(require 'irony)

(irony-enable '(ac))

(defun custom-objc-hook ()
  (yas/minor-mode-on)
  (auto-complete-mode 1)
  (irony-mode 1))

(add-hook 'objc-mode-hook 'custom-objc-hook)

;; sass-mode
(add-hook 'scss-mode-hook 'whitespace-mode)

;; Local Variables:
;; byte-compile-warnings: (not cl-functions)
;; End:

;;; custom.el ends here
