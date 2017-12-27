#!/usr/bin/env sh

apt-get update -y && apt-get upgrade -y
apt-get install -y openssh-server openssh-client git kbd locales console-setup tmux \
        ranger mutt irssi firmware-realtek crda apt-transport-https xterm
apt-get remove -y network-manager lightdm awesome pocket-wm xfce4-session
apt-get autoremove

cp tewi-medium-11.psf /usr/share/consolefonts/

dpkg-reconfigure tzdata
dpkg-reconfigure locales
dpkg-reconfigure console-setup

systemctl set-default multi-user.target
systemctl enable ssh.

git clone https://github.com/editkid/chip-battery-status.git
cd chip-battery-status
./install.sh
cd .. && rm -rf chip-battery-status

cp tmux-notify /usr/local/bin/

echo 'FONT=tewi-medium-11.psf' >> /etc/default/console-setup

loadkeys pocketchip.kmap
keydump > keydump.kmap
mv keydump.kmap /usr/share/keymaps/pocketchip.kmap

echo "/dev/mtdblock3 0 0x400000 0x4000" | sudo tee -a /etc/fw_env.config
fw_setenv bootargs 'root=ubi0:rootfs rootfstype=ubifs rw ubi.mtd=4 quiet lpj=501248 loglevel=3'

systemctl disable pocketchip-warn15.timer
systemctl disable pocketchip-warn05.timer
systemctl disable pocketchip-off00.timer
systemctl disable pocketchip-batt.timer
