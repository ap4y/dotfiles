;; yaml-mode doesn't derive from prog-mode, but we can at least
;; whitespace-mode and apply cleanup.
(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'"
  :config
  (add-hook 'yaml-mode-hook 'whitespace-mode)
  (add-hook 'yaml-mode-hook 'subword-mode)
  (add-hook 'yaml-mode-hook
            (lambda () (add-hook 'before-save-hook 'whitespace-cleanup nil t))))
