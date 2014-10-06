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

include_recipe "plex::prerequisites"

remote_file "/root/plexmediaserver.deb" do
  source "https://downloads.plex.tv/plex-media-server/0.9.9.14.531-7eef8c6/plexmediaserver_0.9.9.14.531-7eef8c6_amd64.deb"
  checksum "d4058c71e052"
end

bash "install plexmediaserver" do
  user "root"
  cwd "/root"
  code <<-EOH
  dpkg -i plexmediaserver.deb
  EOH
  not_if "ls /etc/init.d/plexmediaserver"
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

include_recipe "plex::plexwatch"

