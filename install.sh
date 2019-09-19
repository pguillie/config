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

    read -p 'Do you need the 42 header? (Y/n)' header

    echo "[+] Create $home/.emacs file"
    if [ -e $home/.emacs ]; then
	echo "[!] Another configuration file exists ($home/.emacs)"
	read -p 'Override? (Y/n)' override
	if ! [[ $override =~ ^[Yy] ]]; then
	    echo "[-] Aborting EMACS configuration" 1>&2
	    return
	fi
    fi
    cp emacs/dotemacs $home/.emacs

    echo "[+] Create $home/.emacs.d/init directory"
    if ! [ -d $home/.emacs.d ]; then
	mkdir $home/.emacs.d
    fi
    cp -r emacs/emacs.d/init $home/.emacs.d

    echo "[+] Create $home/.emacs.d/42-header directory"
    if [[ $header =~ ^[Yy] ]]; then
	cp -r emacs/emacs.d/42-header $home/.emacs.d
    fi

    echo "[*] EMACS successfully configurated!"
}

function set_tmux
{
    if [[ $EUID -eq 0 ]]; then
	conf_file="/etc/tmux.conf"
    else
	conf_file="$HOME/.tmux.conf"
    fi

    echo "[+] Create $conf_file file"
    if [ -e $conf_file ]; then
	echo "[!] Another configuration file exists ('$conf_file')"
	read -p 'Override? (Y/n)' override
	if ! [[ $override =~ ^[Yy] ]]; then
	    echo "[-] Aborting TMUX configuration" 1>&2
	    return
	fi
    fi
    cp tmux/tmux.conf $conf_file

    echo "[*] TMUX successfully configurated!"
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
