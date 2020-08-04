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
xinput set-button-map 'Kensington Expert Mouse' 1 3 1 4 5 6 7 3 9
xinput set-prop 'Kensington Expert Mouse' 'libinput Accel Speed' 1
imwheel -d &

# Load Xresources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Load Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# color profile
xcalib ~/.config/icc/dell_u2515h.icc

# set dpi
xrandr --dpi 117
# xrandr --output DisplayPort-1 --auto --rotate left --output HDMI-A-0 --auto --left-of DisplayPort-1 --primary

# auto lock
xset s blank
xset s 180
xset dpms 0 240 300
xss-lock -- /usr/bin/i3lock -c 3b4252 &

# keyboard layout
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
# setxkbmap -model pc105 -layout us -option grp:win_space_toggle
fcitx &

# notifications
dunst &

# background
~/.fehbg &

session=${1:-exwm}

case $session in
    exwm              ) exec dbus-launch --sh-syntax --exit-with-session emacs --eval '(exwm-enable)';;
    openbox           ) exec dbus-launch --sh-syntax --exit-with-session openbox-session;;
    canvas            )
        sxhkd &
        picom --experimental-backends &
        lbar &
        exec dbus-launch --sh-syntax --exit-with-session /home/ap4y/git/canvas/canvas
        ;;
    # No known session, try to run it as command
    *                 ) exec $1;;
esac
