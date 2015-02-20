;; tabs settings
(setq-default tab-width 2)

(defun go-mode-defaults ()
  ;; Add to default go-mode key bindings
  (let ((map go-mode-map))
    (define-key map (kbd "C-c a") 'go-test-current-project)
    (define-key map (kbd "C-c m") 'go-test-current-file)
    (define-key map (kbd "C-c .") 'go-test-current-test)
    (define-key map (kbd "C-c s") 'go-run)
    (define-key map (kbd "C-h f") 'godoc-at-point))

  ;; Prefer goimports to gofmt if installed
  (let ((goimports (executable-find "goimports")))
    (when goimports
      (setq gofmt-command goimports)))

  ;; gofmt on save
  (add-hook 'before-save-hook 'gofmt-before-save nil t)

  ;; stop whitespace being highlighted
  (whitespace-toggle-options '(tabs))

  ;; Company mode settings
  (set (make-local-variable 'company-backends) '(company-go))

  ;; El-doc for Go
  (go-eldoc-setup)

  ;; CamelCase aware editing operations
  (subword-mode +1))

(add-hook 'go-mode-hook 'go-mode-defaults)
