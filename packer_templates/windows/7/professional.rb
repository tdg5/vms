require_relative 'spec/windows7'

Racker::Processor.register_template do |win7pro|
  win7pro.variables = {
    'boot_wait' => '1200s',
    'iso_url' => 'http://msft.digitalrivercontent.net/win/X17-24281.iso',
    'iso_checksum' => '5ed2584110e03f498db4458ba9fafd5a7ef602ed',
    'iso_checksum_type' => 'sha1',
    'password' => 'vagrant',
    'product_key' => '',
    'shutdown_command' => 'shutdown /s /t 10 /f /d p:4:1 /c "Packer Shutdown"',
    'username' => 'vagrant',
  }

  win7pro.builders['windows7-professional-x64'] = {
    'vm_name' => 'windows7-professional-x64',
    'type' => 'virtualbox-iso',
    'guest_os_type' => 'Windows7_64',
    'iso_url' => '{{ user `iso_url` }}',
    'iso_checksum' => '{{ user `iso_checksum` }}',
    'iso_checksum_type' => '{{ user `iso_checksum_type` }}',
    'boot_command' => [
      '{{ user `product_key` }}<tab> <tab><tab><tab> <wait>'
    ],
    'boot_wait' => '{{ user `boot_wait` }}',
    'ssh_username' => '{{ user `username` }}',
    'ssh_password' => '{{ user `password` }}',
    'ssh_wait_timeout' => '10000s',
    'floppy_files' => [
      '../lib/floppy/7/professional/Autounattend.xml',
      '../lib/floppy/00-run-all-scripts.cmd',
      '../lib/floppy/install-winrm.cmd',
      '../lib/floppy/fixnetwork.ps1',
      '../lib/floppy/powerconfig.bat',
      '../lib/floppy/01-install-wget.cmd',
      '../lib/floppy/_download.cmd',
      '../lib/floppy/_packer_config.cmd',
      '../lib/floppy/passwordchange.bat',
      '../lib/floppy/networkprompt.bat',
      '../lib/floppy/cygwin.sh',
      '../lib/floppy/cygwin.bat',
      '../lib/floppy/zz-start-sshd.cmd',
      '../lib/floppy/oracle-cert.cer',
    ],
    'shutdown_command' => '{{ user `shutdown_command` }}',
    'disk_size' => 40960,
    'vboxmanage' => [
      ['modifyvm', '{{ .Name }}', '--memory', '768'],
      ['modifyvm', '{{ .Name }}', '--cpus', '1'],
    ],
  }

  win7pro.provisioners = {
    1000 => {
      'setup_system' => {
        'type' => 'shell',
        'remote_path' => '/tmp/script.bat',
        'execute_command' => 'cmd /c $(/bin/cygpath -m "{{ .Path }}")',
        'scripts' => [
          '../lib/scripts/vagrant.bat',
          '../lib/scripts/vmtool.bat',
        ],
      },
      'cleanup' => {
        'type' => 'shell',
        'inline' => ['rm -f /tmp/script.bat'],
      },
    },
    9000 => {
      'setup_system' => {
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
      'cleanup' => {
        'type' => 'shell',
        'inline' => ['rm -f /tmp/script.bat'],
      },
    },
  }

  win7pro.postprocessors['vagrant'] = {
    'compression_level' => 1,
    'keep_input_artifact' => false,
    'output' => 'windows7-professional-x64.box',
    'type' => 'vagrant',
  }
end
