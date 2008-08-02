#!/bin/bash
# Simple script to find prefix and install icons. Use --prefix if you installed CCSM in somewhere other than /usr or /usr/local

if [ ! -z `echo $@ | grep -e --prefix=` ]; then
	PREFIX=`echo $@ | grep -e --prefix= | sed -e s,--prefix=,,`
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
for myicon in `ls | grep plugin-`; do
	echo "* Installing $myicon"
	install -m 644 $myicon $PREFIX/share/ccsm/icons/hicolor/scalable/apps/
done

# build icon cahce
echo "* Building gtk icon cache"
gtk-update-icon-cache -t $PREFIX/share/ccsm/icons/hicolor/
exit
