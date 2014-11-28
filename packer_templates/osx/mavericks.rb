load File.expand_path('../osx.rb', __FILE__)

Racker::Processor.register_template do |mavericks|
  mavericks.variables = {
    'iso_checksum' => '00a5420183525317dd3a16bbb25589a4',
    'iso_checksum_type' => 'md5',
    'iso_url' => 'packer_cache/OSX_InstallESD_10.9.5_13F34.dmg',
    'vm_name' => 'mavericks',
  }
end
