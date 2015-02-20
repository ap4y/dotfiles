;; js2-mode settings
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(setq js2-basic-offset 2)

(defun js-mode-defaults ()
  ;; electric-layout-mode doesn't play nice with smartparens
  (setq-local electric-layout-rules '((?\; . after)))
  (setq mode-name "JS2")
  (js2-imenu-extras-mode +1)
  (subword-mode))

(add-hook 'js2-mode-hook 'js-mode-defaults)
