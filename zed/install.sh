#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles/zed"
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

mkdir -p "$CONFIG_DIR/zed"
create_symlink "$DOTFILES_DIR/keymap.json" "$CONFIG_DIR/zed/keymap.json"
create_symlink "$DOTFILES_DIR/settings.json" "$CONFIG_DIR/zed/settings.json"
create_symlink "$DOTFILES_DIR/tasks.json" "$CONFIG_DIR/zed/tasks.json"

echo "Zed dotfiles installation complete."
