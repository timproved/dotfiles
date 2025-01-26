#!/bin/bash

# Exit on error
set -e

# Define home directory
HOME_DIR="/home/tim"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up dotfiles..."

# Create ~/.config directory if it doesn't exist
mkdir -p "$HOME_DIR/.config"

# Install required packages
echo "Installing required packages..."
sudo pacman -S --needed keyd zsh tmux kitty wofi zoxide fzf fd

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"

    if [ -e "$target" ] || [ -L "$target" ]; then
        echo "Removing existing: $target"
        rm -rf "$target"
    fi

    echo "Creating symlink: $source -> $target"
    ln -s "$source" "$target"
}

# Symlink files in home directory
create_symlink "$SCRIPT_DIR/.zshrc" "$HOME_DIR/.zshrc"
create_symlink "$SCRIPT_DIR/.zshenv" "$HOME_DIR/.zshenv"
create_symlink "$SCRIPT_DIR/.ideavimrc" "$HOME_DIR/.ideavimrc"
create_symlink "$SCRIPT_DIR/.local/bin/scripts" "$HOME_DIR/.local/bin"

# Symlink .config directories
for config_dir in "$SCRIPT_DIR/.config"/*; do
    if [ -d "$config_dir" ]; then
        dir_name=$(basename "$config_dir")
        create_symlink "$config_dir" "$HOME_DIR/.config/$dir_name"
    fi
done

# Setup keyd
echo "Setting up keyd..."
sudo mkdir -p /etc/keyd
sudo cp "$SCRIPT_DIR/keyd/default.conf" /etc/keyd/default.conf
sudo cp "$SCRIPT_DIR/keyd/moonlander.conf" /etc/keyd/moonlander.conf
sudo systemctl enable keyd --now

# Set zsh as default shell if not already
if [[ $SHELL != "/usr/bin/zsh" ]]; then
    chsh -s /usr/bin/zsh
fi

echo "Setup completed successfully!"
