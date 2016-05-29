#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Fonts
xset +fp /usr/share/fonts/local
xset +fp /usr/local/share/fonts
xset +fp /home/ap4y/.fonts
xset fp rehash

# Mouse Acceleration Settings
# xset m 0 0

# Load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Load Xmodmap
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# color profile
xcalib -d :0 ~/.color/icc/macbook.icc
xcalib -d :1 ~/.color/icc/dell_u2515h.icc

# Screen brightness
xbacklight -set 50

# Composite manager
# compton -b

# Background
sh ~/.fehbg

# urxvt daemon
urxvtd -q -f -o &

# start wm
exec cwm
