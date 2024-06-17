#!/bin/env bash

adjust_sound() {
	pamixer $1 5 && dunstify -h int:value:"$(pamixer --get-volume)" -i $HOME/.config/dunst/assets/volume.svg -t 500 -r 2503 "Volume: $(pamixer --get-volume) %"
}

mute() {
	pamixer -t && dunstify -i $HOME/.config/dunst/assets/$(pamixer --get-mute | grep -q "true" && echo "volume-mute.svg" || echo "volume.svg") -t 500 -r 2503 "Toggle Mute"
}

case $1 in
i)
	adjust_sound "-i"
	;;
d)
	adjust_sound "-d"
	;;
m)
	mute
	;;
esac
