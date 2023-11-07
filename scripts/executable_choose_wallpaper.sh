cp -f $1 ~/.config/HyprV/backgrounds/background-dark.jpg
sudo cp -f $1 /usr/share/sddm/themes/sdt/wallpaper.jpg
swww img --transition-type wipe $1 --transition-fps 144
sleep 2
wal -c
wal -q -i $1
pkill -USR1 kitty
pkill -USR2 cava
pkill waybar
#waybar &
