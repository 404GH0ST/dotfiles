#!/bin/bash

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland

systemctl --user stop pipewire wireplumber xdg-desktop-portal
systemctl --user start wireplumber
obs
