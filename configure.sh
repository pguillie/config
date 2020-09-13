#!/bin/bash

cd `dirname $0`
if ! grep -q "pguillie/config" .git/config; then
    echo "ERROR: this script must be executed in its repository"
    exit 1;
fi

if [[ -z $1 ]];then arg=*;yes=
elif [[ $@ == "-y" ]];then arg=*;yes=t
else arg=$@;yes=t
fi

for a in $arg; do
	if ! [ -d $a ];then
		continue;
	elif ! [ -x $a/config.sh ]; then
		echo 1>&2 "Error: $a: no configuration found"
		continue
	fi
	if [ -z $yes ]; then
		read -p "Configure $a ? [Y/n] " y
		if ! [[ $y =~ ^[Yy] ]]; then
			continue
		fi
	fi
	echo "=== $a ==="
	$a/config.sh
	if [[ $? -eq 0 ]];then
		echo "--- $a successfully configured ---"
	else
		echo "--- $a not configured ---"
	fi
done
