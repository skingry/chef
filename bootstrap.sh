#!/bin/bash

apt-add-repository --yes ppa:zfs-native/stable
apt-get update
apt-get -y install ubuntu-zfs

