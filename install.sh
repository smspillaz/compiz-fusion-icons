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
# copy
for a in `ls | grep plugin-`; do
    echo "=> Copying $a"
    cp $a $PREFIX/share/ccsm/icons/hicolor/scalable/apps/
done
echo "=> Building gtk icon cache"
gtk-update-icon-cache -t $PREFIX/share/ccsm/icons/hicolor/
exit
