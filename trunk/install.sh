#!/bin/bash
# Simple script to find prefix and install icons. Use --prefix if you installed CCSM in somewhere other than /usr or /usr/local

INSTALL_TYPE='tango'

while [[ $1 != "" ]]; do
	case $1 in
		--help)
			echo -e "Options:"
			echo -e " --tango \t\t Install with the tango theme [default]"
			echo -e " --oxygen \t\t Install with the oxygen theme [incomplete]"
			echo -e " --prefix=PREFIX \t CCSM install prefix eg. /usr/local"
			exit 8
			;;
		--prefix=*)
			PREFIX=$(sed s/--prefix=// <<<$1)
			;;
		--oxygen)
			INSTALL_TYPE='oxygen'
			;;
		*)
			echo "Unknown option $1"
			;;
	esac
	shift
done

if [[ $PREFIX == "" ]]; then
	if [[ -d /usr/share/ccsm/icons/hicolor ]]; then
		PREFIX=/usr
	elif [[ -d /usr/local/share/ccsm/icons/hicolor ]]; then
		PREFIX=/usr/local
	else
		echo "Can't find prefix, try using the --prefix= option"
	fi
fi

for app in install gtk-update-icon-cache; do
	if ! which $app &>/dev/null; then
		echo "Can't find $app"
		echo "Make sure $app is installed and in your \$PATH"
		exit 3
	fi
done 

# install
if [[ $INSTALL_TYPE == 'oxygen' ]]; then
	LIST=$(printf "%s\n" oxygen/* | grep 'oxygen/plugin-')
else
	LIST=$(printf "%s\n" tango/* | grep 'tango/plugin-')
fi
for myicon in $LIST; do
	echo "* Installing $myicon"
	install -m 644 $myicon $PREFIX/share/ccsm/icons/hicolor/scalable/apps/
done

# build icon cahce
echo "* Building gtk icon cache"
gtk-update-icon-cache -t $PREFIX/share/ccsm/icons/hicolor/
exit
