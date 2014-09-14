#!/bin/bash -eux

user='vagrant'

# Create sudoers.d file to enable sudo without password
user_sudoers_file="/etc/sudoers.d/$user"
[ -f $user_sudoers_file ] || echo "$user ALL=NOPASSWD:ALL" | tee $user_sudoers_file 2>&1>/dev/null
$(stat $user_sudoers_file | sed -n '4p' | grep -q 'Access: (0440') || chmod 0440 $user_sudoers_file

ssh_dir=/home/vagrant/.ssh
vagrant_public_key_url='http://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub'
mkdir -p $ssh_dir
wget $vagrant_public_key_url -qO $ssh_dir/authorized_keys
chown -R vagrant:vagrant $ssh_dir
chmod -R go-rwsx $ssh_dir

sudo apt-get update -y -q > /dev/null
sudo apt-get -y -q install linux-headers-$(uname -r) build-essential dkms > /dev/null
sudo apt-get -y -q install virtualbox-guest-{dkms,source,utils} > /dev/null
