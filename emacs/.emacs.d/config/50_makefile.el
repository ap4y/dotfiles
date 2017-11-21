(use-package makefile-mode
  :mode "Makefile\\'"
  :preface
  (defun makefile-mode-defaults ()
    (whitespace-toggle-options '(tabs))
    (setq indent-tabs-mode t))
  :config
  (add-hook 'makefile-mode-hook 'makefile-mode-defaults))
