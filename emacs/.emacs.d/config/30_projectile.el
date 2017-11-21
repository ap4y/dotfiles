(use-package projectile
  :ensure t
  :defer 5
  :commands projectile-mode
  :config
  (setq projectile-cache-file (expand-file-name  "projectile.cache" custom-savefile-dir))
  (setq projectile-completion-system 'ivy)
  (projectile-mode t))
