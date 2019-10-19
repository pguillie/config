#!/bin/bash

cd `dirname $0`

if ! grep pguillie/config.git .git/config 1>/dev/null 2>&1; then
    echo "ERROR: this script must be executed in its repository"
    exit 1;
fi

if [[ -z $@ ]]; then
    echo "You need to specify at least one program you want to configure:" \
	 $'\n * emacs' \
	 $'\n * tmux'
    read programs
else
    programs=$@
fi

for prog in $programs; do

    if [ $prog == "all" ];then
	for script in ./scripts/*; do
	    $script
	done
    elif [ $prog == "emacs" ]; then
	./scripts/config_emacs.sh
    elif [ $prog == 'tmux' ]; then
	./scripts/config_tmux.sh
    else
	echo "ERROR: No configuration provided for \"$prog\"" 1>&2
    fi
done
