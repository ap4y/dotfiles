(defun enable-whitespace-mode ()
  "Enable `whitespace-mode'."
  (add-hook 'before-save-hook 'whitespace-cleanup nil t)
  (whitespace-mode +1))

(add-hook 'text-mode-hook 'enable-whitespace-mode)

;; whitespace-mode config
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face tabs empty trailing lines-tail))
