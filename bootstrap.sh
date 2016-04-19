#!/bin/bash

sudo apt-add-repository --yes ppa:zfs-native/stable
sudo apt-get update
sudo apt-get -y install ubuntu-zfs
sudo modprobe zfs
sudo zpool create -f tank raidz /dev/sdb /dev/sdc /dev/sdd /dev/sde
sudo zfs create -o mountpoint=/data tank/data
sudo zfs create -o mountpoint=/var/lib/docker tank/docker
curl -L https://www.opscode.com/chef/install.sh | sudo bash
sudo su - -c 'chef-solo -c /home/vagrant/chef/development.rb'
