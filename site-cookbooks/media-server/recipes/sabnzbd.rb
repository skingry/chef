#
# Cookbook Name:: media-server
# Recipe:: sabnzbd
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
name = 'sabnzbd'
port = '8080'
repo = "skingry/#{name}"

include_recipe 'media-server::directories'

directory "/data/configs/#{name}" do
  owner 'nobody'
  group 'nogroup'
end

docker_image "#{name}" do
  repo "#{repo}"
  action :pull
  notifies :redeploy, "docker_container[#{name}]"
end

docker_container "#{name}" do
  repo "#{repo}"
  network_mode 'host'
  volumes [ "/data/configs/#{name}:/config", '/data:/data', '/etc/localtime:/etc/localtime:ro' ]
  restart_policy 'always'
end

template "/data/configs/nginx/sites/#{name}.conf" do
  source 'proxy_site.erb'
  notifies :restart, 'service[nginx]'
  variables :domain => "#{domain}",
            :name => "#{name}",
            :port => "#{port}",
            :environment => "#{node.chef_environment}",
            :auth => 'true'
end

