#
# Cookbook Name:: media-server
# Recipe:: certbot
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

name = 'certbot'
repo = "skingry/#{name}"

docker_image "#{name}" do
  repo "#{repo}"
  action :pull
  notifies :redeploy, "docker_container[#{name}]"
end

docker_container "#{name}" do
  repo "#{repo}"
  network_mode 'host'
  volumes [ '/data:/data' ]
end

if node.chef_environment != 'development'
  cron "Certbot Certificate Renewal" do
    minute "0"
    hour "3"
    weekday "1"
    mailto "#{node[:cron_mailto]}"
    command "docker start -i #{name} && docker restart nginx"
  end
end

