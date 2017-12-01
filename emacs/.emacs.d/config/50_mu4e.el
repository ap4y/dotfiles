(use-package mu4e
  :commands mu4e
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :config
  (setq mu4e-sent-folder "/Sent")
  (setq mu4e-drafts-folder "/Drafts")
  (setq mu4e-trash-folder "/Trash")

  (setq mu4e-get-mail-command "offlineimap")

  (require 'smtpmail)
  (setq message-send-mail-function 'smtpmail-send-it
        user-full-name "Arthur Evstifeev"
        user-mail-address "mail@ap4y.me"
        smtpmail-default-smtp-server "ap4y.me"
        smtpmail-smtp-server "ap4y.me"
        smtpmail-smtp-service 465
        smtpmail-stream-type  'ssl)

  (setq message-kill-buffer-on-exit t)
  ;; (add-hook 'message-send-hook 'mml-secure-message-sign-pgpmime)

  (setq mu4e-view-prefer-html t)
  (setq mu4e-html2text-command "w3m -T text/html")
  (add-to-list 'mu4e-view-actions
               '("ViewInBrowser" . mu4e-action-view-in-browser) t))
