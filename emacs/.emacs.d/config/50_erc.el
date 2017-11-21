(use-package erc
  :commands start-irc
  :preface
  (defun filter-server-buffers ()
    (delq nil
          (mapcar
           (lambda (x) (and (erc-server-buffer-p x) x))
           (buffer-list))))

  (defun start-irc ()
    "Connect to IRC?"
    (interactive)
    (when (y-or-n-p "Do you want to start IRC? ")
      ;; (erc-tls :server "irc.freenode.net" :port 6697 :nick "ap4y")
      (erc-tls :server "ap4y.me" :port 6698 :nick "ap4y")))

  (defun stop-irc ()
    "Disconnects from all irc servers"
    (interactive)
    (dolist (buffer (filter-server-buffers))
      (message "Server buffer: %s" (buffer-name buffer))
      (with-current-buffer buffer
        (erc-quit-server "Asta la vista"))))

  (defun erc-login ()
    "Perform user authentication at the IRC server."
    (erc-log (format "login: nick: %s, user: %s %s %s :%s"
                     (erc-current-nick)
                     (user-login-name)
                     (or erc-system-name (system-name))
                     erc-session-server
                     erc-session-user-full-name))
    (if erc-session-password
        (erc-server-send (format "PASS %s" erc-session-password))
      (message "Logging in without password"))
    (when (and (featurep 'erc-sasl) (erc-sasl-use-sasl-p))
      (erc-server-send "CAP REQ :sasl"))
    (erc-server-send (format "NICK %s" (erc-current-nick)))
    (erc-server-send
     (format "USER %s %s %s :%s"
             ;; hacked - S.B.
             (if erc-anonymous-login erc-email-userid (user-login-name))
             "0" "*"
             erc-session-user-full-name))
    (erc-update-mode-line))

  :config
  (require 'erc-log)
  (require 'erc-notify)
  (require 'erc-spelling)
  (require 'erc-autoaway)
  (require 'erc-sasl "../scripts/erc-sasl.el")

  ;; erc buffer behavior
  (setq erc-join-buffer 'bury)

  ;; Interpret mIRC-style color commands in IRC chats
  (setq erc-interpret-mirc-color t)

  ;; The following are commented out by default, but users of other
  ;; non-Emacs IRC clients might find them useful.
  ;; Kill buffers for channels after /part
  (setq erc-kill-buffer-on-part t)
  ;; Kill buffers for private queries after quitting the server
  (setq erc-kill-queries-on-quit t)
  ;; Kill buffers for server messages after quitting the server
  (setq erc-kill-server-buffer-on-quit t)

  ;; open query buffers in the current window
  (setq erc-query-display 'buffer)

  ;; exclude boring stuff from tracking
  (erc-track-mode t)
  (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                  "324" "329" "332" "333" "353" "477"))

  ;; logging
  (setq erc-log-channels-directory "~/.erc/logs/")

  (if (not (file-exists-p erc-log-channels-directory))
      (mkdir erc-log-channels-directory t))

  (setq erc-save-buffer-on-part t)

  ;; truncate long irc buffers
  (erc-truncate-mode +1)

  ;; enable spell checking
  (erc-spelling-mode 1)

  ;; autoaway setup
  (setq erc-auto-discard-away t)
  (setq erc-autoaway-idle-seconds 600)
  (setq erc-autoaway-idle-method 'emacs)

  ;; utf-8 always and forever
  (setq erc-server-coding-system '(utf-8 . utf-8))

  (setq erc-autojoin-channels-alist
        '(("freenode.net" "#ruby-lang" "#openbsd" "#voidlinux" "#go-nuts")))
  (setq erc-hide-list '("JOIN" "PART" "QUIT" "MODE"))

  ;; Dynamically fill buffers
  (add-hook 'window-configuration-change-hook
            '(lambda ()
               (setq erc-fill-column (- (window-width) 2))))

  ;; Make erc tracking come after everything else
  (setq erc-track-position-in-mode-line 'after-modes)

  ;; Enable SASL for freenode
  (add-to-list 'erc-sasl-server-regexp-list "irc\\.freenode\\.net"))
