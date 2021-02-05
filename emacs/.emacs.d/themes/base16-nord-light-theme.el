;; base16-nord-light-theme.el -- A base16 colorscheme

;;; Commentary:
;; Base16: (https://github.com/chriskempson/base16)

;;; Authors:
;; Scheme: arcticicestudio
;; Template: Kaleb Elwert <belak@coded.io>

;;; Code:

(require 'base16-theme)

(defvar base16-nord-light-colors
  '(:base00 "#eceff4"
    :base01 "#e5e9f0"
    :base02 "#d8dee9"
    :base03 "#8fbcbb"
    :base04 "#2e3440"
    :base05 "#4c566a"
    :base06 "#434c5e"
    :base07 "#8fbcbb"
    :base08 "#bf616a"
    :base09 "#d08770"
    :base0A "#d08770"
    :base0B "#a3be8c"
    :base0C "#88c0d0"
    :base0D "#5e81ac"
    :base0E "#b48ead"
    :base0F "#81a1c1")
  "All colors for Base16 NordLight are defined here.")

;; Define the theme
(deftheme base16-nord-light)

;; Add all the faces to the theme
(base16-theme-define 'base16-nord-light base16-nord-light-colors)

;; Mark the theme as provided
(provide-theme 'base16-nord-light)

(provide 'base16-nord-light-theme)

;;; base16-nord-light-theme.el ends here
