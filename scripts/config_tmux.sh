#!/bin/bash

echo "[== TMUX ==]"

if [[ $EUID -eq 0 ]]; then
	conf_file="/etc/tmux.conf"
else
	conf_file="$HOME/.tmux.conf"
fi

echo "Create $conf_file file..."
if [ -e $conf_file ]; then
	echo "WARNING: Another configuration file exists ('$conf_file')"
	read -p '> Override? (Y/n)' override
	if ! [[ $override =~ ^[Yy] ]]; then
		echo "Aborting TMUX configuration." 1>&2
		exit 1
	fi
fi
cp tmux/tmux.conf $conf_file

echo "TMUX successfully configurated!"
