#!/usr/bin/env sh

apt-get update && apt-get upgrade
apt-get install openssh-server openssh-client git kbd locales console-setup tmux ranger mutt irssi

cp tewi-medium-11.psf /usr/share/consolefonts/

dpkg-reconfigure tzdata
dpkg-reconfigure locales
dpkg-reconfigure console-setup

systemctl set-default multi-user.target
systemctl enable ssh.socket

git clone https://github.com/editkid/chip-battery-status.git
cd chip-battery-status
./install.sh
cd .. && rm -rf chip-battery-status

cp tmux-notify /usr/local/bin/
