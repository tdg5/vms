Racker::Processor.register_template do |osx|
  osx.variables = {
    'target_host' => 'osx',
  }

  osx.provisioners = {
    7000 => {
      'copy_specs' => {
        'destination' => '/tmp/spec',
        'source' => File.expand_path('../../../../spec', __FILE__),
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
