#!/bin/bash

# Install ZFS
sudo apt-get -y install zfsutils-linux
sudo modprobe zfs

# Setup ZFS pool
if [ ! -d "/data" ]; then
  sudo zpool create -f tank raidz /dev/sdb /dev/sdc /dev/sdd /dev/sde
  sudo zfs create -o mountpoint=/data tank/data
  sudo zfs create -o mountpoint=/var/lib/docker tank/docker
fi

# Install Chef
sudo apt-get -y install build-essential curl dialog git python ruby ruby-dev wget
sudo gem install --no-ri --no-rdoc chef -v 12.9.38
sudo gem install --no-ri --no-rdoc berkshelf -v 4.3.2
sudo gem install --no-ri --no-rdoc bundler

# Run Chef
cd /chef
berks vendor cookbooks
cp sample-configs/vagrant.json data_bags/users/vagrant.json
sudo su - -c 'chef-solo -c /chef/solo/development.rb -j /chef/solo/configs/server.json'
