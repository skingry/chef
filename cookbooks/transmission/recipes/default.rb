#
# Cookbook Name:: transmission
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

include_recipe "nginx"

package "transmission" do
  action :install
end

user "transmission" do
  supports :manage_home => true
  comment "Transmission User"
  uid 1000
  gid "nogroup"
  home "/home/transmission"
  shell "/bin/bash"
end

directory "/opt/local/etc/nginx/sites-enabled" do
  action :create
end

directory "/var/run/transmission" do
  owner "transmission"
  group "nobody"
  action :create
end

template "/opt/local/etc/nginx/sites-enabled/transmission" do
  source "transmission.nginx.erb"
  notifies :restart, resources(:service => "nginx")
end

