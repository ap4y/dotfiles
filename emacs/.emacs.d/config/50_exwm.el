(use-package exwm
  :ensure t
  :commands exwm-enable
  :config
  ;; Fix problems with Ido
  (require 'exwm-config)
  (exwm-config-ido)

  ;; auto-hide minibuffer
  ;; (setq exwm-workspace-minibuffer-position 'bottom)

  ;; force tiling
  ;; (setq exwm-manage-force-tiling nil)
  ;; (setq exwm-workspace-show-all-buffers t)
  ;; (setq exwm-layout-show-all-buffers t)

  ;; Make class name the buffer name
  (add-hook 'exwm-update-class-hook
            (lambda ()
              (exwm-workspace-rename-buffer exwm-class-name)))
  (add-hook 'exwm-update-title-hook
            (lambda ()
              (exwm-workspace-rename-buffer exwm-title)))

  ;; toggle passthrough
  (defun toggle-exwm-input-line-mode-passthrough ()
    (interactive)
    (if exwm-input-line-mode-passthrough
        (progn
          (setq exwm-input-line-mode-passthrough nil)
          (message "App receives all the keys now (with some simulation)"))
      (progn
        (setq exwm-input-line-mode-passthrough t)
        (message "emacs receives all the keys now")))
    (force-mode-line-update))
  (setq exwm-input-line-mode-passthrough nil)

  ;; We always need a way to go back to line-mode from char-mode
  (exwm-input-set-key (kbd "s-R") #'exwm-reset)
  (exwm-input-set-key (kbd "s-q") #'toggle-exwm-input-line-mode-passthrough)
  (exwm-input-set-key (kbd "s-w") #'kill-this-buffer)
  (exwm-input-set-key (kbd "s-f") #'exwm-layout-toggle-fullscreen)
  (exwm-input-set-key (kbd "s-m") #'exwm-workspace-move-window)

  (exwm-input-set-key (kbd "s-j") 'windmove-left)
  (exwm-input-set-key (kbd "s-k") 'windmove-down)
  (exwm-input-set-key (kbd "s-l") 'windmove-up)
  (exwm-input-set-key (kbd "s-;") 'windmove-right)

  (exwm-input-set-key (kbd "s-J") 'buf-move-left)
  (exwm-input-set-key (kbd "s-K") 'buf-move-down)
  (exwm-input-set-key (kbd "s-L") 'buf-move-up)
  (exwm-input-set-key (kbd "s-:") 'buf-move-right)

  (exwm-input-set-key (kbd "M-s-j") 'shrink-window-horizontally)
  (exwm-input-set-key (kbd "M-s-k") 'shrink-window)
  (exwm-input-set-key (kbd "M-s-l") 'enlarge-window)
  (exwm-input-set-key (kbd "M-s-;") 'enlarge-window-horizontally)

  ;; Bind "s-1" to "s-5" to switch to the corresponding workspace.
  (setq exwm-workspace-number 4)
  (add-hook 'exwm-workspace-list-change-hook
            (lambda ()
              (xcb:+request exwm--connection
                  (make-instance 'xcb:ewmh:set-_NET_DESKTOP_NAMES
                                 :window exwm--root :data "term\0browser\0file\0etc"))
              (xcb:flush exwm--connection)))

  (dotimes (i 4)
    (exwm-input-set-key (kbd (format "S-<f%d>" (+ i 1)))
                        `(lambda ()
                           (interactive)
                           (exwm-workspace-move-window ,i)))
    (exwm-input-set-key (kbd (format "<f%d>" (+ i 1)))
                        `(lambda ()
                           (interactive)
                           (exwm-workspace-switch-create ,i))))

  (exwm-input-set-key (kbd "s-d")
                      (lambda (command)
                        (interactive (list (read-shell-command "~ » ")))
                        (start-process-shell-command command nil command)))

  (exwm-input-set-key (kbd "s-<return>")
                      (lambda () (interactive)
                        (start-process-shell-command "" nil "urxvtc")))

  (exwm-input-set-key (kbd "<XF86AudioLowerVolume>")
                      (lambda () (interactive)
                        (start-process-shell-command "" nil "pactl set-sink-volume 0 -5%")))

  (exwm-input-set-key (kbd "<XF86AudioRaiseVolume>")
                      (lambda () (interactive)
                        (start-process-shell-command "" nil "pactl set-sink-volume 0 +5%")))

  ;; Set up emacs emulation bindings for line mode.
  (exwm-input-set-simulation-keys
   `(([?\C-b] . left)
     ([?\C-f] . right)
     ([?\C-p] . up)
     ([?\C-n] . down)
     ([?\M-<] . home)
     ([?\M->] . end)
     ([?\C-w] . ?\C-x)
     ([?\M-w] . ?\C-c)
     ([?\C-y] . ?\C-v)))

  (dolist (k '(XF86AudioLowerVolume
               XF86AudioRaiseVolume
               XF86AudioMute
               XF86AudioPlay
               XF86AudioStop
               XF86AudioPrev
               XF86AudioNext
               ?\s-r))
    (cl-pushnew k exwm-input-prefix-keys))

  ;; multi-monitor
  (require 'exwm-randr)
  (add-hook 'exwm-randr-screen-change-hook
            (lambda ()
              (start-process-shell-command "xrandr" nil "xrandr --output DP1 --auto --primary")
              ;; (start-process-shell-command "bar" nil "lbar")
              ))
  (exwm-randr-enable))
