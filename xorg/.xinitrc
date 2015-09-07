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
xset fp rehash

# Load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Load Xmodmap
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# color profile
xcalib -d :0 ~/.color/icc/dell_u2412m_custom.icc

# Daemons
compton -b

# Background
sh ~/.fehbg

# urxvt daemon
urxvtd &

# start wm
sxhkd &
exec bspwm
