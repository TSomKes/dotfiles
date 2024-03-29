#!/bin/bash
#
# I seem to reinstall whatever Linux distro I'm playing with distressingly
# often.  This script just helps with wiring up the dotfiles that live on
# github, so that I can get back to work.

# Find the absolute path of this script
# "Temporarily" cd to this script's location & pwd it into the variable
DOTFILES_ABS_PATH=$(cd `dirname $0` && pwd)

# Look for options listed in given string
# ("fi" means we'll accept -f or -i, etc.)
while getopts ":fhi" opt; do
	case $opt in
		# -f == Force the 
		f)
			FLAG="--force"
		;;
		h)
			echo "  -f 		forces replacement of existing files"
			echo "  -i 		prompt whether to replace existing files"
			echo "  -h 		give this help list"
			exit 1
		;;
		i)
			FLAG="--interactive"
		;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			echo "Try -h for more information." >&2
			exit 1
		;;
	esac
done

ln $FLAG -s $DOTFILES_ABS_PATH/bash_profile ~/.bash_profile
ln $FLAG -s $DOTFILES_ABS_PATH/bashrc ~/.bashrc
ln $FLAG -s $DOTFILES_ABS_PATH/emacs ~/.emacs
ln $FLAG -sn $DOTFILES_ABS_PATH/emacs.d ~/.emacs.d
ln $FLAG -s $DOTFILES_ABS_PATH/gitconfig ~/.gitconfig
ln $FLAG -s $DOTFILES_ABS_PATH/gitignore ~/.gitignore
ln $FLAG -s $DOTFILES_ABS_PATH/gvimrc ~/.gvimrc
ln $FLAG -s $DOTFILES_ABS_PATH/profile ~/.profile
# ln $FLAG -s $DOTFILES_ABS_PATH/spectrwm.conf ~/.spectrwm.conf
# ln $FLAG -s $DOTFILES_ABS_PATH/spectrwm_us.conf ~/.spectrwm_us.conf
ln $FLAG -s $DOTFILES_ABS_PATH/sqliterc ~/.sqliterc
ln $FLAG -s $DOTFILES_ABS_PATH/ssh/config ~/.ssh/config
ln $FLAG -s $DOTFILES_ABS_PATH/tmux.conf ~/.tmux.conf
ln $FLAG -s $DOTFILES_ABS_PATH/todo.conf ~/.todo.cfg
ln $FLAG -sn $DOTFILES_ABS_PATH/vim ~/.vim
ln $FLAG -s $DOTFILES_ABS_PATH/vimrc ~/.vimrc
ln $FLAG -s $DOTFILES_ABS_PATH/xinitrc ~/.xinitrc
ln $FLAG -s $DOTFILES_ABS_PATH/Xresources ~/.Xresources
ln $FLAG -s $DOTFILES_ABS_PATH/zshrc ~/.zshrc
ln $FLAG -s $DOTFILES_ABS_PATH/zshenv ~/.zshenv
ln $FLAG -s $DOTFILES_ABS_PATH/zprofile ~/.zprofile

mkdir -p ~/.config/kitty
ln $FLAG -s $DOTFILES_ABS_PATH/config/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln $FLAG -s $DOTFILES_ABS_PATH/config/lxqt/globalkeyshortcuts.conf ~/.config/lxqt/globalkeyshortcuts.conf

mkdir -p ~/.config/nvim
ln $FLAG -s $DOTFILES_ABS_PATH/config/nvim/init.vim ~/.config/nvim/init.vim

mkdir -p ~/.dwm
ln $FLAG -s $DOTFILES_ABS_PATH/dwm/autostart.sh ~/.dwm/autostart.sh
ln $FLAG -s $DOTFILES_ABS_PATH/dwm/update-dwm-status-bar.sh ~/.dwm/update-dwm-status-bar.sh
