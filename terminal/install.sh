#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles/terminal"
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

mkdir -p ~/.config/tmux/plugins/catppuccin
git clone https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

mkdir -p "$CONFIG_DIR/alacritty" "$CONFIG_DIR/tmux"

create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"
create_symlink "$DOTFILES_DIR/alacritty.toml" "$CONFIG_DIR/alacritty/alacritty.toml"
create_symlink "$DOTFILES_DIR/tmux.conf" "$CONFIG_DIR/tmux/tmux.conf"

echo "Terminal dotfiles installation complete."
