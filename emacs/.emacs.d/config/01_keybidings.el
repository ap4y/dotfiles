(global-set-key (kbd "C-x \\") 'align-regexp)          ;; Align your code.
(global-set-key (kbd "C-x m") 'eshell)                 ;; Start eshell or switch to it.'
(global-set-key (kbd "C-x C-b") 'ibuffer)              ;; replace buffer-menu with ibuffer
(global-set-key (kbd "C-x g") 'magit-status)           ;; Magit status
(global-set-key (kbd "C-=") 'er/expand-region)         ;; Expand region
(global-set-key (kbd "C-c b") 'toggle-buffer)          ;; Toggle buffers
(global-set-key (kbd "C-c f") 'recentf-ido-find-file)  ;; Recents
(global-set-key (kbd "C-c r") 'rename-buffer-and-file) ;; Rename buffer
(global-set-key (kbd "C-c j") 'top-join-line)          ;; Join lines
(global-set-key (kbd "C-c k") 'custom-kill-whole-line) ;; Kill line

;; windmove
(global-set-key (kbd "C-x k") 'windmove-up)
(global-set-key (kbd "C-x l") 'windmove-down)
(global-set-key (kbd "C-x ;") 'windmove-right)
(global-set-key (kbd "C-x j") 'windmove-left)

;; winner
(global-set-key (kbd "C-c l") 'winner-undo)
(global-set-key (kbd "C-c ;") 'winner-redo)

;; Adaptive beginning of the line
(global-set-key [remap move-beginning-of-line] 'custom-move-beginning-of-line)

;; auto indent yanked text
(global-set-key (kbd "C-M-y") (lambda ()
                                (interactive)
                                (yank)
                                (indent-region (region-beginning) (region-end))))
