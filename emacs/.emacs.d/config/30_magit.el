(use-package git-timemachine
  :ensure t
  :commands git-timemachine)

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x G" . magit-status-with-prefix))
  :config
  (setq magit-push-always-verify nil)
  (setq magit-completing-read-function 'ivy-completing-read)

  (setq git-commit-summary-max-length 80)

  ;; (setq magit-display-buffer-function
  ;;       (lambda (buffer)
  ;;         (display-buffer buffer '(display-buffer-same-window))))
  )
