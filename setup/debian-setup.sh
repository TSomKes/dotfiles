#!/usr/bin/env bash

echo "GETTING STARTED" 

sudo apt-get update
sudo apt-get install -y \
    build-essential curl git keepass2 make neovim pandoc shellcheck tmux tree \
    xclip zsh
sudo apt-get install -y \
    bat bc btop entr fd-find fzf hyperfine jq just moreutils ranger \
    rfkill ripgrep rlwrap sd syncthing tldr tre-command wordnet
sudo apt-get install -y \
    foliate qutebrowser
sudo apt-get install -y \
    cmus light scrot

# For notifications (used when putting the pomodoro script in ~/.zshrc)
# (primarily wanted libnotify-bin for access to notify-send, but needed
# notification-daemon to make that work, despite the protests of some posts I
# found. (via multiple sources, but concise here: 
# https://askubuntu.com/questions/1447877/why-do-i-get-gdbus-errororg-freedesktop-dbus-error-serviceunknown-with-notify-s)
sudo apt-get install -y libnotify-bin notification-daemon

# Prerequisite:  pre-MPR setup
sudo apt-get install just

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
if [ ! -f "$HOME/.ssh/id_ed25519.pub" ]; then
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
