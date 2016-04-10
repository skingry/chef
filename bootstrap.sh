#!/bin/bash

apt-add-repository --yes ppa:zfs-native/stable
apt-get update
apt-get -y install ubuntu-zfs
modprobe zfs
zpool create -f tank raidz /dev/sdb /dev/sdc /dev/sdd /dev/sde
zfs create -o mountpoint=/data tank/data
curl -L https://www.opscode.com/chef/install.sh | sudo bash
