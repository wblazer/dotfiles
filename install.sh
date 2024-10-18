#!/bin/bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"

# Run individual install scripts
bash "$DOTFILES_DIR/terminal/install.sh"
bash "$DOTFILES_DIR/zed/install.sh"
bash "$DOTFILES_DIR/git/install.sh"

echo "All installations complete."
