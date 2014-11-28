namespace :vms do

  RELEASE_TEMPLATES = %w[
    packer_templates/osx/mavericks.rb
    packer_templates/osx/yosemite.rb
    packer_templates/ubuntu/14.04.1/gnome.rb
    packer_templates/ubuntu/14.04.1/server.rb
    packer_templates/windows/7/homepremium.rb
    packer_templates/windows/7/professional.rb
    packer_templates/windows/8/professional.rb
  ].freeze

  desc 'Build all JSON templates for release.'
  task :compile_json_templates do
    require 'racker'

    RELEASE_TEMPLATES.each do |template|
      json_template_path = File.expand_path("../#{template[0..-4]}.json", __FILE__)
      template = Racker::Processor.new({
        :quiet => true,
        :templates => [ template ],
      }).execute!
      File.open(json_template_path, 'w') { |f| f.write(template) }
    end
  end

end
