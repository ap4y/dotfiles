(setq eshell-prompt-function (lambda nil
                               (concat
                                (car (last (split-string (eshell/pwd) "/")))
                                " » ")))
(setq eshell-prompt-regexp "^[^#$»\n]*[#$»] ")
