(use-package swift-mode
  :ensure t
  :disabled
  :mode "\\.swift\\'"
  :config
  (add-hook 'swift-mode-hook #'yas-minor-mode)
  (add-to-list 'company-backends 'company-swift))
