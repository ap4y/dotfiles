(use-package counsel
  :ensure t
  :bind (("\C-s" . swiper)
         ("C-c C-r" . ivy-resume)
         ("M-x" . counsel-M-x)
         ("M-y" . counsel-yank-pop)
         ("C-x C-f" . counsel-find-file)
         ("C-c f" . counsel-recentf)
         ("C-c i" . counsel-imenu)
         ("C-c g" . counsel-git)
         ("C-c a" . counsel-ag)
         ("C-c v" . counsel-push-view)
         ("C-c V" . counsel-pop-view)
         ("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "%d/%d ")
  (setq enable-recursive-minibuffers t)
  (setq ivy-re-builders-alist
        '((t . ivy--regex-plus))))
