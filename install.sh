#!/bin/bash

function set_emacs
{
	if [[ $EUID -eq 0 ]]; then
		echo "Enter the HOME directory of the user" \
		     "you want to have EMACS configurated"
		read home
	else
		home=$HOME
	fi

	read -p 'Do you need the 42 configuration? (Y/n)' 42

	if [ -e $home/.emacs ]; then
		echo "WARNING: Another configuration file exists ($home/.emacs)"
		read -p 'Override? (Y/n)' override
		if ! [[ $override =~ ^[Yy] ]]; then
			echo "[-] Aborting EMACS configuration" 1>&2
			return
		fi
	fi
	#...
}

function set_tmux
{
	if [[ $EUID -eq 0 ]]; then
		conf_file="/etc/tmux.conf"
	else
		conf_file="$HOME/.tmux.conf"
	fi

	if [ -e $conf_file ]; then
		echo "WARNING: Another configuration file exists ('$conf_file')"
		read -p 'Override? (Y/n)' override
		if ! [[ $override =~ ^[Yy] ]]; then
			echo "[-] Aborting TMUX configuration" 1>&2
			return
		fi
	fi
	cp tmux/tmux.conf $conf_file
	echo "[+] TMUX successfully configurated in $conf_file"
}

if [[ -n $@ ]]; then
	argv="$@"
else
	argv="emacs tmux"
fi

for arg in $argv; do
	echo "[== ${arg^^} ==]"
	if [ $arg == "emacs" ]; then
		set_emacs
	elif [ $arg == 'tmux' ]; then
		set_tmux
	else
		echo "ERROR: No configuration provided for \"$arg\"" 1>&2
	fi
done
