# VMs
[Packer](https://packer.io) templates for building
[Vagrant](https://www.vagrantup.com) boxes using
[VirtualBox](https://www.virtualbox.org/).

## ISOs
Due to potential copyright issues and the typically ephemeral nature of ISO
URLs, all Packer templates refer to ISOs as though they already live in the
packer_cache of their respective template. However, unlike normal ISOs cached by
Packer, the more cannonical ISO file names have been preserved with the hope
that the cannonical name will be easier to search for than the typical SHA256
sum of the ISO url provided by Packer. Typically, I keep a centralized cache of
ISOs and create symlinks from the various packer_cache dirs to the respective
ISOs in the centralized cache.

A list of known ISO URLs is available below. If you should find any of these
URLs no longer work or if you are aware of an alternate or missing URL, please
feel free to open an Issue or Pull Request.

### OSX
OSX ISOs can be built using an appropriate "Install OS X ${CODENAME}.app" and
Tim Sutton's [osx-vm-templates](https://github.com/timsutton/osx-vm-templates).
Be warned that unless you are using Apple hardware, the build process will fail.
There are ways around this, however, such endeavors are left as an exercise for
the reader.

### Ubuntu
[Ubuntu Gnome 14.04.1 amd64](http://cdimage.ubuntu.com/ubuntu-gnome/releases/14.04/release/ubuntu-gnome-14.04.1-desktop-amd64.iso)
[Ubuntu Server 14.04.1 amd64](http://releases.ubuntu.com/14.04.1/ubuntu-14.04.1-server-amd64.iso)

### Windows
[Windows 7 Home Premium SP1 x64](http://msft.digitalrivercontent.net/win/X17-24209.iso)
[Windows 7 Professional SP1 x64](http://msft.digitalrivercontent.net/win/X17-24281.iso)
Windows 8 Professional - Does not seem to be publicly available, however [an ISO
can generated from an existing Windows 8 Professional
install](http://www.howtogeek.com/186775/how-to-download-windows-7-8-and-8.1-installation-media-legally/).

## How to build Vagrant boxes
### Basic Setup
Packer, Vagrant, VirtualBox, and Ruby 2, are prerequisites for all templates.

Clone and install bundle:
```bash
  git clone https://github.com/tdg5/vms.git
  cd vms
  bundle install
```

### OSX
#### OSX Mavericks (10.9.5)
```bash
  cd packer_templates/osx/
  bundle exec racker mavericks.rb - | packer build -
```

#### OSX Yosemite (10.10.1)
```bash
  cd packer_templates/osx/
  bundle exec racker yosemite.rb - | packer build -
```

### Ubuntu
#### Ubuntu Gnome 14.04.1
```bash
  cd packer_templates/ubuntu/14.04.1/
  bundle exec racker gnome.rb - | packer build -
```

#### Ubuntu Server 14.04.1
```bash
  cd packer_templates/ubuntu/14.04.1/
  bundle exec racker server.rb - | packer build -
```

### Windows
#### Windows 7 Home Premium
```bash
  cd packer_templates/windows/7/
  bundle exec racker homepremium.rb - | packer build -
```

#### Windows 7 Professional
```bash
  cd packer_templates/windows/7/
  bundle exec racker professional.rb - | packer build -
```

#### Windows 8 Professional
```bash
  cd packer_templates/windows/8/
  bundle exec racker professional.rb - | packer build -
```

## Notes
All VMs are 64-bit.
