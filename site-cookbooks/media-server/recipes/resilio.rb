#
# Cookbook Name:: media-server
# Recipe:: resilio
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
name = 'resilio'
host = "#{name}"
port = '8888'
repo = "skingry/#{name}"

include_recipe 'directories'

directory "/data/configs/#{name}" do
  owner 'nobody'
  group 'nogroup'
end

docker_image "#{name}" do
  repo "#{repo}"
  action :pull
end

docker_container "#{name}" do
  repo "#{repo}"
  memory '1073741824'
  memory_swap '2147483648'
  port '55541:55541'
  volumes [ '/data:/data', '/dev/rtc:/dev/rtc:ro', '/etc/localtime:/etc/localtime:ro', '/data/configs/resilio:/.sync' ]
  restart_policy 'always'
end

template "/data/configs/nginx/sites/#{name}.conf" do
  source 'proxy_site.erb'
  variables :domain => "#{domain}",
            :host => "#{host}",
            :name => "#{name}",
            :port => "#{port}",
            :auth => false
end

