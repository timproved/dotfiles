# Welcome to my dotfiles

## Introduction

The goal of my workflow is to be able to efficiently execute tasks on my computer.
The heart of my workflow is a combination of:

- A window manager to organize different workspaces - Tmux, a terminal multiplexer to quickly switch between different tasks
- Neovim to make edits to files and navigate quickly through a project

## Installation

### Install External Dependencies

Base Packages:

```sh
sudo pacman -S neovim tmux git make unzip alacritty fzf ripgrep zsh
```

External Requirements:

```sh
sudo pacman -S gcc npm rust ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-fira-sans ttf-font-awesome fd
```

- TMUX Plugin Manager

```sh
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Stuff you'd might like:

- Zoxide:

```sh
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

- Oh My Zsh:

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

- Oh My Zsh Autosuggestions`

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

- Oh My Zsh Syntax Highlight

```sh
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
```

-

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
current plugin status. Hit `q` to close the window.

#### Windows Installation

1. install [chocolatey](https://chocolatey.org/install)
   either follow the instructions on the page or use winget,
   run in cmd as **admin**:

```
winget install --accept-source-agreements chocolatey.chocolatey
```

2. install all requirements using choco, exit previous cmd and
   open a new one so that choco path is set, and run in cmd as **admin**:

```
choco install -y neovim git ripgrep wget fd unzip gzip mingw make
```
