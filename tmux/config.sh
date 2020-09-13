#!/bin/bash

if [[ $EUID -eq 0 ]]; then
	conf_file="/etc/tmux.conf"
else
	conf_file="$HOME/.tmux.conf"
fi

if [ -e $conf_file ]; then
	echo "Back up old configuration file..."
	mv -v $conf_file{,.back}
fi

echo "Create $conf_file file..."
cp tmux/tmux.conf $conf_file
