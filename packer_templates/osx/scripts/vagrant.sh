#!/bin/sh
date > /etc/vagrant_box_build_time
OSX_VERS=$(sw_vers -productVersion | awk -F "." '{print $2}')

# Set computer/hostname
COMPNAME=vagrant-osx-10-${OSX_VERS}
scutil --set ComputerName ${COMPNAME}
scutil --set HostName ${COMPNAME}.vagrantup.com

# Installing vagrant keys
mkdir /Users/vagrant/.ssh
chmod 700 /Users/vagrant/.ssh
curl -L 'https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub' > /Users/vagrant/.ssh/authorized_keys
chmod 600 /Users/vagrant/.ssh/authorized_keys
chown -R vagrant /Users/vagrant/.ssh

# Create vagrant group and assign vagrant user to it
dseditgroup -o create vagrant
dseditgroup -o edit -a vagrant vagrant

# Enable autologin for vagrant user
cp /private/tmp/kcpassword /private/etc/kcpassword
/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow autoLoginUser vagrant
