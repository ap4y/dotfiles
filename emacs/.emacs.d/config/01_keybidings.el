(global-set-key (kbd "C-x \\") 'align-regexp)          ;; Align your code.
(global-set-key (kbd "C-c b") 'toggle-buffer)          ;; Toggle buffers
(global-set-key (kbd "C-c r") 'rename-buffer-and-file) ;; Rename buffer
(global-set-key (kbd "C-c j") 'top-join-line)          ;; Join lines
(global-set-key (kbd "C-c k") 'custom-kill-whole-line) ;; Kill line

;; Adaptive beginning of the line
(global-set-key [remap move-beginning-of-line] 'custom-move-beginning-of-line)

;; auto indent yanked text
(global-set-key (kbd "C-M-y") (lambda ()
                                (interactive)
                                (yank)
                                (indent-region (region-beginning) (region-end))))
