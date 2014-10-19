require 'spec_helper'

set :os, :family => 'windows', :release => 'windows8', :arch => 'x86_64'
describe 'windows8' do
  include_examples 'vagrant_box'
end
