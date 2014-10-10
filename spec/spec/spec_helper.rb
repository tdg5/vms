require 'serverspec'
require 'net/ssh'

set :backend, :exec

Dir[File.expand_path('../shared/**/*.rb', __FILE__)].each do |shared_specs|
  require shared_specs
end
