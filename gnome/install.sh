#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles/gnome"
CONFIG_DIR="$HOME/.config"

create_symlink() {
  local src="$1"
  local dest="$2"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    read -p "Warning: $dest already exists. Override? [y/N] " answer
    if [[ $answer == [Yy]* ]]; then
      rm -f "$dest" && echo "Removed existing: $dest"
      ln -s "$src" "$dest" && echo "Created symlink: $dest -> $src"
    else
      echo "Skipping $dest..."
    fi
  else
    ln -s "$src" "$dest" && echo "Created symlink: $dest -> $src"
  fi
}

mkdir -p "$CONFIG_DIR/autostart/"

create_symlink "$DOTFILES_DIR/ulauncher.desktop" "$CONFIG_DIR/autostart/ulauncher.desktop"

gtk-launch ulauncher.desktop >/dev/null 2>&1
sleep 2 # ensure enough time for ulauncher to set defaults

mkdir -p "$HOME/.config/ulauncher"
create_symlink "$DOTFILES_DIR/ulauncher.json" "$HOME/.config/ulauncher/settings.json"

echo "GNOME dotfiles installation complete."
