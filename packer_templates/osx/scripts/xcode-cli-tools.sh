#!/bin/sh

# Get and install Xcode CLI tools
OSX_VERS=$(sw_vers -productVersion | awk -F "." '{print $2}')

# on 10.9+, we can leverage SUS to get the latest CLI tools
# create the placeholder file that's checked by CLI updates' .dist code
# in Apple's SUS catalog
touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

# find the CLI Tools update
[ "$OSX_VERS" -ge 10 ] && PROD=$(softwareupdate -l | grep "Command Line" | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
[ "$OSX_VERS" -eq 9 ] && PROD=$(softwareupdate -l | grep -B 1 "Developer" | head -n 1 | awk -F"*" '{print $2}')

# install it
softwareupdate -i "$PROD" -v
