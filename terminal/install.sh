#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles/terminal"
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

mkdir -p ~/.config/tmux/plugins/catppuccin
mkdir -p ~/.tmux/plugins/tpm

if [ ! -d ~/.tmux/plugins/tpm/.git ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d ~/.config/tmux/plugins/catppuccin/tmux/.git ]; then
  git clone https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
fi

chsh -s $(which zsh)

mkdir -p "$CONFIG_DIR/tmux" "$CONFIG_DIR/bat" "$CONFIG_DIR/ghostty"

create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/ghostty/config" "$CONFIG_DIR/ghostty/config"
create_symlink "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
create_symlink "$DOTFILES_DIR/tmux.conf" "$CONFIG_DIR/tmux/tmux.conf"
create_symlink "$DOTFILES_DIR/bat/config" "$CONFIG_DIR/bat/config"

echo "Terminal dotfiles installation complete."
