#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

session=${1:-canvas}

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/*; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# Load Xresources
[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources

# Load Xmodmap
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

# Fonts
xset +fp /home/ap4y/.fonts
xset fp rehash

# auto lock
xset s blank
xset s 180
xset dpms 0 240 300

if [ "$(hostname)" = "ap4y-laptop" ]; then
	xrandr --dpi 120
	xinput set-prop 13 "libinput Tapping Enabled" 1
	xinput set-prop 13 "libinput Natural Scrolling Enabled" 1
	xbacklight -set 20
elif [ "$session" != "game" ]; then
	# Mouse Acceleration Settings
	xinput set-button-map 'Kensington Expert Mouse' 1 3 1 4 5 6 7 3 9
	xinput set-prop 'Kensington Expert Mouse' 'libinput Accel Speed' 1
	imwheel -d &

	# color profile
	xcalib ~/.config/color/icc/aoc_cu34.icc

	# X settings
	xrandr --output DP-2 --mode 3440x1440 --rate 144
	xss-lock -- /bin/betterlockscreen -l blur &

	# keyboard layout
	export GTK_IM_MODULE=fcitx
	export QT_IM_MODULE=fcitx
	export XMODIFIERS=@im=fcitx
	# setxkbmap -model pc105 -layout us -option grp:win_space_toggle
	fcitx &
fi

# notifications
dunst &

# background
~/.fehbg &
mail &

case $session in
exwm) exec emacs --eval '(exwm-enable)' ;;
openbox) exec openbox ;;
canvas)
	sxhkd &
	picom --experimental-backends &
	lbar &
	exec /home/ap4y/git/canvas/canvas
	;;
game)
	xrandr --output HDMI-0 --mode 3840x2160 --rate 60 --scale 0.5
	exec openbox ;;
# No known session, try to run it as command
*) exec "$1" ;;
esac
