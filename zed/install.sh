#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles/zed/"
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

mkdir -p "$CONFIG_DIR/zed"
create_symlink $DOTFILES_DIR/keymap.json $CONFIG_DIR/zed/keymap.json
create_symlink $DOTFILES_DIR/settings.json $CONFIG_DIR/zed/settings.json

echo "Zed dotfiles installation complete."
