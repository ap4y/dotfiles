#!/usr/bin/env sh

cat bashrc >> ~/.bashrc
cp -R .mutt ~
cp -R .tmux.conf ~
cp -R .Xresources ~
cp -R .xinitrc ~

mkdir ~/.irssi
cp -R scripts ~/.irssi
