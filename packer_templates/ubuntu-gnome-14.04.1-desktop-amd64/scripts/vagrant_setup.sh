#!/bin/bash

set -e

user='vagrant'

# Create sudoers.d file to enable sudo without password
user_sudoers_file="/etc/sudoers.d/$user"
[ -f $user_sudoers_file ] || echo "$user ALL=NOPASSWD:ALL" | tee $user_sudoers_file 2>&1>/dev/null
$(stat $user_sudoers_file | sed -n '4p' | grep -q 'Access: (0440') || chmod 0440 $user_sudoers_file

# Create authorized_keys file from vagrant public key
ssh_dir="/home/$user/.ssh"
authorized_keys_file="$ssh_dir/authorized_keys"
vagrant_public_key_url="https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub"

mkdir -p $ssh_dir
wget $vagrant_public_key_url -qO $authorized_keys_file
chown $user:$user $authorized_keys_file
chmod -R go-rwsx $ssh_dir
