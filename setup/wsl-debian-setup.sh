#!/usr/bin/env bash

echo "GETTING STARTED" 

sudo apt-get update
sudo apt-get install -y \
    build-essential curl git keepass2 lsb-release make neovim shellcheck tmux \
    tree wget xclip zsh
sudo apt-get install -y \
    bat bc btop entr fd-find fzf hyperfine jq qutebrowser ranger ripgrep \
    sd tldr tre-command


sudo apt-get install -y just

# For connecting to linode box
sudo apt-get install -y wireguard

echo "*** SETUP - code"
if [ ! -d "$HOME/code/dotfiles" ]; then
	mkdir -p ~/code
	git clone git@github.com:TSomKes/dotfiles.git ~/code/dotfiles
	# Now that we have our dotfiles, get them in place.
	~/code/dotfiles/create_symlinks.sh -f
fi

#echo "*** SETUP - nix"
#if [[ ! $(command -v nix) ]]; then
#	sh <(curl -L https://nixos.org/nix/install) --daemon
#fi
