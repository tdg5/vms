# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION ||= '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define 'ubuntu-gnome' do |node|
    node.vm.box = 'ubuntu-gnome-14.04.1-desktop-amd64'
  end

  config.vm.define 'ubuntu-server' do |node|
    node.vm.box = 'ubuntu-14.04.1-server-amd64'
  end

  config.vm.define 'win7' do |node|
    node.vm.box = 'windows7-homepremium'
    node.vm.communicator = 'winrm'
  end
end
