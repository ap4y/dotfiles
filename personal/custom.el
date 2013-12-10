;;; custom.el --- Emacs Prelude: custom package configuration.

;;; Commentary:

;;; Code:

(menu-bar-mode -1)
(add-to-list 'default-frame-alist '(font . "Inconsolata-dz-24"))

(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'super)

(prelude-ensure-module-deps '(dash-at-point multi-term
                                            handlebars-mode auto-complete yasnippet
                                            elixir-mode helm-ag))

(setq multi-term-program "/bin/zsh")

(global-set-key (kbd "C-c t") 'multi-term-next)
(global-set-key (kbd "C-c T") 'multi-term)

;; Local Variables:
;; byte-compile-warnings: (not cl-functions)
;; End:

;;; custom.el ends here
