(use-package clang-format
  :ensure t
  :commands clang-format-buffer)

(use-package cc-mode
  :mode "\\.hpp\\|.cpp\\'"
  :preface
  (defun c++-mode-defaults ()
    (add-to-list 'projectile-other-file-alist '("h" "cc"))
    (add-to-list 'projectile-other-file-alist '("cc" "h"))

    (custom-set-variables
     '(flycheck-gcc-language-standard "c++11")
     '(flycheck-clang-language-standard "c++11"))

    ;; clang-format on save
    (add-hook 'before-save-hook 'clang-format-buffer nil t)

    (c-set-style "llvm.org"))
  :config
  (add-hook 'c++-mode-hook 'c++-mode-defaults)
  (c-add-style "llvm.org"
               '((fill-column . 80)
                 (c++-indent-level . 2)
                 (c-basic-offset . 2)
                 (indent-tabs-mode . nil)
                 (c-offsets-alist . ((arglist-intro . ++)
                                     (innamespace . 0)
                                     (member-init-intro . ++))))))
