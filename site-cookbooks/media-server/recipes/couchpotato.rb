#
# Cookbook Name:: media-server
# Recipe:: couchpotato
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

docker_image 'couchpotato' do
  repo 'linuxserver/couchpotato'
  action :pull
  notifies :redeploy, 'docker_container[couchpotato]'
end

docker_container 'couchpotato' do
  repo 'linuxserver/couchpotato'
  port '5050:5050'
  host_name 'couchpotato'
  env [ 'PUID=65534', 'PGID=65534' ]
  volumes [ '/data/configs/couchpotato:/config', '/data:/data', '/data/Downloads/complete/movies:/downloads', '/data/Media/Movies:/movies' ]
end
