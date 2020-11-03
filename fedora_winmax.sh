#!/usr/bin/env bash

# create firmware file for screen and move to grub
sudo mkdir /lib/firmware/edid
base64 --decode /home/%user%/gpdwinlinux/winmaxscreen.txt > /lib/firmware/edid/gpdwinmax.bin
# GRUB_CMDLINE_LINUX="video=eDP-1:800x1280 drm.edid_firmware=eDP-1:edid/gpdwinmax.bin fbcon=rotate:1" add this to /etc/default/grub
# sudo grub2-mkconfig -o /boot/efi/EFI/fedora/grub.cfg

# gnome settings
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

# enable rpmfusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -yq

sudo dnf groupupdate core -yq

# install some basic stuff to get gaming
sudo dnf install steam lutris zsh vim gamemode -yq

# add flathub and retroarch
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install --user flathub org.libretro.RetroArch

# add third party software

# add Proton Updater from COPR
sudo dnf copr enable david35mm/ProtonUpdater -yq
sudo dnf install ProtonUpdater -yq

# update repositories

sudo dnf check-update -yq

# upgrade packages
sudo dnf upgrade -yq
sudo dnf autoremove -yq 