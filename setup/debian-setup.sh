#!/usr/bin/env bash

echo "GETTING STARTED" 

sudo apt-get install -y \
    build-essential curl git keepass2 make neovim shellcheck tmux tree xclip \
    zsh
sudo apt-get install -y \
    bat exa fzf htop qutebrowser ranger tldr
sudo apt-get install -y \
    cmus light scrot

# For connecting to linode box
sudo apt-get install -y wireguard

echo "*** SETUP - dropbox"
if [ ! -f "$HOME/.dropbox-dist/dropboxd" ]; then
	echo " ** SETUP - dropbox - downloading dropbox"
	pushd ~
	wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
	.dropbox-dist/dropboxd
	popd
fi

if [ ! -f /usr/local/bin/dropbox.py ]; then
	echo " ** SETUP - dropbox - downloading dropbox.py"
	sudo -s -- <<EOF
  wget https://linux.dropbox.com/packages/dropbox.py -O /usr/local/bin/dropbox.py
	chmod +x /usr/local/bin/dropbox.py
  dropbox start -i
EOF
fi

echo "*** SETUP - ssh"
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
	echo " ** SETUP - ssh - public key not found - generating new key"
	# Generate new SSH keys (will prompt for passphrase)
	ssh-keygen -t ed25519 -C "tsomkes@gmail.com" -f /home/tsomkes/.ssh/id_ed25519
	# Start up ssh-agent
	# (via https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#adding-your-ssh-key-to-the-ssh-agent)
	eval "$(ssh-agent -s)"
	# Add private key to ssh-agent (will prompt for passphrase)
	ssh-add ~/.ssh/id_ed25519
	# Use xclip to grab public key
	xclip -sel clip < "$HOME/.ssh/id_ed25519.pub"
	# Update github's SSH key
	xdg-open https://github.com/settings/keys &
fi

echo "*** SETUP - code"
if [ ! -d "$HOME/code/dotfiles" ]; then
	mkdir -p ~/code
	git clone git@github.com:TSomKes/dotfiles.git ~/code/dotfiles
	# Now that we have our dotfiles, get them in place.
	~/code/dotfiles/create_symlinks.sh -f
fi

echo "*** SETUP - nix"
if [[ ! $(command -v nix) ]]; then
	sh <(curl -L https://nixos.org/nix/install) --daemon
fi
