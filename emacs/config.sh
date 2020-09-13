#!/bin/bash

if [[ $EUID -eq 0 ]]; then
	echo "Enter the home directory of the user" \
	     "you want to have emacs configurated"
	read home
else
	home=$HOME
fi

if [ -e $home/.emacs -o -d $home/.emacs.d ]; then
	echo "Back up old configuration..."
	if [ -e $home/.emacs ]; then
		mv -v $home/.emacs{,.back}
	fi
	if [ -e $home/.emacs.d ]; then
		rm -rf $home/.emacs.d.back
		mv -v $home/.emacs.d{,.back}
	fi
fi

echo "Create $home/.emacs.d directory..."
if ! (mkdir $home/.emacs.d && cp -r emacs/init* $home/.emacs.d/); then exit $?; fi

read -p '> Enter your login for the 42 Header (leave blank to disable): ' login
if [[ -n $login ]]; then
	echo "Create $home/.emacs.d/42-header directory..."
	cp -r emacs/42-header $home/.emacs.d \
		&& mv $home/.emacs.d/{42-header,init}/42-header.el
	echo '(load "42-header.el")' >> $home/.emacs.d/init.el
	echo "(set 'user-login \"$login\")" >> $home/.emacs.d/init/42-header.el
	echo "(set 'user-mail \"$login@student.42.fr\")" \
	     >> $home/.emacs.d/init/42-header.el
fi
