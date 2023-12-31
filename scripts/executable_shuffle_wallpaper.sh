#!/bin/bash

wallpaper=$(find ~/Wallpapers/ -name "*.jpg" -o -name "*.png" | shuf -n 1)

# Make the wallpaper persistent after reboot
sed -E -i "s|SET_BG=.*|SET_BG=\"$wallpaper\"|g" ~/.config/HyprV/hyprv.conf

cp -f $wallpaper ~/.config/HyprV/backgrounds/background-dark.jpg
sudo cp -f $wallpaper /usr/share/sddm/themes/sdt/wallpaper.jpg

swww img --transition-type wipe $wallpaper --transition-fps 144
sleep 2
wal -c
wal -q -i $wallpaper
pkill -USR1 kitty
pkill -USR2 cava
killall -SIGUSR2 waybar
#waybar &

# Bottom waybar disabled for now
# waybar --config ~/.config/HyprV/waybar/conf/config-bottom.jsonc
