(use-package objc-mode
  :mode "\\.h\\|.m\\'"
  :preface
  (defun objc-mode-defaults ()
    (add-to-list 'projectile-other-file-alist '("h" "m"))
    (add-to-list 'projectile-other-file-alist '("m" "h"))

    ;; clang-format on save
    (add-hook 'before-save-hook 'clang-format-buffer nil t)

    (c-set-style "llvm.org")
    (setq c-basic-offset 4)
    (setq whitespace-line-column 120)

    ;; CamelCase aware editing operations
    (subword-mode +1))
  :config
  (add-hook 'objc-mode-hook 'objc-mode-defaults)
  (add-to-list 'magic-mode-alist
               `(,(lambda ()
                    (and (string= (file-name-extension buffer-file-name) "h")
                         (re-search-forward "@\\<interface\\>"
                                            magic-mode-regexp-match-limit t)))
                 . objc-mode)))
