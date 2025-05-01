# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Jdtls
export PATH="/home/tim/.local/share/nvim/mason/packages/jdtls/jdtls":$PATH

# npm
export PATH=~/.npm-global/bin:$PATH

# Quarto
export PATH="/opt/quarto-1.6.30/bin/":$PATH

# Zoxide
eval "$(zoxide init zsh)"

# GO
export PATH=$PATH:$HOME/go/bin

# SSH
eval "$(ssh-agent -s)"

# Rust 
export PATH=$PATH:$HOME/.cargo/bin


#Pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"



# Aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias vi="nvim"
alias ls="eza -la"
alias shutdown="shutdown now"
alias cd="z"
alias e="eza -al"
alias tmux="TERM=screen-256color-bce tmux"
alias rdp_server="xfreerdp3 /u:server /p:password /v:11.23.58.100:49974 /size:1920x1080 /dynamic-resolution"



ZSH_THEME="robbyrussell"
# ZSH_THEME="edvardm"

plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
