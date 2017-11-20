(require 'projectile)
(setq projectile-cache-file (expand-file-name  "projectile.cache" custom-savefile-dir))
(setq projectile-completion-system 'ivy)
(projectile-mode t)
