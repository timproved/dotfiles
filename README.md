# Welcome to my dotfiles

## Introduction

The goal of my workflow is to be able to efficiently execute tasks on my computer.
These dotfiles setup the entire WM Setup on Wayland with some Development Tools and Virtualization.

## Installation

DISCLAIMER: sudo is required, since we are going to edit /etc/environment and /etc/keyd; 
**please inspect the script before you use it**

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
