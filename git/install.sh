#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles/git"
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

ln -s "$DOTFILES_DIR/.gitconfig" "$HOME/"
cp "$DOTFILES_DIR/.gitignore" "$HOME/"

echo "Git dotfiles installation complete."
