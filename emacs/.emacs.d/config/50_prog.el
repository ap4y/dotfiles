(use-package heroku
  :ensure t
  :commands heroku-run)

(defun prog-mode-defaults ()
  (company-mode)
  (flycheck-mode)
  (flyspell-prog-mode)
  (which-function-mode 1)
  (smartparens-mode +1)
  (enable-whitespace-mode)
  (git-gutter+-mode)
  (setq comment-auto-fill-only-comments t))
(add-hook 'prog-mode-hook 'prog-mode-defaults)
