#
# Cookbook Name:: media-server
# Recipe:: plexpy
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

directory "/data/configs/plexpy" do
  owner "nobody"
  group "nogroup"
end

docker_image 'plexpy' do
  repo 'linuxserver/plexpy'
  action :pull
  notifies :redeploy, 'docker_container[plexpy]'
end

docker_container 'plexpy' do
  repo 'linuxserver/plexpy'
  port '8181:8181'
  host_name 'plexpy'
  env [ 'PUID=65534', 'PGID=65534' ]
  volumes [ '/data/configs/plexpy:/config', '/data/configs/plex/Library/Application Support/Plex Media Server/Logs:/logs:ro' ]
end

