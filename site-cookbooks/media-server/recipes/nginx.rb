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

users = data_bag('users')

domain = node[:media_server][:domain]
name = 'nginx'
repo = "skingry/#{name}"

include_recipe 'media-server::directories'

directory "/data/configs/#{name}" do
  owner 'nobody'
  group 'nogroup'
end

directory "/data/configs/#{name}/sites" do
  owner 'nobody'
  group 'nogroup'
end

directory '/data/configs/nginx/logs'

directory '/data/configs/nginx/ssl'

docker_image "#{name}" do
  repo "#{repo}"
  action :pull
  notifies :redeploy, "docker_container[#{name}]"
end

docker_container "#{name}" do
  repo "#{repo}"
  network_mode 'host'
  volumes [ '/data:/data' ]
  restart_policy 'always'
end

users.each do |user|
  creds = data_bag_item('users', user)
  template '/data/configs/nginx/htpasswd' do
    variables(
      :user => creds['id'],
      :hash => creds['htpasswd']
    )
    notifies :restart, "docker_container[nginx]", :delayed
    not_if 'test -f /data/configs/nginx/htpasswd'
  end
end

