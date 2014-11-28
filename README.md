# VMs

My environment for developing vms

## How to build Vagrant boxes

### Basic Setup

### Ubuntu
#### Ubuntu Server 14.04.1
```bash
  cd packer_templates/ubuntu/14.04.1/
  racker server.rb - | packer build -
```

#### Ubuntu Gnome 14.04.1
```bash
  cd packer_templates/ubuntu/14.04.1/
  racker gnome.rb - | packer build -
```

### OSX
#### OSX Mavericks (10.9.5)
```bash
  cd packer_templates/osx/
  racker osx.rb mavericks.rb - | packer build -
```

#### OSX Yosemite (10.10)
```bash
  cd packer_templates/osx/
  racker osx.rb yosemite.rb - | packer build -
```

### Windows
#### Windows 7 Home Premium
```bash
  cd packer_templates/windows/7/
  racker homepremium.rb - | packer build -
```

#### Windows 7 Professional
```bash
  cd packer_templates/windows/7/
  racker professional.rb - | packer build -
```

#### Windows 8 Professional
```bash
  cd packer_templates/windows/8/
  racker professional.rb - | packer build -
```
