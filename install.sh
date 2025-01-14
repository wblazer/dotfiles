#!/bin/bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"

# Run individual install scripts
bash "$DOTFILES_DIR/terminal/install.sh"
bash "$DOTFILES_DIR/zed/install.sh"
bash "$DOTFILES_DIR/git/install.sh"

ln -s "$DOTFILES_DIR/backgrounds" "$HOME/.local/share/backgrounds"

echo "All installations complete."
