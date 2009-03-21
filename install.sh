#!/bin/bash
# Simple script to find prefix and install icons. Use --prefix if you installed CCSM in somewhere other than /usr or /usr/local

if (echo $@ | grep -e --help &>/dev/null); then
	echo -e "Options:"
	echo -e " --tango \t\t Install with the tango theme [default]"
	echo -e " --oxygen \t\t Install with the oxygen theme [incomplete]"
	echo -e " --prefix=PREFIX \t CCSM install prefix eg. /usr/local"
	exit 8
fi

if [ ! -z "`echo $@ | grep -e --prefix=`" ]; then
	PREFIX="`(for a in $@; do echo $a | grep -e --prefix=; done) | sed -e s,--prefix=,,`"
elif [ -d /usr/share/ccsm/icons/hicolor ]; then
	PREFIX=/usr
elif [ -d /usr/local/share/ccsm/icons/hicolor ]; then
	PREFIX=/usr/local
else
	echo "Can't find prefix, try using the --prefix= option"
fi

for app in install gtk-update-icon-cache; do
	if [ ! -f `which $app` ]; then
		echo "Can't find $app"
		echo "Make sure $app is installed and in your \$PATH"
		exit 3
	fi
done 

# install
if (echo $@ | grep -e --oxygen &>/dev/null); then
	LIST=`ls oxygen | grep plugin- | sed 's|plugin-|oxygen/plugin-|'`
else
	LIST=`ls tango | grep plugin- | sed 's|plugin-|tango/plugin-|'`
fi
for myicon in $LIST; do
	echo "* Installing $myicon"
	install -m 644 $myicon $PREFIX/share/ccsm/icons/hicolor/scalable/apps/
done

# build icon cahce
echo "* Building gtk icon cache"
gtk-update-icon-cache -t $PREFIX/share/ccsm/icons/hicolor/
exit
