#!/bin/bash -e

SPEC_DIR='/tmp/spec'
RETURN_TO=$(pwd)
PACKAGES='libyaml0_2 ruby ruby-psych ruby-thor ruby-net-http-persistent rubygems ruby-bundler'

# Install apt-cyg package manager
wget http://apt-cyg.googlecode.com/svn/trunk/apt-cyg > /dev/null
chmod u+x apt-cyg

# Install ruby and dependencies
./apt-cyg install $PACKAGES > /dev/null

# Install serverspec bundle and test
cd $SPEC_DIR
bundle install --path ._bundle > /dev/null
bundle exec rake spec

# clean up
cd $RETURN_TO
./apt-cyg remove $PACKAGES > /dev/null
rm -rf $SPEC_DIR apt-cyg $0 > /dev/null
