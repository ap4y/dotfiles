(global-set-key (kbd "C-x \\") 'align-regexp)          ;; Align your code.
(global-set-key (kbd "C-c b") 'toggle-buffer)          ;; Toggle buffers
(global-set-key (kbd "C-c r") 'rename-buffer-and-file) ;; Rename buffer
(global-set-key (kbd "C-c j") 'top-join-line)          ;; Join lines
(global-set-key (kbd "C-c k") 'custom-kill-whole-line) ;; Kill line
(global-set-key (kbd "C-z") 'custom-kill-whole-line)   ;; Kill line

;; Adaptive beginning of the line
(global-set-key [remap move-beginning-of-line] 'custom-move-beginning-of-line)

;; auto indent yanked text
(global-set-key (kbd "C-M-y") (lambda ()
                                (interactive)
                                (yank)
                                (indent-region (region-beginning) (region-end))))

(use-package avy
  :ensure t
  :bind (("M-g l" . avy-goto-line)
         ("M-g c" . avy-goto-char-2)))

(use-package dumb-jump
  :ensure t
  :bind (("M-g j" . dumb-jump-go)
         ("M-g o" . dumb-jump-go-other-window)))

(use-package ace-window
  :ensure t
  :bind (("s-r" . ace-window))
  :config
  (setq aw-dispatch-always t)
  (setq aw-scope 'frame))

(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region)
         ("C--" . er/contract-region)))
