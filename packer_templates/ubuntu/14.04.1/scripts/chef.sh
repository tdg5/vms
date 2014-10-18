#!/bin/bash -e

# Chef and requirements
apt-get -q -y install curl > /dev/null
curl -L https://www.opscode.com/chef/install.sh | bash > /dev/null
