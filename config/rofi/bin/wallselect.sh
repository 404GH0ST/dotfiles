#!/usr/bin/env bash

# Verifies if imagemagick are installed
if ! command -v magick >/dev/null 2>&1; then
	dunstify "Missing package" "Please install the imagemagick package to continue" -u critical
	exit 1
fi

# Set some variables
wall_dir="${HOME}/.config/hypr/images/walls"
cacheDir="${HOME}/.cache/$(whoami)/walls"
rofi_command="rofi -dmenu -theme ${HOME}/.config/rofi/config/wallselect.rasi -theme-str ${rofi_override}"

mon_x_res=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width')
mon_scale=$(hyprctl -j monitors | jq '.[] | select(.focused==true) | .scale' | sed "s/\.//")
mon_x_res=$((mon_x_res * 100 / mon_scale))

rofi_override="element-icon{size:${mon_x_res}px;border-radius:0px;}"

# Create cache dir if not exists
if [ ! -d "${cacheDir}" ]; then
	mkdir -p "${cacheDir}"
fi

# Convert images in directory and save to cache dir
for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
	if [ -f "$imagen" ]; then
		nombre_archivo=$(basename "$imagen")
		if [ ! -f "${cacheDir}/${nombre_archivo}" ]; then
			magick "$imagen" -strip -thumbnail 500x500^ -gravity center -extent 500x500 "${cacheDir}/${nombre_archivo}"
		fi
	fi
done

# Launch rofi
wall_selection=$(find "${wall_dir}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A; do echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n"; done | $rofi_command)

# Set wallpaper
[[ -n "$wall_selection" ]] || exit 1
echo $wall_selection

# Check swww daemon
swww query &>/dev/null
if [ $? -ne 0 ]; then
	swww-daemon --format xrgb &
	swww query && swww restore
fi

swww img "${wall_dir}"/"${wall_selection}" --transition-type outer --transition-duration 2.5 --transition-fps 144 --invert-y --transition-pos "$(hyprctl cursorpos)" &

exit 0
