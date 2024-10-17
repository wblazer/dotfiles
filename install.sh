#!/bin/bash

set -e

DOTFILES_DIR="$HOME/.dotfiles"

# Run individual install scripts
bash "$DOTFILES_DIR/terminal/install.sh"
# Add other install scripts as needed, e.g.:
# bash "$DOTFILES_DIR/vim/install.sh"
# bash "$DOTFILES_DIR/git/install.sh"

echo "All installations complete."
