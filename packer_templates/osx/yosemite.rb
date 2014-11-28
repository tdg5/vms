load File.expand_path('../osx.rb', __FILE__)

Racker::Processor.register_template do |yosemite|
  yosemite.variables = {
    'iso_checksum' => '2c64999a00ef1f2f017132c37384e557',
    'iso_checksum_type' => 'md5',
    'iso_url' => 'packer_cache/OSX_InstallESD_10.10.1_14B25.dmg',
    'vm_name' => 'yosemite',
  }
end
