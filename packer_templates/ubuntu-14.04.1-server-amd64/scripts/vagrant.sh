#!/bin/bash -eux

user='vagrant'
user_sudoers_file="/etc/sudoers.d/$user"
user_ssh_dir="/home/$user/.ssh"
vagrant_public_key_url='http://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub'

# Create sudoers.d file to enable sudo without password
[ -f $user_sudoers_file ] || echo "$user ALL=NOPASSWD:ALL" | tee $user_sudoers_file 2>&1>/dev/null
$(stat $user_sudoers_file | sed -n '4p' | grep -q 'Access: (0440') || chmod 0440 $user_sudoers_file

mkdir -p $user_ssh_dir
wget $vagrant_public_key_url -qO $user_ssh_dir/authorized_keys
chown -R vagrant:vagrant $user_ssh_dir
chmod -R go-rwsx $user_ssh_dir

apt-get update -y -q > /dev/null
apt-get -q -y install linux-headers-$(uname -r) build-essential dkms > /dev/null
apt-get -q -y install virtualbox-guest-{dkms,source,utils} > /dev/null

# Chef and requirements
apt-get -q -y install curl > /dev/null
curl -L https://www.opscode.com/chef/install.sh | bash > /dev/null
