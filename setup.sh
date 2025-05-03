#!/bin/bash

# Things to do:
# 1. Install Packages
# 2. Create symlinks for .config
# 3. KeyD Config
# 4. Install required software: SDK!Man, Pyenv, Rustup
# 5. Starting Deamons
# 6. Install Zoxide, Oh-My-Zsh and TPM
# 7. Install Browser

if ((EUID != 0)); then
    echo "Please run with sudo—this script writes to /etc" >&2
    exit 1
fi

# Exit on error
set -e

# Define home directory
DOTFILES="/home/tim/dotfiles/"
echo "Setting up dotfiles..."

# Create ~/.config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Install required packages
echo "Installing required packages..."
sudo pacman -S --needed base base-devel bluez bluez-utils breeze-icons btop chromium dnsmasq docker docker-compose efibootmgr eza fd firefox freerdp fzf gimp go grim grub i3status keyd kitty libreoffice-fresh libvirt lxappearance man-db mesa neovim obs-studio obsidian os-prober pavucontrol pipewire pipewire-alsa pipewire-jack pipewire-pulse polkit-kde-agent pop-gtk-theme qemu-full qt5-wayland qt5ct ripgrep slurp sway swaybg swaylock swaync swtpm timeshift tmux ttf-fira-code ttf-font-awesome ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols unzip vim virt-manager wl-clipboard wofi xdg-desktop-portal-gtk xdg-desktop-portal-wlr xorg-xwayland yazi zoxide zsh zip

echo "Setting Env Vars for wayland and qt5ct"
echo 'export QT_QPA_PLATFORM="wayland"' | sudo tee -a /etc/environment
echo 'export QT_QPA_PLATFORMTHEME="qt5ct"' | sudo tee -a /etc/environment

echo "Installing keyd config"
sudo mv "$DOTFILES"keyd /etc/.
sudo systemctl enable keyd --now

echo "Installing SDK!Man"
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

echo "Installing Pyenv"
sudo pacman -S --needed base-devel openssl zlib xz tk
curl -fsSL https://pyenv.run | bash
echo 'export PYENV_ROOT="$HOME/.pyenv"' >>~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >>~/.zshrc
echo 'eval "$(pyenv init - zsh)"' >>~/.zshrc

echo "Installing Rustup:"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Enabling libvirtd"
sudo systemctl enable libvirtd.socket --now

echo "Enabling bluetooth"
sudo systemctl enable bluetooth.service --now

# list of top-level items to link
items=(.zshrc .zshenv .ideavimrc .ssh .local)
for item in "${items[@]}"; do
    src="$DOTFILES/$item"
    dest="$HOME/$item"
    # remove existing link/file if present, then create parent dirs as needed
    rm -rf "$dest"
    ln -s "$src" "$dest"
    echo "Linked $dest → $src"
done

# now link every folder inside .config
for cfg in "$DOTFILES"/.config/*; do
    name="$(basename "$cfg")"
    dest="$HOME/.config/$name"
    rm -rf "$dest"
    ln -s "$cfg" "$dest"
    echo "Linked $dest → $cfg"
done

echo "Installing Tmux plugin manager"
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

echo "Installing Zoxide"
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# capture the non-root invoking user
BUILD_USER=${SUDO_USER:-$(whoami)}

echo "Installing paru as $BUILD_USER…"
sudo -u "$BUILD_USER" bash <<EOF
  cd "\$HOME"
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si --noconfirm
EOF

echo "Getting my Browser:"
paru -S zen-browser

echo "Installing Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

exec "$SHELL"
echo "DONE!!!"
