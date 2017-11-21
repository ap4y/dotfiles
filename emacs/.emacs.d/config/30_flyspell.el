(use-package flyspell
  :commands flycheck-mode
  :config
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra")))

(add-hook 'text-mode-hook 'enable-flyspell-mode)
