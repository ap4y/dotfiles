(use-package eshell
  :commands (eshell eshell-command)
  :bind (("C-x m" . eshell))
  :config
  (setq eshell-prompt-function (lambda nil
                                 (concat
                                  (car (last (split-string (eshell/pwd) "/")))
                                  " » ")))
  (setq eshell-prompt-regexp "^[^#$»\n]*[#$»] ")
  (setq eshell-scroll-to-bottom-on-input 'this)
  (setq eshell-glob-case-insensitive t)
  (setq eshell-error-if-no-glob t)
  (setq eshell-history-size (* 10 1024))
  (setq eshell-hist-ignoredups t)

  (defun ap4y/truncate-eshell-buffers ()
    "Truncates all eshell buffers"
    (interactive)
    (save-current-buffer
      (dolist (buffer (buffer-list t))
        (set-buffer buffer)
        (when (eq major-mode 'eshell-mode)
          (eshell-truncate-buffer)))))

  (setq ap4y/eshell-truncate-timer
        (run-with-idle-timer 5 t #'ap4y/truncate-eshell-buffers)))
