#!/bin/bash

THEMES=("Gruvbox Material" "Catppuccin Mocha" "Rose Pine Moon" "Gruvbox Light")
THEME_PROPER=$(gum choose "${THEMES[@]}" --header "pick theme")
THEME=$(echo "$THEME_PROPER" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
ZED_THEME="$THEME_PROPER"  # default case
if [ "$THEME_PROPER" = "Rose Pine Moon" ]; then
    ZED_THEME="Rosé Pine Moon"  # force unaccented for files
fi
DOTFILES="$HOME/dotfiles"

if [ -n "$THEME" ]; then
  ### Ghostty
  ln -sf "$DOTFILES/themes/ghostty/$THEME" "$DOTFILES/themes/ghostty/config"

  ### Zed
  # create temp file
  tmp=$(mktemp)

  # set theme
  jq --arg theme "$ZED_THEME" '.theme.dark = $theme' "$DOTFILES/zed/settings.json" > "$DOTFILES/zed/settings.json.new" && mv "$DOTFILES/zed/settings.json.new" "$DOTFILES/zed/settings.json"

  ### Starship
  sed -i "s/^palette = .*/palette = '$THEME'/" "$DOTFILES/terminal/starship.toml"


  ### Neovim
  echo "return { name = \"$NVIM_THEME\" }" > "$DOTFILES/nvim/lua/config/theme.lua"


  ### Helix
  declare -A HELIX_THEMES
  HELIX_THEMES["gruvbox-material"]="gruvbox-material-dark-transparent"
  HELIX_THEMES["catppuccin-mocha"]="catppuccin_mocha_transparent"
  HELIX_THEMES["rose-pine-moon"]="rose_pine_moon"
  HELIX_THEMES["gruvbox-light"]="gruvbox_light"

  HELIX_THEME="${HELIX_THEMES[$THEME]}"
  if [ -n "$HELIX_THEME" ]; then
    sed -i "s/^theme = .*/theme = \"$HELIX_THEME\"/" "$DOTFILES/helix/config.toml"
  else
    echo "Warning: No Helix theme mapping found for $THEME"
  fi
fi
