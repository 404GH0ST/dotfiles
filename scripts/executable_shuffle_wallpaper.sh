#!/bin/bash

wallpaper=$(find ~/Wallpapers/ -name "*.jpg" -o -name "*.png" | shuf -n 1)

# Make the wallpaper persistent after reboot
sed -E -i "s|SET_BG=.*|SET_BG=\"$wallpaper\"|g" ~/.config/HyprV/hyprv.conf

swww img --transition-type wipe $wallpaper --transition-fps 144
wal -c
wal -q -i $wallpaper
pkill -USR1 kitty
pkill -USR2 cava
pkill waybar
waybar &
waybar --config ~/.config/HyprV/waybar/conf/config-bottom.jsonc
