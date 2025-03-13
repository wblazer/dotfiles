#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles/git"
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

create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
cp "$DOTFILES_DIR/.gitignore" "$HOME/.gitignore"

echo "Git dotfiles installation complete."
