#
# Cookbook Name:: plex
# Recipe:: default
#
# Copyright 2014, Seth Kingry
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apt"

apt_repository "plexhometheater" do
  uri "http://ppa.launchpad.net/plexapp/plexht/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
  keyserver "keyserver.ubuntu.com"
  key "EB7DFFFB"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

directory "/root/bin"

cookbook_file "/root/bin/backup-plex.sh" do
  mode "0755"
end

package 'nfs-common'

directory "/var/tmp"

mount "/var/tmp" do
  device "tmpfs"
  fstype "tmpfs"
  action [:mount, :enable]
  options "defaults,noatime,mode=1777,size=1024m"
end

