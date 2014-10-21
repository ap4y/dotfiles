(defun makefile-mode-defaults ()
  (whitespace-toggle-options '(tabs))
  (setq indent-tabs-mode t ))

(add-hook 'makefile-mode-hook 'makefile-mode-defaults)
