(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))

(defun web-mode-defaults ()
  (setq web-mode-markup-indent-offset 2))

(add-hook 'web-mode-hook 'web-mode-defaults)

;; make web-mode play nice with smartparens
(setq web-mode-enable-auto-pairing nil)

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
