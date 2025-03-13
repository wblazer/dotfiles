#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles/tools"
TOOLS_DIR="$HOME/tools"

# Check if script is run from the correct directory
if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Error: $DOTFILES_DIR not found. Make sure you're running this from your home directory."
  exit 1
fi

# Create tools directory if it doesn't exist
mkdir -p "$TOOLS_DIR"

create_symlink() {
  local src="$1"
  local dest="$2"
  # Remove .sh extension for the target to make commands cleaner
  local clean_dest="${dest%.sh}"

  if [ -e "$clean_dest" ] || [ -L "$clean_dest" ]; then
    read -p "Warning: $clean_dest already exists. Override? [y/N] " answer
    if [[ $answer == [Yy]* ]]; then
      rm -f "$clean_dest" && echo "Removed existing: $clean_dest"
      ln -s "$src" "$clean_dest" && echo "Created symlink: $clean_dest -> $src"
    else
      echo "Skipping $clean_dest..."
    fi
  else
    ln -s "$src" "$clean_dest" && echo "Created symlink: $clean_dest -> $src"
  fi

  # Make the target executable
  chmod +x "$clean_dest"
}

# Create symlinks for all .sh files in the tools directory
for script in "$DOTFILES_DIR"/*.sh; do
  if [ -f "$script" ]; then
    script_name=$(basename "$script")
    create_symlink "$script" "$TOOLS_DIR/$script_name"
  fi
done

echo "Tools installation complete. You may need to restart your terminal or run 'source ~/.bashrc' (or ~/.zshrc) to update your PATH."
