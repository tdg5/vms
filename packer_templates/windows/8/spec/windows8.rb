Racker::Processor.register_template do |win8|
  win8.variables = {
    'target_host' => 'windows8',
  }

  win8.provisioners = {
    7000 => {
      'copy_specs' => {
        'destination' => '/tmp/spec',
        'source' => File.expand_path('../../../../../spec', __FILE__),
        'type' => 'file',
      },
      'run_specs' => {
        'execute_command' => 'chmod +x {{ .Path }}; {{ .Vars }} TARGET_HOST="{{ user `target_host` }}" {{ .Path }}',
        'scripts' => [
          '../lib/scripts/spec.sh',
        ],
        'type' => 'shell',
      },
    },
  }
end
