#!/bin/bash

set -e

# Runs as user after first reboot.

# Prevent virtual screen from locking
dbus-launch gsettings set org.gnome.desktop.screensaver lock-enabled 'false'
dbus-launch gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend 'false'
dbus-launch gsettings set org.gnome.desktop.session idle-delay 'uint32 0'
