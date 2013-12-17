;;; custom.el --- Emacs Prelude: custom package configuration.

;;; Commentary:

;;; Code:

;; visual settings
(menu-bar-mode -1)
(add-to-list 'default-frame-alist '(font . "Inconsolata-dz-24"))

;; mac os meta rebind
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

;; additional packages
(prelude-ensure-module-deps '(dash-at-point multi-term
                                            handlebars-mode auto-complete yasnippet
                                            elixir-mode ag rspec-mode))

;; multi-term settings
(setq multi-term-program "/bin/zsh")

(global-set-key (kbd "C-c t") 'multi-term-next)
(global-set-key (kbd "C-c T") 'multi-term)

;; 2 spaces indentation for js
(setq js-indent-level 2)

;; don't use rake in rspec-mode
(setq rspec-use-rake-when-possible nil)
(setq rspec-use-zeus-when-possible t)

;; enforcing utf-8
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Local Variables:
;; byte-compile-warnings: (not cl-functions)
;; End:

;;; custom.el ends here
