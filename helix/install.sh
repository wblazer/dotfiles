#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles/helix"
CONFIG_DIR="$HOME/.config/helix"

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

mkdir -p "$CONFIG_DIR"

create_symlink "$DOTFILES_DIR/config.toml" "$CONFIG_DIR/config.toml"

echo "Helix dotfiles installation complete."
