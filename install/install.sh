#!/bin/bash

CURRENT_DISTRO=""
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$SCRIPT_DIR" || exit 1
cd .. || exit 1

# if repo is not positioned in ~/.dotfiles, exit
if [ "$(pwd)" != "$HOME/.dotfiles" ]; then
	echo "This repo should be cloned in ~/.dotfiles"
	exit 1
fi

if [ ! -f ~/.config ]; then
	echo "Creating ~/.config"
	mkdir ~/.config
fi

install_on_fedora() {
	if [ -z "$1" ]; then
		echo "No package name provided"
		return 1
	fi
	sudo dnf install -y "$1"
}

install_on_ubuntu() {
	if [ -z "$1" ]; then
		echo "No package name provided"
		return 1
	fi
	sudo apt-get install -y "$1"
}

install_on_mac() {
	if [ -z "$1" ]; then
		echo "No package name provided"
		return 1
	fi
	if ! command -v brew &>/dev/null; then
		echo "Homebrew not found. Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
	brew install "$1"
}

install_package() {
	if [ -z "$1" ]; then
		echo "No package name provided"
		return 1
	fi

	# Check if the package is already installed
	if command -v "$1" &>/dev/null; then
		echo "$1 is already installed"
		return 0
	fi

	if [ -z "$CURRENT_DISTRO" ]; then
		OS="$(uname -s)"
		case "${OS}" in
		Linux*)
			if [ -f /etc/fedora-release ]; then
				CURRENT_DISTRO="fedora"
			elif [ -f /etc/lsb-release ]; then
				CURRENT_DISTRO="ubuntu"
			else
				echo "Unsupported Linux distribution"
				exit 1
			fi
			;;
		Darwin*)
			CURRENT_DISTRO="mac"
			;;
		*)
			echo "Unsupported operating system: ${OS}"
			exit 1
			;;
		esac
	fi

	if [ "$CURRENT_DISTRO" = "fedora" ]; then
		install_on_fedora "$1"
	elif [ "$CURRENT_DISTRO" = "ubuntu" ]; then
		install_on_ubuntu "$1"
	elif [ "$CURRENT_DISTRO" = "mac" ]; then
		install_on_mac "$1"
	else
		echo "Unsupported distribution"
		return 1
	fi

}

install_neovim() {
	install_package "neovim ripgrep fd"

	# install nerd-fonts
	if [ $CURRENT_DISTRO == "mac" ]; then
		brew tap homebrew/cask-fonts
		brew install --cask font-meslo-lg-nerd-font
	else
		install_package "font-meslo-lg-nerd-font"
	fi

	if [ -e ~/.config/nvim ]; then
		echo "Backing up existing .config/nvim"
		mv ~/.config/nvim ~/.config/nvim.bak
	fi

	ln -s ./nvim ~/.config/nvim
}

install_tmux() {
	install_package "tmux"
	if [ -e ~/.config/tmux ]; then
		echo "Backing up existing .config/tmux"
		mv ~/.config/tmux ~/.config/tmux.bak
	fi
	ln -s ./tmux ~/.config/tmux
}

install_zsh() {
	install_package "zsh"
	#install oh-my-zsh
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	if [ -e ~/.zshrc ]; then
		echo "Backing up existing .zshrc"
		mv ~/.zshrc ~/.zshrc.bak
	fi
	ln -s ./zsh/.zshrc ~/.zshrc

	chsh -s "$(which zsh)"
}

confirm() {
	read -r -p "$1 [y/N] " response
	case "$response" in
	[yY][eE][sS] | [yY])
		return 0
		;;
	*)
		return 1
		;;
	esac
}

if confirm "Do you want to install zsh?"; then
	install_zsh
fi

if confirm "Do you want to install tmux?"; then
	install_tmux
fi

if confirm "Do you want to install neovim?"; then
	install_neovim
fi

if [ $CURRENT_DISTRO == "mac" ]; then
	if confirm "Do you want to setup system configuration?"; then
		./install/macos.sh
	fi
fi
