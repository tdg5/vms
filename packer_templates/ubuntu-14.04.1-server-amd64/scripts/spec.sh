#!/bin/bash -e

SPEC_DIR='/tmp/spec'
RETURN_TO=$(pwd)
RUBY_PKG='ruby1.9.3'

apt-get -q -y install $RUBY_PKG > /dev/null
which bundler > /dev/null || gem install bundler --no-ri --no-rdoc > /dev/null

cd $SPEC_DIR
bundle install --path ._bundle > /dev/null
bundle exec rake spec

cd $RETURN_TO
rm -rf $SPEC_DIR > /dev/null

# TODO: Remove bundler if installed?
apt-get --purge -q -y remove $RUBY_PKG > /dev/null
