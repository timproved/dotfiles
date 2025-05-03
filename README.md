# Welcome to my dotfiles

## Introduction

The goal of my workflow is to be able to efficiently execute tasks on my computer.
The heart of my workflow is a combination of:

- A window manager to organize different workspaces - Tmux, a terminal multiplexer to quickly switch between different tasks
- Neovim to make edits to files and navigate quickly through a project

## Installation

```bash
sudo ./setup.sh
```


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
