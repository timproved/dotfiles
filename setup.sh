#!/bin/bash

# Set the directory containing the dotfiles and the list of packages
DOTFILES_DIR="$HOME/dotfiles"
PACKAGE_LIST="$DOTFILES_DIR/packageList.txt"

create_symlinks() {
    echo "Creating symlinks for dotfiles..."
    ln -sfn "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    ln -sfn "$DOTFILES_DIR/.config/tmux" "$HOME/.config/tmux"
    ln -sfn "$DOTFILES_DIR/.config/sway" "$HOME/.config/sway"
    ln -sfn "$DOTFILES_DIR/.config/swaylock" "$HOME/.config/swaylock"
    ln -sfn "$DOTFILES_DIR/.config/waybar" "$HOME/.config/waybar"

    # Prompt for terminal choice
    echo "Which terminal are you using?"
    echo "1) Alacritty"
    echo "2) Kitty"
    echo "3) WezTerm"
    read -rp "Enter the number corresponding to your terminal: " terminal_choice

    # Set the correct terminal dotfiles directory based on the choice
    case $terminal_choice in
    1)
        TERMINAL="alacritty"
        ln -sfn "$DOTFILES_DIR/.config/alacritty" "$HOME/.config/alacritty"
        ;;
    2)
        TERMINAL="kitty"
        ln -sfn "$DOTFILES_DIR/.config/kitty" "$HOME/.config/kitty"
        ;;
    3)
        TERMINAL="wezterm"
        ln -sfn "$DOTFILES_DIR/.config/wezterm" "$HOME/.config/wezterm"
        ;;
    *)
        echo "Invalid choice! Exiting."
        exit 1
        ;;
    esac

}

# Function to install packages
install_packages() {
    echo "Installing packages from packageList.txt..."

    if [ -f "$PACKAGE_LIST" ]; then
        # Install packages from packageList.txt
        sudo pacman -S neovim tmux git make unzip alacritty fzf ripgrep zsh
        sudo pacman -S gcc npm rust ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-fira-sans ttf-font-awesome fd
        sudo pacman -S --needed - <"$PACKAGE_LIST"
    else
        echo "Error: packageList.txt not found!"
        exit 1
    fi
}

# Function to source .zshrc
source_zshrc() {
    if [ -f "$HOME/.zshrc" ]; then
        echo "Sourcing .zshrc..."
        source "$HOME/.zshrc"
    else
        echo "Error: .zshrc not found!"
    fi
}

# Additional tools setup
install_additional_tools() {
    echo "Installing additional tools..."

    # Clone TPM for Tmux
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

    # Install zoxide
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

    # Install Oh My Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # Clone zsh-autosuggestions plugin
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

    # Clone fast-syntax-highlighting plugin
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting

    echo "Additional tools installation completed!"
}

# Main script execution
install_packages
install_additional_tools
create_symlinks
source_zshrc

echo "Setup completed!"
