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
xset +fp /home/ap4y/.fonts
xset fp rehash

# Mouse Acceleration Settings
# xset m 0 0

# Load Xresources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Load Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# Restore styles
wal -i ~/wall-2.jpg

# color profile
# xcalib ~/.color/icc/dell_u2515h.icc

# Composite manager
# compton -b

# set dpi
xrandr --dpi 117
xrandr --output DP-0 --auto --rotate left --output HDMI-0 --auto --left-of DP-0

# Background
sh ~/.fehbg

# Redshift
# redshift -l -36.84846:174.763332 -m randr:preserve=1 &

# auto lock
xautolock -time 5 -locker slock &
xautolock -time 10 -locker 'sudo zzz' &

# urxvt daemon
# urxvtd -q -f -o &

# keyboard layout
setxkbmap -model pc105 -layout us,ru -option grp:win_space_toggle

# start mail fetcher
# mail &

# start mpd
mpd &

# emacs --daemon -f exwm-enable
# exec emacsclient -c
# exec emacs --eval '(exwm-enable)'
# exec i3
exec tdm --xstart
