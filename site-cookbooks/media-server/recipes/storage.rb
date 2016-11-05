#
# Cookbook Name:: media-server
# Recipe:: storage
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

docker_service 'default' do
  ipv6 false
  ipv6_forward false
  storage_driver 'zfs'
  action [:create, :start]
end

include_recipe 'media-server::directories'
include_recipe 'media-server::backup'
include_recipe 'media-server::netatalk'
include_recipe 'media-server::nginx'
include_recipe 'media-server::certbot'
include_recipe 'media-server::nfs-server'
include_recipe 'media-server::plex'
include_recipe 'media-server::plex-cleaner'
include_recipe 'media-server::plexpy'
