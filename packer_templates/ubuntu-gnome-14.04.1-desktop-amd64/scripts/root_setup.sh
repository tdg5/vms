#!/bin/bash

set -e

# Runs as root after first reboot.

sudo apt-get update -y -q > /dev/null
sudo apt-get -y -q install linux-headers-$(uname -r) build-essential dkms > /dev/null
sudo apt-get -y -q install virtualbox-guest-{dkms,source,utils,x11} > /dev/null

# For VirtualBox, add all sudo users (ie. vagrant) to the vboxsf group too
members(){
    g_line=`getent group "$1"`
    [ -n "$g_line" ] || { echo "No such group $1." >&2 ; return 1 ; }
    getent passwd | awk -F: '$4 == "'`echo "$g_line" | cut -d: -f3`'" { printf("%s ",$1) }'
    echo "$g_line" | cut -d: -f4 | tr , ' '
}

for m in `members sudo` ; do
    usermod -aG vboxsf $m
done
