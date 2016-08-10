#
# Cookbook Name:: docker-plex
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

package 'avahi-daemon'
package 'dbus'

remote_file '/tmp/plexmediaserver.deb' do
  source 'https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu'
end

bash 'Install Plex Media Server' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  dpkg -i /tmp/plexmediaserver.deb
  rm -rf /tmp/plexmediaserver.deb
  EOH
end

directory '/config' do
  owner 'nobody'
  group 'nogroup'
end

directory '/defaults'

cookbook_file '/defaults/plexmediaserver'

cookbook_file '/sbin/update_plex' do
  mode 0755
end

cookbook_file '/sbin/my_init' do
  mode 0755
end

