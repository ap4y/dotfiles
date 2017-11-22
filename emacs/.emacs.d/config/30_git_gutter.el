(use-package git-gutter-fringe+
  :ensure t
  :config
  (fringe-helper-define 'git-gutter-fr+-added nil
    "........"
    "........"
    "........"
    "..X....."
    ".XXX...."
    "..X....."
    "........")

  (fringe-helper-define 'git-gutter-fr+-deleted nil
    "........"
    "........"
    "........"
    "........"
    "........"
    ".XXX...."
    "........"
    "........")

  (fringe-helper-define 'git-gutter-fr+-modified nil
    "........"
    "........"
    "..X.X..."
    ".XXXXX.."
    "..X.X..."
    ".XXXXX.."
    "..X.X..."))
