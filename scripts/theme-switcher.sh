#!/bin/bash

THEMES=("Gruvbox Material" "Catppuccin Mocha" "Rose Pine Moon")
THEME_PROPER=$(gum choose "${THEMES[@]}" --header "pick theme")
THEME=$(echo "$THEME_PROPER" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
ZED_THEME="$THEME_PROPER"  # default case
if [ "$THEME_PROPER" = "Rose Pine Moon" ]; then
    ZED_THEME="Rosé Pine Moon"  # force unaccented for files
fi
DOTFILES="$HOME/.dotfiles"

if [ -n "$THEME" ]; then
  ### Ghostty
  ln -sf "$DOTFILES/themes/ghostty/$THEME" "$DOTFILES/themes/ghostty/config"

  ### Zed
  # create temp file
  tmp=$(mktemp)

  # set theme
  jq --arg theme "$ZED_THEME" '.theme.dark = $theme' "$DOTFILES/zed/settings.json" >"$tmp"

  # apply overrides if they exist
  OVERRIDE_PATH="$DOTFILES/themes/zed/$THEME.json"
  if [ -f "$OVERRIDE_PATH" ]; then
    overrides=$(jq -r '.["experimental.theme_overrides"]' "$OVERRIDE_PATH")
    jq --argjson overrides "$overrides" '.["experimental.theme_overrides"] = $overrides' "$tmp" >"$tmp.2" && mv "$tmp.2" "$tmp"
  else
    echo "no zed theme overrides found"
    jq 'del(.["experimental.theme_overrides"])' "$tmp" >"$tmp.2" && mv "$tmp.2" "$tmp"
  fi

  # move temp file back
  mv "$tmp" "$DOTFILES/zed/settings.json"

  STARSHIP_THEME=$(echo "$THEME_PROPER" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
  sed -i "s/^palette = .*/palette = '$STARSHIP_THEME'/" "$DOTFILES/terminal/starship.toml"
fi
