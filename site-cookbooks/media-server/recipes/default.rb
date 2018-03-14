#
# Cookbook Name:: media-server
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

include_recipe 'apt'

package 'nvidia-384'

docker_installation_package 'default' do
  version '17.03.1'
  action :create
end

git '/root/Dockerfiles' do
  repository 'git://github.com/skingry/Dockerfiles.git'
  revision 'master'
  action :sync
end

docker_service 'default' do
  ipv6 false
  ipv6_forward false
  storage_driver 'zfs'
  action [:create, :start]
end

docker_image 'base' do
  source '/root/Dockerfiles/base'
  read_timeout 600
  write_timeout 600
  action :build_if_missing
end

include_recipe 'media-server::monitoring'

include_recipe 'media-server::openvpn'
include_recipe 'media-server::backup'
include_recipe 'media-server::certbot'
include_recipe 'media-server::plex-cleaner'

include_recipe 'media-server::samba'
include_recipe 'media-server::netatalk'

include_recipe 'media-server::influxdb'
include_recipe 'media-server::grafana'

include_recipe 'media-server::radarr'
include_recipe 'media-server::nzbget'
include_recipe 'media-server::sonarr'
include_recipe 'media-server::transmission'

include_recipe 'media-server::plex'

include_recipe 'media-server::plexpy'
include_recipe 'media-server::resilio'

include_recipe 'media-server::nginx'
