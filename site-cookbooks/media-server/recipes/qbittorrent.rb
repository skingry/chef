#
# Cookbook Name:: media-server
# Recipe:: qbittorrent
#
# Copyright 2020, Seth Kingry
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

docker_image 'linuxserver/qbittorrent' do
  action :pull
end

docker_container 'qbittorrent' do
  repo 'linuxserver/qbittorrent'
  memory '1024M'
  network_mode 'container:openvpn'
  env [ 'PGID=65534', 'PUID=65534' ]
  volumes [
            '/data/configs/qbittorrent:/config',
            '/data/shares/Downloads:/downloads'
          ]
  restart_policy 'always'
end
