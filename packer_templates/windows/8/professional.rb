require_relative 'spec/windows8'

Racker::Processor.register_template do |win8pro|
  win8pro.variables = {
    'iso_checksum' => '1ce53ad5f60419cf04a715cf3233f247e48beec4',
    'iso_checksum_type' => 'sha1',
    'iso_url' => 'packer_cache/en_windows_8_x64_dvd_915440.iso',
    'password' => 'vagrant',
    'product_key' => '',
    'shutdown_command' => 'shutdown /s /t 1 /f /d p:4:1 /c "Packer Shutdown"',
    'username' => 'vagrant',
  }

  win8pro.builders['windows8-professional-x64'] = {
    'vm_name' => 'windows8-professional-x64',
    'type' => 'virtualbox-iso',
    'guest_os_type' => 'Windows8_64',
    'iso_url' => '{{ user `iso_url` }}',
    'iso_checksum' => '{{ user `iso_checksum` }}',
    'iso_checksum_type' => '{{ user `iso_checksum_type` }}',
    'ssh_username' => '{{ user `username` }}',
    'ssh_password' => '{{ user `password` }}',
    'ssh_wait_timeout' => '10000s',
    'floppy_files' => [
      '../lib/floppy/8/professional/Autounattend.xml',
      '../lib/floppy/00-run-all-scripts.cmd',
      '../lib/floppy/install-winrm.cmd',
      '../lib/floppy/powerconfig.bat',
      '../lib/floppy/01-install-wget.cmd',
      '../lib/floppy/_download.cmd',
      '../lib/floppy/_packer_config.cmd',
      '../lib/floppy/passwordchange.bat',
      '../lib/floppy/cygwin.sh',
      '../lib/floppy/cygwin.bat',
      '../lib/floppy/zz-start-sshd.cmd',
      '../lib/floppy/oracle-cert.cer',
    ],
    'shutdown_command' => '{{ user `shutdown_command` }}',
    'disk_size' => 122880,
    'vboxmanage' => [
      ['modifyvm', '{{ .Name }}', '--memory', '768'],
      ['modifyvm', '{{ .Name }}', '--cpus', '1'],
    ]
  }

  win8pro.provisioners = {
    1000 => {
      'install_base_system' => {
        'type' => 'shell',
        'remote_path' => '/tmp/script.bat',
        'execute_command' => 'cmd /c $(/bin/cygpath -m "{{ .Path }}")',
        'scripts' => [
          '../lib/scripts/vagrant.bat',
          '../lib/scripts/vmtool.bat',
        ],
      },
      'clean_up' => {
        'type' => 'shell',
        'inline' => ['rm -f /tmp/script.bat'],
      },
    },
    9000 => {
      'install_base_system' => {
        'type' => 'shell',
        'remote_path' => '/tmp/script.bat',
        'execute_command' => 'cmd /c $(/bin/cygpath -m "{{ .Path }}")',
        'scripts' => [
          '../lib/scripts/clean.bat',
          '../lib/scripts/ultradefrag.bat',
          '../lib/scripts/uninstall-7zip.bat',
          '../lib/scripts/sdelete.bat',
        ],
      },
      'clean_up' => {
        'type' => 'shell',
        'inline' => ['rm -f /tmp/script.bat'],
      },
    },
  }

  win8pro.postprocessors['vagrant'] = {
    'compression_level' => 1,
    'keep_input_artifact' => false,
    'output' => 'windows8-professional-x64.box',
    'type' => 'vagrant',
  }
end
