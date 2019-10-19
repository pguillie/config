#!/bin/bash

echo "[== EMACS ==]"

if [[ $EUID -eq 0 ]]; then
	echo "Enter the HOME directory of the user" \
	     "you want to have EMACS configurated"
	read home
else
	home=$HOME
fi

echo "Create $home/.emacs file..."
if [ -e $home/.emacs ]; then
	echo "WARNING: Another configuration file exists ($home/.emacs)"
	read -p '> Override? (Y/n)' override
	if ! [[ $override =~ ^[Yy] ]]; then
		echo "Aborting EMACS configuration." 1>&2
		exit 1
	fi
fi
cp emacs/dotemacs $home/.emacs

if ! [ -d $home/.emacs.d ]; then
	mkdir $home/.emacs.d
fi
echo "Create $home/.emacs.d/init directory..."
cp -r emacs/emacs.d/init $home/.emacs.d

read -p '> Do you want to install the 42 header? (Y/n)' header
if [[ $header =~ ^[Yy] ]]; then
	read -p '> Enter your 42 login: ' login
	echo "Create $home/.emacs.d/42-header directory..."
	cp -r emacs/emacs.d/42-header $home/.emacs.d
	echo '(load "42-header.el")' >> $home/.emacs
	echo "(set 'user-login \"$login\")" >> $home/.emacs.d/init/42-header.el
	echo "(set 'user-mail \"$login@student.42.fr\")" \
	     >> $home/.emacs.d/init/42-header.el
fi

echo "EMACS successfully configurated!"
