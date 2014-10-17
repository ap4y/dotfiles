;; flyspell-mode does spell-checking on the fly as you type
(require 'flyspell)
(setq ispell-program-name "aspell" ; use aspell instead of ispell
      ispell-extra-args '("--sug-mode=ultra"))

(defun prelude-enable-flyspell ()
  "Enable command `flyspell-mode' if is not nil."
  (when (executable-find ispell-program-name)
    (flyspell-mode +1)))

(add-hook 'text-mode-hook 'prelude-enable-flyspell)
