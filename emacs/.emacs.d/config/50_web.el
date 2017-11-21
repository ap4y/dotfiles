(use-package web-mode
  :ensure t
  :mode "\\.erb\\|.html?\\'"
  :preface
  (defun web-mode-defaults ()
    (setq web-mode-markup-indent-offset 2))
  :config
  (add-hook 'web-mode-hook 'web-mode-defaults)
  (setq web-mode-enable-auto-pairing nil))

;; (sp-with-modes '(web-mode)
;;   (sp-local-pair "%" "%"
;;                  :unless '(sp-in-string-p)
;;                  :post-handlers '(((lambda (&rest _ignored)
;;                                      (just-one-space)
;;                                      (save-excursion (insert " ")))
;;                                    "SPC" "=" "#")))
;;   (sp-local-pair "<% "  " %>" :insert "C-c %")
;;   (sp-local-pair "<%= " " %>" :insert "C-c =")
;;   (sp-local-pair "<%# " " %>" :insert "C-c #")
;;   (sp-local-tag "%" "<% "  " %>")
;;   (sp-local-tag "=" "<%= " " %>")
;;   (sp-local-tag "#" "<%# " " %>"))
