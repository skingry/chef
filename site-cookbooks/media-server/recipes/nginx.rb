#
# Cookbook Name:: media-server
# Recipe:: nginx
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

domain = node[:media_server][:domain]
name = 'nginx'
config_dir = "/data/configs/#{name}"
repo = "skingry/#{name}"

include_recipe 'directories'
include_recipe 'nginx::config_files'

if node.chef_environment == 'development'
  directory "#{config_dir}/ssl/live"
  directory "#{config_dir}/ssl/live/#{node[:media_server][:domain]}"
  cookbook_file "#{config_dir}/ssl/live/#{node[:media_server][:domain]}/privkey.pem" do
    mode 0600
    notifies :restart, "docker_container[#{name}]", :delayed
  end
  cookbook_file "#{config_dir}/ssl/live/#{node[:media_server][:domain]}/fullchain.pem" do
    notifies :restart, "docker_container[#{name}]", :delayed
  end
end

docker_image "#{name}" do
  repo "#{repo}"
  action :pull
  notifies :redeploy, "docker_container[#{name}]"
end

docker_container "#{name}" do
  repo "#{repo}"
  links [ 'openvpn:couchpotato', 'openvpn:sabnzbd', 'openvpn:sonarr', 'openvpn:transmission', 'plexpy:plexpy', 'resilio:resilio' ]
  port [ '80:80', '443:443' ]
  volumes [ '/data:/data' ]
  restart_policy 'always'
end

hashes = Array.new

search(:users, "groups:sysadmin").each do |user|
  hashes.push("#{user['id']}:#{user['htpasswd']}")
end

file "#{config_dir}/htpasswd" do
  mode 0600
  content hashes.join("\n")
  notifies :restart, "docker_container[#{name}]", :delayed
  not_if "test -f #{config_dir}/htpasswd"
end

