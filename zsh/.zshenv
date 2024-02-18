# Directories
export DOTFILES=$HOME/.dotfiles

# Editor
VIM="nvim"
export EDITOR=$VIM
export VISUAL=$VIM

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="passion"

# Import secret environment variables
if [[ -f "$HOME/.secrets/.env" ]]; then
  source "$HOME/.secrets/.env"
fi
