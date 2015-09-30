(require 'git-gutter-fringe+)
(global-git-gutter+-mode)

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
  "..X.X...")
