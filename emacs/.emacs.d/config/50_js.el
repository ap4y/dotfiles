(use-package js2-mode
  :ensure t
  :mode "\\.js\\'"
  :preface
  (defun js-mode-defaults ()
    ;; electric-layout-mode doesn't play nice with smartparens
    (setq-local electric-layout-rules '((?\; . after)))
    (setq mode-name "JS2")
    (js2-imenu-extras-mode +1)
    (subword-mode))
  :config
  (add-hook 'js2-mode-hook 'js-mode-defaults)
  (setq js2-basic-offset 2))
