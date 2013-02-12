set -x

# Create the home directory
mkdir -p /home/vagrant
chown vagrant /home/vagrant
cd /home/vagrant

# Install ssh certificates
mkdir /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cd /home/vagrant/.ssh
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' -O authorized_keys
chown -R vagrant /home/vagrant/.ssh
cd ..

# Install rpm,apt-get like code for cygwin
# http://superuser.com/questions/40545/upgrading-and-installing-packages-through-the-cygwin-command-line
wget http://apt-cyg.googlecode.com/svn/trunk/apt-cyg
chmod +x apt-cyg
mv apt-cyg /usr/local/bin/

# 7zip will allow us to extract a file from an ISO
wget http://downloads.sourceforge.net/sevenzip/7z922-x64.msi
msiexec /qb /i 7z922-x64.msi

# Download Virtualbox Additions
VBOX_VERSION="4.1.12" #"4.0.8"
wget http://download.virtualbox.org/virtualbox/$VBOX_VERSION/VBoxGuestAdditions_$VBOX_VERSION.iso

# Extract the installer from the ISO (WHY WHY WHY isn't this available not bundled within an ISO)
/cygdrive/c/Program\ Files/7-Zip/7z.exe x VBoxGuestAdditions_$VBOX_VERSION.iso VBoxWindowsAdditions-amd64.exe

# Mark Oracle as a trusted installer
#http://blogs.msdn.com/b/steverac/archive/2009/07/09/adding-certificates-to-the-local-certificates-store-and-setting-local-policy-using-a-command-line-system-center-updates-publisher-example.aspx

certutil -addstore -f "TrustedPublisher" a:oracle-cert.cer

# Install the Virtualbox Additions
./VBoxWindowsAdditions-amd64.exe /S


#Rather than do the manual install of ruby and chef, just use the opscode msi
curl -L http://www.opscode.com/chef/install.msi -o chef-client-latest.msi
msiexec /qb /i chef-client-latest.msi


#http://www.msfn.org/board/topic/105277-howto-create-a-fully-up-to-date-xp-x64-dvd/

#Making aliases
cat <<EOF > /home/vagrant/.bash_profile
alias chef-client="chef-client.bat"
alias chef-solo="chef-solo.bat"
alias gem="gem.bat"
alias ruby="ruby.exe"
alias puppet="puppet.bat"
alias ohai="ohai.bat"
alias irb="irb.bat"
alias facter="facter.bat"
EOF


cat <<'EOF' > /bin/sudo
#!/usr/bin/bash
exec "$@"
EOF
chmod 755 /bin/sudo

# Mounting a directory, but silence stderr because will fail until reboot
net.exe use  '\\vboxsvr\veewee-validation' 2>/dev/null


# Reboot
# http://www.techrepublic.com/blog/datacenter/restart-windows-server-2003-from-the-command-line/245
shutdown.exe /r /t 0 /d p:2:4 /c "Vagrant initial reboot"

#wget http://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B461B745B-599D-6E61-6963-AB379DA6EB24%7D%26lang%3Den%26browser%3D2%26usagestats%3D0%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26installdataindex%3Ddefaultbrowser/edgedl/chrome/install/GoogleChromeStandaloneEnterprise.msi
#msiexec /qn /i GoogleChromeStandaloneEnterprise.msi
