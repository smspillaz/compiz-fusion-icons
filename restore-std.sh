#!/bin/bash
GIT="git://anongit.compiz.org/fusion/compizconfig/ccsm"

if (echo $@ | grep -e --help &>/dev/null); then
	echo -e "Options:"
	echo -e " --prefix=PREFIX \t CCSM install prefix eg. /usr/local"
	exit 8
fi

git clone $GIT

if [ ! -z `echo $@ | grep -e --prefix=` ]; then
	PREFIX=`echo $@ | grep -e --prefix= | sed -e s,--prefix=,,`
elif [ -d /usr/share/ccsm/icons/hicolor ]; then
	PREFIX=/usr
elif [ -d /usr/local/share/ccsm/icons/hicolor ]; then
	PREFIX=/usr/local
else
	echo "Can't find prefix, try using the --prefix= option"
fi

for img in `ls ccsm/images/scalable/apps/plugin-*`; do
	install -m 644 ccsm/images/scalable/apps/$img $PREFIX
done

# build icon cahce
echo "* Building gtk icon cache"
gtk-update-icon-cache -t $PREFIX/share/ccsm/icons/hicolor/
exit
