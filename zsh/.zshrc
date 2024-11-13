# Directories
export DOTFILES=$HOME/.dotfiles

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="passion"

# Import secret environment variables
if [[ -f "$HOME/.secrets/.env" ]]; then
    source "$HOME/.secrets/.env"
fi

plugins=(git colored-man-pages zsh-syntax-highlighting zsh-autosuggestions ssh-agent)

# ssh-agent plugin configuration
zstyle :omz:plugins:ssh-agent identities id_rsa id_github

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source "$ZSH"/oh-my-zsh.sh
source "$DOTFILES"/zsh/aliases.zsh

export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

export PATH="/opt/homebrew/opt/llvm/bin:$HOME:/.cargo/bin:$HOME/.local/bin:$PATH"
