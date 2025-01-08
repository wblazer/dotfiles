#!/bin/bash

THEMES=("Gruvbox Material" "Catppuccin")
THEME=$(gum choose "${THEMES[@]}" --header "Choose your theme" --height 10 | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
DOTFILES="$HOME/.dotfiles" # adjust path as needed

if [ -n "$THEME" ] && [ "$THEME" != "<<-back" ]; then
  ln -sf "$DOTFILES/themes/ghostty/$THEME" "$DOTFILES/themes/ghostty/config"
fi
