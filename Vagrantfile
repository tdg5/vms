# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION ||= '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.define 'ubuntu-gnome' do |node|
    node.vm.box = 'ubuntu-gnome-14.04.1-desktop-amd64'
    node.vm.provider('virtualbox') { |vbox| vbox.gui = true }
  end

  config.vm.define 'ubuntu-server' do |node|
    node.vm.box = 'ubuntu-14.04.1-server-amd64'
  end

  config.vm.define 'osx-10.9.5' do |node|
    node.vm.box = 'osx-10.9.5'
    # Disable shared folders
    config.vm.synced_folder '.', '/vagrant', id: 'vagrant-root', :disabled => true
    node.vm.provider('virtualbox') { |vbox| vbox.gui = true }
  end

  config.vm.define 'win7-hp' do |node|
    node.vm.box = 'windows7-homepremium-x64'
    node.vm.communicator = 'winrm'
    node.vm.provider('virtualbox') { |vbox| vbox.gui = true }
  end

  config.vm.define 'win7-pro' do |node|
    node.vm.box = 'windows7-professional-x64'
    node.vm.communicator = 'winrm'
    node.vm.provider('virtualbox') { |vbox| vbox.gui = true }
  end

  config.vm.define 'win8-pro' do |node|
    node.vm.box = 'windows8-professional-x64'
    node.vm.communicator = 'winrm'
    node.vm.provider('virtualbox') { |vbox| vbox.gui = true }
  end
end
