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

# set dpi
xrandr --dpi 117
xrandr --output DisplayPort-1 --auto --rotate left --output HDMI-A-0 --auto --left-of DisplayPort-1 --primary

# Background
sh ~/.fehbg

# auto lock
xautolock -detectsleep -secure -noclose \
          -time 5 -locker 'pkill -9 scdaemon; i3lock-fancy -n -- scrot -z' \
          -killtime 10 -killer 'sudo zzz; pasuspender /bin/true' &

# keyboard layout
setxkbmap -model pc105 -layout us,ru -option grp:win_space_toggle

# start mail fetcher
# mail &

# start mpd
mpd &

# exec emacs --eval '(exwm-enable)'
# exec i3
exec tdm --xstart
