#!/bin/bash -e

SPEC_DIR='/tmp/spec'
RETURN_TO=$(pwd)

which bundle > /dev/null || gem install bundler --no-ri --no-rdoc > /dev/null

cd $SPEC_DIR
bundle install --path ._bundle > /dev/null
bundle exec rake spec

cd $RETURN_TO
rm -rf $SPEC_DIR > /dev/null
