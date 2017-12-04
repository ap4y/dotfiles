#!/usr/bin/env sh


cat bashrc >> ~/.bashrc
cp -R .mutt ~
cp -R .tmux.conf ~
cp -R .Xresources ~

mkdir ~/.irssi
cp -R scripts ~/.irssi
