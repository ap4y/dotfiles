(defun c++-mode-defaults ()
  (custom-set-variables
   '(flycheck-c/c++-googlelint-executable "/usr/bin/cpplint")
   '(flycheck-googlelint-filter "-legal/copyright")
   '(flycheck-googlelint-root "lib")
   '(flycheck-gcc-language-standard "c++11")
   '(flycheck-clang-language-standard "c++11"))
  (require 'flycheck-google-cpplint)
  (flycheck-add-next-checker 'c/c++-gcc 'c/c++-googlelint))

(add-hook 'c++-mode-hook 'c++-mode-defaults)
(add-hook 'c-mode-common-hook 'google-set-c-style)
