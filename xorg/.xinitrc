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
xset +fp /usr/share/fonts/local/
xset fp rehash

# Load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Load Xmodmap
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

# Daemons
compton -b

# Background
sh ~/.fehbg

# urxvt daemon
urxvtd &

# VBox client
/usr/bin/VBoxClient-all

# start wm
sxhkd &
exec bspwm
# exec i3
