require 'spec_helper'

set :os, :family => 'windows', :release => 'windows7', :arch => 'x86_64'
describe 'windows7' do
  include_examples 'vagrant_box'
end
