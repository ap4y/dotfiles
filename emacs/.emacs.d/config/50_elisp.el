(defun elisp-mode-defaults ()
  "Sensible defaults for `emacs-lisp-mode'."
  (smartparens-strict-mode +1)
  (rainbow-delimiters-mode +1)
  (turn-on-eldoc-mode)
  (rainbow-mode +1)
  (setq mode-name "EL"))

(add-hook 'emacs-lisp-mode-hook 'elisp-mode-defaults)

(add-to-list 'auto-mode-alist '("Cask\\'" . emacs-lisp-mode))
