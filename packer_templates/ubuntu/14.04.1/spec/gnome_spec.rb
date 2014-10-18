Racker::Processor.register_template do |server|
  server.variables = {
    'target_host' => 'ubuntu-gnome-14.04.1-desktop-amd64',
  }

  server.provisioners = {
    7000 => {
      'copy_specs' => {
        'destination' => '/tmp/spec',
        'source' => File.expand_path('../../../../../spec', __FILE__),
        'type' => 'file',
      },
      'run_specs' => {
        'execute_command' => 'chmod +x {{ .Path }}; sudo {{ .Vars }} TARGET_HOST="{{ user `target_host` }}" {{ .Path }}',
        'scripts' => [
          'scripts/spec.sh',
        ],
        'type' => 'shell',
      },
    },
  }
end
