(use-package yari
  :ensure t
  :commands yari)

(use-package chruby
  :ensure t
  :commands chruby-use)

(use-package ruby-mode
  :mode "\\(?:\\.rb\\|ru\\|rake\\|jbuilder\\|gemspec\\|podspec\\|Gemfile\\)\\'"
  :bind (:map ruby-mode-map
              ("C-c m" . ruby-test-run)
              ("C-c ." . ruby-test-run-at-point)
              ("C-c /" . ruby-test-toggle-implementation-and-specification))
  :preface
  (defun ruby-mode-defaults ()
    (subword-mode +1))
  :init
  (use-package ruby-test-mode
    :ensure t)
  :config
  (add-hook 'ruby-mode-hook 'ruby-mode-defaults))
