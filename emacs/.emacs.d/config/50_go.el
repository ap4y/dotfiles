(use-package go-eldoc
  :ensure t
  :commands godoc-at-point)

(use-package go-mode
  :ensure t
  :mode :mode "\\.go\\'"
  :bind (:map go-mode-map
              ("C-c a" . go-test-current-project)
              ("C-c m" . go-test-current-file)
              ("C-c ." . go-test-current-test)
              ("C-c s" . go-run)
              ("C-c /" . ff-find-other-file)
              ("C-h f" . godoc-at-point))
  :preface
  (defun go-mode-defaults ()
    ;; Prefer goimports to gofmt if installed
    (let ((goimports (executable-find "goimports")))
      (when goimports
        (setq gofmt-command goimports)))

    ;; gofmt on save
    (add-hook 'before-save-hook 'gofmt-before-save nil t)

    ;; stop whitespace being highlighted
    (whitespace-toggle-options '(tabs))
    (setq whitespace-line-column 120)

    ;; Company mode settings
    (set (make-local-variable 'company-backends) '(company-go))

    ;; El-doc for Go
    (go-eldoc-setup)

    ;; CamelCase aware editing operations
    (subword-mode +1))
  :config
  (use-package company-go
    :ensure t)

  (use-package gotest
    :ensure t)

  (add-hook 'go-mode-hook 'go-mode-defaults)
  (setq-default tab-width 2))
