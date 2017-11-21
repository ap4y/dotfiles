(use-package scss-mode
  :ensure t
  :mode "\\.css\\|.scss\\|.sass\\'"
  :preface
  (defun css-mode-defaults ()
    (rainbow-mode +1)
    (run-hooks 'prog-mode-defaults))
  :config
  (add-hook 'css-mode-hook 'css-mode-defaults)
  (setq css-indent-offset 2)
  (setq scss-compile-at-save nil))
