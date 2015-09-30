(require 'flycheck)
(require 'fringe-helper)
(add-hook 'after-init-hook #'global-flycheck-mode)

(fringe-helper-define 'flycheck-fringe-bitmap-double-arrow nil
  "........"
  "........"
  "........"
  ".X.X...."
  "..X.X..."
  ".X.X...."
  "........")
