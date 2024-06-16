#!/usr/bin/env bash

vars=$(dirname "$0")
source "${vars}"/vars.sh

sudo tar xzf $repo_dir/misc/grub/catppuccin-mocha-grub-theme.tar.gz --directory /usr/share/grub/themes
sudo sed -i 's|#GRUB_THEME=".*"|GRUB_THEME="/usr/share/grub/themes/catppuccin-mocha-grub-theme/theme.txt"|' /etc/default/grub
sudo sed -i '/^#.*OS_PROBER=\w/s/^#//' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg
