(require 'eziam-common)

(deftheme eziam-ap4y "Custom light Eziam color theme")

(eziam-with-color-variables
  (
   ;; Base palette
   ("color-0"                . "#ffffff")
   ("color-1"                . "#eeeeee")
   ("color-2"                . "#dddddd")
   ("color-3"                . "#cccccc")
   ("color-4"                . "#aaaaaa")
   ("color-5"                . "#888888")
   ("color-6"                . "#555555")
   ("color-7"                . "#222222")
   ("color-8"                . "#333333")
   ;; Headings
   ("ol1-fg"                 . nil)
   ("ol1-bg"                 . "#ffffff")
   ("ol2-fg"                 . nil)
   ("ol2-bg"                 . "#d6eaf4")
   ("ol3-fg"                 . nil)
   ("ol3-bg"                 . "#c1d3dc")
   ("ol4-fg"                 . nil)
   ("ol4-bg"                 . "#abbbc3")
   ("ol5-fg"                 . "#eeeeee")
   ("ol5-bg"                 . "#96a4ab")
   ("ol6-fg"                 . nil)
   ("ol6-bg"                 . "#d7d7d7")
   ("ol7-fg"                 . nil)
   ("ol7-bg"                 . nil)
   ("ol8-fg"                 . nil)
   ("ol8-bg"                 . nil)
   ;; Misc
   ("transient-highlight"    . "yellow")
   ("transient-highlight-fg" . "#000000")
   ("warning"                . "DarkOrange")
   ("error"                  . "#ff0000")
   ("info"                   . "#2244ff")
   ("ok"                     . "ForestGreen")

   ("rainbow-1"              . "#ff0000")
   ("rainbow-2"              . "#ff7700")
   ("rainbow-3"              . "goldenrod")
   ("rainbow-4"              . "#00aa00")
   ("rainbow-5"              . "#0000ff")
   ("rainbow-6"              . "#8f00ff")
   )
  (eziam-apply-custom-theme 'eziam-ap4y)
  (custom-theme-set-faces
   'eziam-ap4y
   `(fringe ((t (:foreground ,color-4 :background ,color-1))))

   `(mode-line           ((t (:foreground ,color-1 :background ,color-6 :box (:line-width 8 :color ,color-6) ))))
   `(mode-line-inactive  ((t (:foreground ,color-1 :background ,color-4 :box (:line-width 8 :color ,color-4) ))))

   `(powerline-active1   ((t (:background ,color-3 :foreground ,color-8 :box (:line-width 8 :color ,color-3) ))))
   `(powerline-active2   ((t (:background ,color-1 :foreground ,color-5 :box (:line-width 8 :color ,color-1) ))))
   `(powerline-inactive1 ((t (:background ,color-1 :foreground ,color-3 :box (:line-width 8 :color ,color-1) ))))
   `(powerline-inactive2 ((t (:background ,color-1 :foreground ,color-4 :box (:line-width 8 :color ,color-1) ))))

   `(ivy-current-match           ((t (:background ,color-3 :inherit bold))))
   `(ivy-minibuffer-match-face-1 ((t (:inherit bold))))
   `(ivy-minibuffer-match-face-2 ((t (:foreground ,color-6 :underline t))))
   `(ivy-minibuffer-match-face-3 ((t (:foreground ,color-6 :underline t))))
   `(ivy-minibuffer-match-face-4 ((t (:foreground ,color-5 :underline t))))
   )
  )

;;;###autoload
(and load-file-name
     (boundp 'custom-theme-load-path)
     (add-to-list 'custom-theme-load-path
                  (file-name-as-directory
                   (file-name-directory load-file-name))))

(provide-theme 'eziam-ap4y)
