shared_examples 'vagrant_box' do

  describe 'vagrant integration' do
    include_examples 'vagrant_box::who_am_i'
    include_examples 'vagrant_box::whoami'
  end

end


shared_examples 'vagrant_box::who_am_i' do

  describe command('who am i'), :sudo => false do
    its(:stdout) { should match('vagrant') }
  end

end


shared_examples 'vagrant_box::whoami' do

  describe command('whoami'), :sudo => true do
    its(:stdout) { should match('root') }
  end

end
