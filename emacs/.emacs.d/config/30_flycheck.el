(use-package flycheck
  :ensure t
  :commands flycheck-mode
  :config
  (fringe-helper-define 'flycheck-fringe-bitmap-double-arrow nil
  "........"
  "........"
  "........"
  ".X.X...."
  "..X.X..."
  ".X.X...."
  "........"))
