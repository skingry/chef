#!/bin/bash

# Install ZFS
sudo apt-add-repository --yes ppa:zfs-native/stable
sudo apt-get update
sudo apt-get -y install ubuntu-zfs
sudo modprobe zfs

# Setup ZFS pool
if [ "${ZFS}" = 1 ]; then
  sudo zpool create -f tank raidz /dev/sdb /dev/sdc /dev/sdd /dev/sde
  sudo zfs create -o mountpoint=/data tank/data
  sudo zfs create -o mountpoint=/var/lib/docker tank/docker
fi

# Install Chef
sudo apt-get -y install build-essential curl dialog git ruby ruby-dev wget
sudo gem install --no-ri --no-rdoc chef -v 12.9.38
sudo gem install --no-ri --no-rdoc berkshelf -v 4.3.2
sudo gem install --no-ri --no-rdoc bundler

# Run Chef
berks vendor cookbooks
sudo su - -c 'chef-solo -c /chef/solo.rb -j /chef/configs/server.json'
