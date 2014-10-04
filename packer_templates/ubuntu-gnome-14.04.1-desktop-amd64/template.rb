Racker::Processor.register_template do |gnome|
  gnome.variables = {
    'confdir' => '.',
    'iso_checksum' => '31ac57691a45a381ded0ab2a3588b77a',
    'iso_checksum_type' => 'md5',
    'iso_url' => 'http://cdimage.ubuntu.com/ubuntu-gnome/releases/14.04/release/ubuntu-gnome-14.04.1-desktop-amd64.iso',
    'password' => 'vagrant',
    'username' => 'vagrant',
    }

  gnome.builders['ubuntu-gnome-14.04.1-desktop-amd64'] = {
    'boot_command' => [
      '<enter><enter><esc><enter> <wait>',
      '/casper/vmlinuz.efi url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ',
      'hostname={{ .Name }} ',
      'initrd=/casper/initrd.lz boot=casper automatic-ubiquity noprompt --<enter><wait>',
    ],
    'boot_wait' => '4s',
    'guest_additions_mode' => 'disable',
    'guest_os_type' => 'Ubuntu_64',
    'hard_drive_interface' => 'sata',
    'headless' => false,
    'http_directory' => '{{ user `confdir` }}/http',
    'iso_checksum' => '{{ user `iso_checksum` }}',
    'iso_checksum_type' => '{{ user `iso_checksum_type` }}',
    'iso_url' => '{{ user `iso_url` }}',
    'shutdown_command' => 'echo {{ user `password` }} | sudo -S shutdown -P now',
    'ssh_password' => '{{ user `password` }}',
    'ssh_username' => '{{ user `username` }}',
    'ssh_port' => 22,
    'ssh_wait_timeout' => '10000s',
    'type' => 'virtualbox-iso',
    'vboxmanage' => [
      ['modifyvm', '{{ .Name }}', '--memory', '2048'],
      ['modifyvm', '{{ .Name }}', '--cpus', '2'],
    ],
    'virtualbox_version_file' => '.vbox_version',
    'vm_name' => 'ubuntu-gnome-14.04.1-desktop-amd64',
  }

  gnome.postprocessors['vagrant'] = {
    'type' => 'vagrant',
    'output' => 'ubuntu-gnome-14.04.1-desktop-amd64.box',
  }

  gnome.provisioners = {
    1000 => {
      'setup_root_and_vagrant_user' => {
        'override' => {
          'ubuntu-gnome-14.04.1-desktop-amd64' => {
            'execute_command' => 'echo {{ user `password` }} | sudo -S bash "{{ .Path }}"',
          },
        },
        'scripts' => [
          '{{ user `confdir` }}/scripts/root_setup.sh',
          '{{ user `confdir` }}/scripts/vagrant_setup.sh'
        ],
        'type' => 'shell',
      },

      'setup_user' => {
        'scripts' => [
          '{{ user `confdir` }}/scripts/user_setup.sh',
        ],
        'type' => 'shell',
      },
    },
  }
end
