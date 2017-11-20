(require 'magit)
(setq magit-push-always-verify nil)
(setq magit-completing-read-function 'ivy-completing-read)

(custom-set-variables
 '(git-commit-summary-max-length 80))
