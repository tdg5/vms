set -x

# Create the home directory
user=vagrant
home_dir="/home/$user"
mkdir -p $home_dir
chown $user $home_dir

# Create the build directory
build_dir="$home_dir/build"
mkdir -p $build_dir
cd $build_dir

# Create the .ssh directory
ssh_dir="$home_dir/.ssh"
mkdir -p $ssh_dir
chmod 700 $ssh_dir

# Create authorized_keys file from vagrant public key
vagrant_public_key_url='https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub'
authorized_keys_file="$ssh_dir/authorized_keys"
wget $vagrant_public_key_url -qO $authorized_keys_file
chmod 0600 $authorized_keys_file

# Ensure correct ownership of ssh config directory
chown -R $user $ssh_dir

# Disable UAC
regedit -IC /disk/Windows/System32/config/SOFTWARE HKEY_LOCAL_MACHINE\\SOFTWARE /cygdrive/a/deuac.reg

# Disable password expiration for user
wmic USERACCOUNT WHERE "Name='$user'" set PasswordExpires=FALSE

# Install apt-get like package manager for cygwin
wget http://apt-cyg.googlecode.com/svn/trunk/apt-cyg
chmod +x apt-cyg
mv apt-cyg /usr/local/bin/

# Install 7zip to allow extract files from the Guest Additions ISO
wget http://downloads.sourceforge.net/sevenzip/7z922-x64.msi
msiexec /qb /i 7z922-x64.msi

cd /
vbox_version=`cat .vbox_version`
ga_iso="VBoxGuestAdditions_${vbox_version}.iso"
ga_iso_path="/$ga_iso"
for artifact in cert VBoxWindowsAdditions-amd64.exe; do
  /cygdrive/c/Program\ Files/7-Zip/7z.exe x $ga_iso $artifact
  mv $artifact $build_dir
done

# Certify Oracle as a trusted installer
cd $build_dir/cert
./VBoxCertUtil.exe add-trusted-publisher oracle-vbox.cer --root oracle-vbox.cer
cd $build_dir

# Install Guest Additions
./VBoxWindowsAdditions-amd64.exe /S

# Install chef
curl -L http://www.opscode.com/chef/install.msi -o chef-client-latest.msi
msiexec /qb /i chef-client-latest.msi

# Generate .bash_profile with various aliases
cat <<EOF > "$home_dir/.bash_profile"
alias chef-client="chef-client.bat"
alias chef-solo="chef-solo.bat"
alias facter="facter.bat"
alias gem="gem.bat"
alias irb="irb.bat"
alias ohai="ohai.bat"
alias puppet="puppet.bat"
alias ruby="ruby.exe"
EOF

# Create parallel to sudo command
cat <<EOF > /bin/sudo
#!/usr/bin/bash
exec "$@"
EOF
chmod 755 /bin/sudo

# Clean up
rm -rf 7z922-x64.msi $build_dir chef-client-latest.msi $ga_iso_path

# Shutdown
shutdown.exe /p /f /d p:4:1
