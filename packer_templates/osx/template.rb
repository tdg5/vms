Racker::Processor.register_template do |osx|
  osx.variables = {
    'password' => 'vagrant',
    'username' => 'vagrant',
  }

  osx.builders['{{ user `vm_name` }}'] = {
    'boot_wait' => '2s',
    'disk_size' => 20480,
    'guest_additions_mode' => 'disable',
    'guest_os_type' => 'MacOS109_64',
    'hard_drive_interface' => 'sata',
    'iso_checksum_type' => '{{ user `iso_checksum_type` }}',
    'iso_checksum' => '{{ user `iso_checksum` }}',
    'iso_interface' => 'sata',
    'iso_url' => '{{ user `iso_url` }}',
    'shutdown_command' => 'echo "{{ user `password` }}" | sudo -S shutdown -h now',
    'ssh_password' => '{{ user `password` }}',
    'ssh_port' => 22,
    'ssh_username' => '{{ user `username` }}',
    'ssh_wait_timeout' => '10000s',
    'type' => 'virtualbox-iso',
    'vboxmanage' => [
      ['modifyvm', '{{ .Name }}', '--audiocontroller', 'hda'],
      ['modifyvm', '{{ .Name }}', '--boot1', 'dvd'],
      ['modifyvm', '{{ .Name }}', '--boot2', 'disk'],
      ['modifyvm', '{{ .Name }}', '--chipset', 'ich9'],
      ['modifyvm', '{{ .Name }}', '--firmware', 'efi'],
      ['modifyvm', '{{ .Name }}', '--hpet', 'on'],
      ['modifyvm', '{{ .Name }}', '--keyboard', 'usb'],
      ['modifyvm', '{{ .Name }}', '--memory', '2048'],
      ['modifyvm', '{{ .Name }}', '--mouse', 'usbtablet'],
      ['modifyvm', '{{ .Name }}', '--vram', '9'],
      ['setextradata', '{{ .Name }}', 'VBoxInternal2/EfiBootArgs', '-v'],
    ],
    'vm_name' => '{{ user `vm_name` }}',
  }

  osx.min_packer_version = '0.7.0'

  exec_cmd = 'chmod +x {{ .Path }}; sudo {{ .Vars }} {{ .Path }}'
  osx.provisioners = {
    1000 => {
      'setup_automatic_login' => {
        'destination' => '/private/tmp/kcpassword',
        'source' => 'scripts/support/kcpassword',
        'type' => 'file',
      },
      'install_base_system' => {
        'execute_command' => exec_cmd,
        'scripts' => [
          'scripts/vagrant.sh',
          'scripts/xcode-cli-tools.sh',
          'scripts/add-network-interface-detection.sh',
        ],
        'type' => 'shell',
      },
    },
    9000 => {
      'minimize_machine' => {
        'execute_command' => exec_cmd,
        'scripts' => [
          'scripts/minimize.sh',
        ],
        'type' => 'shell',
      },
    },
  }

  osx.postprocessors['vagrant'] = {
    'output' => '{{ user `vm_name` }}.box',
    'type' => 'vagrant',
  }
end
