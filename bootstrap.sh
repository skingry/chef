#!/bin/bash

# Check to see if an unattended upgrade is happening
i=0
tput sc
while sudo fuser /var/lib/dpkg/lock >/dev/null 2>&1 ; do
  case $(($i % 4)) in
    0 ) j="-" ;;
    1 ) j="\\" ;;
    2 ) j="|" ;;
    3 ) j="/" ;;
  esac
  tput rc
  echo -en "\r[$j] Waiting for other software managers to finish..."
  sleep 0.5
  ((i=i+1))
done

# Install ZFS
sudo apt-get -y install zfsutils-linux
sudo modprobe zfs

# Install Chef
sudo apt-get -y install build-essential curl dialog git python ruby ruby-dev ruby-shadow wget
sudo gem install --no-ri --no-rdoc chef -v 12.10.24
sudo gem install --no-ri --no-rdoc berkshelf -v 4.3.2
sudo gem install --no-ri --no-rdoc bundler

berks vendor cookbooks
chef-solo -c /root/chef/solo/config/production.rb -j /root/chef/solo/json/server.json
