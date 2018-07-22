(use-package dired
  :bind ("C-x C-j" . dired-jump)
  :init
  (load "dired-x")
  :config
  (setq image-dired-external-viewer "feh")

  ;;; recursive copy & delete
  (setq dired-recursive-copies 'always)
  (setq dired-recursive-deletes 'always))
