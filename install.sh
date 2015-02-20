#!/usr/bin/env bash

packages=( bash tmux xorg config emacs vim weechat others )
for package in "${packages[@]}"
do
    stow $package
done
