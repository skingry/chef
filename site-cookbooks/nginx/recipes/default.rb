#
# Cookbook Name:: nginx
# Recipe:: default
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

directory "/data" do
  owner "nobody"
  group "nogroup"
end

directory "/data/configs" do
  owner "nobody"
  group "nogroup"
end

directory "/data/configs/nginx" do
  owner "nobody"
  group "nogroup"
end

directory "/data/configs/nginx/sites" do
  owner "nobody"
  group "nogroup"
end

directory "/data/configs/nginx/webroot" do
  owner "nobody"
  group "nogroup"
end

cookbook_file "/data/configs/nginx/webroot/index.html" do
  owner "nobody"
  group "nogroup"
end

cookbook_file "/data/configs/nginx/webroot/50x.html" do
  owner "nobody"
  group "nogroup"
end

cookbook_file "/data/configs/nginx/webroot/explosion-animation.gif" do
  owner "nobody"
  group "nogroup"
end

cookbook_file "/data/configs/nginx/webroot/robot.gif" do
  owner "nobody"
  group "nogroup"
end

package "nginx"

service "nginx" do
  supports :enable => true, :restart => true, :start => true
  action :enable
end

cookbook_file "/etc/nginx/nginx.conf" do
  notifies :restart, "service[nginx]"
end

