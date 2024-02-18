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
zstyle :omz:plugins:ssh-agent identities ~/.ssh/$SSH_IDENTITIES

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

source "$ZSH"/oh-my-zsh.sh
source "$DOTFILES"/zsh/aliases.zsh

export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
