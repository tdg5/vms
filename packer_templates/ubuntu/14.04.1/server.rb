load File.expand_path('../spec/server.rb', __FILE__)

Racker::Processor.register_template do |server|
  server.variables = {
    'iso_checksum' => 'ca2531b8cd79ea5b778ede3a524779b9',
    'iso_checksum_type' => 'md5',
    'iso_url' => 'http://releases.ubuntu.com/14.04/ubuntu-14.04.1-server-amd64.iso',
    'password' => 'vagrant',
    'username' => 'vagrant',
  }

  server.builders['ubuntu-14.04.1-server-amd64'] = {
    'boot_command' => [
      '<esc><wait>',
      '<esc><wait>',
      '<enter><wait>',
      '/install/vmlinuz<wait>',
      ' auto<wait>',
      ' console-setup/ask_detect=false<wait>',
      ' console-setup/layoutcode=us<wait>',
      ' console-setup/modelcode=pc105<wait>',
      ' debconf/frontend=noninteractive<wait>',
      ' debian-installer=en_US<wait>',
      ' fb=false<wait>',
      ' initrd=/install/initrd.gz<wait>',
      ' kbd-chooser/method=us<wait>',
      ' keyboard-configuration/layout=USA<wait>',
      ' keyboard-configuration/variant=USA<wait>',
      ' locale=en_US<wait>',
      ' netcfg/get_domain=vm<wait>',
      ' netcfg/get_hostname=vagrant<wait>',
      ' noapic<wait>',
      ' preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed_server.cfg<wait>',
      ' -- <wait>',
      '<enter><wait>'
    ],
    'boot_wait' => '10s',
    'disk_size' => 122880,
    'guest_additions_path' => 'VBoxGuestAdditions_{{ .Version }}.iso',
    'guest_os_type' => 'Ubuntu_64',
    'http_directory' => 'http',
    'iso_checksum' => '{{ user `iso_checksum` }}',
    'iso_checksum_type' => '{{ user `iso_checksum_type` }}',
    'iso_url' => '{{ user `iso_url` }}',
    'shutdown_command' => 'echo "shutdown -P now" > shutdown.sh; echo "{{ user `password` }}" | sudo -S sh "shutdown.sh"',
    'ssh_password' => '{{ user `password` }}',
    'ssh_port' => 22,
    'ssh_username' => '{{ user `username` }}',
    'ssh_wait_timeout' => '10000s',
    'type' => 'virtualbox-iso',
    'vboxmanage' => [
      ['modifyvm', '{{ .Name }}', '--memory', '384'],
      ['modifyvm', '{{ .Name }}', '--cpus', '1']
    ],
    'virtualbox_version_file' => '.vbox_version',
    'vm_name' => 'ubuntu-14.04.1-server-amd64',
  }

  server.postprocessors['vagrant'] = {
    'type' => 'vagrant',
    'output' => 'ubuntu-14.04.1-server-amd64.box',
  }

  override = {
    'ubuntu-14.04.1-server-amd64' => {
      'execute_command' => 'echo "{{ user `password` }}" | sudo -S bash "{{ .Path }}"',
    },
  }
  server.provisioners = {
    1000 => {
      'setup_machine' => {
        'override' => override,
        'scripts' => [
          'scripts/packages.sh',
          'scripts/vagrant.sh',
          'scripts/networking.sh',
        ],
        'type' => 'shell',
      },
    },
    9000 => {
      'minimize_machine' => {
        'override' => override,
        'scripts' => [
          'scripts/minimize.sh',
        ],
        'type' => 'shell',
      },
    },
  }
end
