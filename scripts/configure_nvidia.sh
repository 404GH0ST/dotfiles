#!/bin/bash

sudo pacman -S nvidia nvidia-utils libva-nvidia-driver --noconfirm
sudo sed -Ei 's/(GRUB_CMDLINE_LINUX_DEFAULT="[^"]*)"/\1 nvidia_drm.modeset=1"/' /etc/default/grub
sudo sed -Ei 's/(MODULES=\([^\)]*)/\1nvidia nvidia_modeset nvidia_uvm nvidia_drm/' /etc/mkinitcpio.conf
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
sudo sed -Ei 's/(GRUB_CMDLINE_LINUX_DEFAULT="[^"]*)"/\1 nvidia.NVreg_PreserveVideoMemoryAllocations=1`"/' /etc/default/grub

sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo mkinitcpio -P
