shared_examples 'vagrant_box' do

  describe 'vagrant integration' do
    include_examples 'vagrant_box::chef'
    include_examples 'vagrant_box::gem'
    include_examples 'vagrant_box::ruby'
    include_examples 'vagrant_box::who_am_i'
    include_examples 'vagrant_box::whoami'
  end

end


shared_examples 'vagrant_box::chef' do

  describe command('. /etc/profile; chef-client --version 2> /dev/null 1>/dev/null; echo $?'), :sudo => false do
    its(:stdout) { should match('0') }
  end

end


shared_examples 'vagrant_box::gem' do

  describe command('. /etc/profile; gem --version 2> /dev/null 1> /dev/null; echo $?'), :sudo => false do
    its(:stdout) { should match('0') }
  end

end


shared_examples 'vagrant_box::ruby' do

  # Pointless, spec could not be running without ruby
  describe command('. /etc/profile; ruby --version 2> /dev/null 1> /dev/null; echo $?'), :sudo => false do
    its(:stdout) { should match('0') }
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
