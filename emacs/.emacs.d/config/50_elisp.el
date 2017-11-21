(use-package emacs-lisp-mode
  :mode :mode "\\.el\\|Cask\\'"
  :preface
  (defun elisp-mode-defaults ()
    (smartparens-strict-mode +1)
    (rainbow-delimiters-mode +1)
    (eldoc-mode)
    (rainbow-mode +1)
    (setq mode-name "EL"))
  :config
  (add-hook 'emacs-lisp-mode-hook 'elisp-mode-defaults))
