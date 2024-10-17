#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles/gnome"
CONFIG_DIR="$HOME/.config"

create_symlink() {
    local src="$1"
    local dest="$2"
    if [ -e "$dest" ]; then
        echo "Warning: $dest already exists. Skipping..."
    else
        ln -s "$src" "$dest" && echo "Created symlink: $dest -> $src"
    fi
}

mkdir -p "$CONFIG_DIR/autostart/"
cp ~/.dotfiles/gnome/ulauncher.desktop ~/.config/autostart/ulauncher.desktop

gtk-launch ulauncher.desktop >/dev/null 2>&1
sleep 2 # ensure enough time for ulauncher to set defaults

cp ~/.dotfiles/gnome/ulauncher.json ~/.config/ulauncher/settings.json

echo "GNOME dotfiles installation complete."
