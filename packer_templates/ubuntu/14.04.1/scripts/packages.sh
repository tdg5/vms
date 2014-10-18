#!/bin/bash -e

sudo apt-get update -y -q > /dev/null
sudo apt-get -q -y install linux-headers-$(uname -r) build-essential dkms > /dev/null
sudo apt-get -q -y install virtualbox-guest-{dkms,source,utils} > /dev/null
