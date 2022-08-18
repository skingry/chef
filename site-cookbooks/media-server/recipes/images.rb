#
# Cookbook Name:: media-server
# Recipe:: images
#
# Copyright 2016, Seth Kingry
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

docker_image 'certbot/dns-route53' do
  action :pull
end

docker_image 'grafana/grafana' do
  action :pull
end

docker_image 'influxdb' do
  tag '1.8'
  action :pull
end

docker_image 'linuxserver/lidarr' do
  action :pull
end

docker_image 'itzg/minecraft-server' do
  action :pull
end

docker_image 'nginx' do
  action :pull
end

docker_image 'linuxserver/nzbget' do
  action :pull
end

docker_image 'dperson/openvpn-client' do
  action :pull
end

docker_image 'plexinc/pms-docker' do
  action :pull
  tag 'plexpass'
end

docker_image 'linuxserver/qbittorrent' do
  action :pull
end

docker_image 'linuxserver/radarr' do
  action :pull
end

docker_image 'linuxserver/sonarr' do
  action :pull
end

docker_image 'linuxserver/tautulli' do
  action :pull
end
