#!/bin/bash -e

sudo apt-get -y -q install virtualbox-guest-x11 > /dev/null

dbus-launch gsettings set org.gnome.desktop.screensaver lock-enabled 'false'
dbus-launch gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend 'false'
dbus-launch gsettings set org.gnome.desktop.session idle-delay 'uint32 0'
